package com.mattstine.wendysstore.controllers

import com.mattstine.wendysstore.domain.*
import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import org.grails.paypal.Payment
import org.grails.paypal.PaymentItem

class ShoppingController {

  def shoppingService
  def shoppingCartService
  def authenticateService

  def index = { }

  def category = {

    def selectedCategory = ProductCategory.get(params.id)

    if (selectedCategory.subCategories.size() == 0) {
      render(view: "products", model: [category: selectedCategory])
    } else {
      render(view: "subCategories", model: [category: selectedCategory])
    }

  }

  def addProductToCart = {
    def errors = []
    def product = Product.get(params.id)
    def price = Price.get(params.priceId)
    def orderItem = new OrderItem(product: product, price: price)
    def quantity = params.quantity && params.quantity.trim() != "" ? params.quantity.toInteger() : null

    if (quantity != null && quantity > 0) {
      params.each {key, value ->
        def matcher = key =~ /customization(.)/
        if (matcher.matches()) {
          def customizationId = matcher[0][1]
          log.debug "${customizationId} -> ${value}"
          def customization = Customization.get(customizationId.toLong())

          if (customization.required && value == "") {
            errors.add("${customization.label} is required!")
          } else if (value != "") {
            orderItem.addToCustomizationItems(CustomizationItem.getInstance(customization, value))
          }
        }
      }

    } else {
      errors.add("Quantity must be greater than or equal to 1!")
    }

    if (errors.size() == 0) {
      shoppingCartService.addToShoppingCart(orderItem, quantity)
      render(template: 'productAdded', model: [product: product])
    } else {
      render(template: 'errors', model: [errors: errors])
    }
  }

  def viewCart = {
    def modelMap = [:]
    modelMap.numberOfItems = shoppingCartService.getItems()?.size()

    if (modelMap.numberOfItems > 0) {
      def totalCharge = shoppingService.calculateTotalChargeForCart()
      modelMap.totalCharge = totalCharge
    }

    render(view: "cart", model: modelMap)
  }

  def updateQuantity = {
    def quantity = params.quantity && params.quantity.trim() != "" ? params.quantity.toInteger() : null
    if (quantity != null && quantity > 0) {
      def orderItem = com.metasieve.shoppingcart.Shoppable.get(params.id)
      shoppingCartService.removeFromShoppingCart(orderItem, shoppingCartService.getQuantity(orderItem))
      shoppingCartService.addToShoppingCart(orderItem, quantity)
    } else {
      flash.message = "Quantity must be greater than or equal to 1!"
    }
    redirect(action: "viewCart")
  }

  def deleteItemFromCart = {
    def orderItem = com.metasieve.shoppingcart.Shoppable.get(params.id)
    shoppingCartService.removeFromShoppingCart(orderItem, shoppingCartService.getQuantity(orderItem))
    redirect(action: "viewCart")
  }

  @Secured (['ROLE_USER'])
  def processOrderFlow = {
    init {
      action {
        def user = authenticateService.userDomain()
        user = User.get(user.id)

        def order = new Order()
        shoppingCartService.getItems().each {scItem ->
          def orderItem = com.metasieve.shoppingcart.Shoppable.findByShoppingItem(scItem)
          orderItem.quantity = shoppingCartService.getQuantity(scItem)
          order.addToOrderItems(orderItem)
        }
        [order: order, person: user]
      }
      on("success").to "reviewOrderDetails"
    }

    reviewOrderDetails {
      on("applyCouponCode") {
        def couponCode = CouponCode.findByCode(params.couponCode)
        if (couponCode) {
          flow.order.couponCode = couponCode
        } else {
          flash.message = "Unrecognized coupon code."
        }
      }.to "reviewOrderDetails"

      on("addShippingAddress") {
        [address: new Address(), userId: params.userId]
      }.to "addShippingAddress"

      on("checkout").to "checkout"
    }

    checkout {
      action { CheckoutCommand cmd ->
        if (cmd.validate()) {

          //Need to empty the shopping cart obviously - will refactor this out when I move
          //to a shopping cart implementation based on webflow
          shoppingCartService.checkOut()

          def user = authenticateService.userDomain()
          flow.order.user = User.get(user.id)

          flow.order.deliveryMethod = cmd.deliveryMethod
          if (CheckoutCommand.SHIP == cmd.deliveryMethod) {
            flow.order.shippingAddress = Address.get(cmd.shippingAddress)
          }

          def payment = new Payment()
          payment.buyerId = flow.order.user.id

          flow.order.orderItems.each { orderItem ->
            def paymentItem = new PaymentItem()

            if (flow.order.couponCode) {
              if (flow.order.couponCode.type == CouponCodeType.PERCENT_OFF) {
                paymentItem.amount = orderItem.totalPrice - (orderItem.totalPrice * flow.order.couponCode.amount / 100)
              }

            //TODO: Handle dollar off coupons...lovely PayPal doesn't accept negative amount line items, so having
            //TODO: to remove the discount on each item

            } else {
              paymentItem.amount = orderItem.totalPrice
            }
            paymentItem.quantity = orderItem.quantity
            paymentItem.itemName = orderItem.product.name
            paymentItem.itemNumber = orderItem.product.id
            payment.addToPaymentItems(paymentItem)
          }



          flow.order.payment = payment.save()
          flow.order.save(flush:true)

          def redirectParamMap = [:]

          redirectParamMap.returnController = 'shopping'
          redirectParamMap.returnAction = 'success'
          redirectParamMap.cancelController = 'shopping'
          redirectParamMap.cancelAction = 'cancel'

          redirectParamMap.transactionId = payment.transactionId
          if (CheckoutCommand.LOCAL_PICKUP == cmd.deliveryMethod) {
            redirectParamMap.noShipping = "true"
          } else if (CheckoutCommand.SHIP == cmd.deliveryMethod) {
            redirectParamMap.addressOverride = "true"
            redirectParamMap.firstName = flow.order.user.firstName
            redirectParamMap.lastName = flow.order.user.lastName
            redirectParamMap.addressLineOne = flow.order.shippingAddress.addressLineOne
            if (flow.order.shippingAddress.addressLineTwo) {
              redirectParamMap.addressLineTwo = flow.order.shippingAddress.addressLineTwo
            }
            redirectParamMap.city = flow.order.shippingAddress.city
            redirectParamMap.state = flow.order.shippingAddress.state
            redirectParamMap.zipCode = flow.order.shippingAddress.zipCode
            redirectParamMap.areaCode = flow.order.shippingAddress.areaCode
            redirectParamMap.phonePrefix = flow.order.shippingAddress.phonePrefix
            redirectParamMap.phoneSuffix = flow.order.shippingAddress.phoneSuffix
          }

          [redirectParamMap: redirectParamMap]


        } else {
          "fail"
        }
      }
      on ("success").to "uploadCart"
      on ("fail").to "reviewOrderDetails"
    }

    uploadCart()

    addShippingAddress {
      on("save").to("saveShippingAddress")
    }

    saveShippingAddress {
      action {
        def user = User.get(params.userId)
        def address = new Address(params)

        if (!address.hasErrors() && address.validate()) {     
          if (address.defaultAddress) {
            addressService.saveAddressAsNewDefault(user, address)
          } else {
            user.addToShippingAddresses(address)
            user.save()
          }

          flash.message = "Address \"${address.name}\" added."
          "success"
        } else {
          "fail"
        }
      }
      on("success").to "reviewOrderDetails"
      on("fail").to "addShippingAddress"
    }

  }

  def showShippingAddress = {
    def address = Address.get(params.id)
    render(template: 'shippingAddress', model: [address: address])
  }

  @Secured (['ROLE_ADMIN'])
  def sortProducts = {
    TreeMap rowMap = new TreeMap()

    params.each {key, value ->
      def matcher = key =~ /productRow(.*)\[\]/
      if (matcher.matches()) {
        def rowId = matcher[0][1]
        rowMap[rowId] = value
      }
    }

    def productIds = []
    rowMap.values().each {row ->
      row.each {
        productIds << it.toLong()
      }
    }

    shoppingService.saveProductSortOrder(productIds)

    render("Product sort order saved!")
  }

  @Secured (['ROLE_ADMIN'])
  def sortCategories = {
    TreeMap rowMap = new TreeMap()

    params.each {key, value ->
      def matcher = key =~ /subCategoryRow(.*)\[\]/
      if (matcher.matches()) {
        def rowId = matcher[0][1]
        rowMap[rowId] = value
      }
    }

    def categoryIds = []
    rowMap.values().each {row ->
      row.each {
        categoryIds << it.toLong()
      }
    }

    log.debug(categoryIds)

    shoppingService.saveCategorySortOrder(categoryIds)

    render("Category sort order saved!")
  }

  def success = {
    def payment = Payment.findByTransactionId(params.transactionId)
    def order = Order.findByPayment(payment)

    [payment:payment, order:order]
  }

  def cancel = { }

}

class CheckoutCommand {
  static final LOCAL_PICKUP = 'Local Pickup'
  static final SHIP = 'Ship'

  String deliveryMethod
  String shippingAddress

  static constraints = {
    deliveryMethod(blank: false)
    shippingAddress(constraint: {
      if (LOCAL_PICKUP == deliveryMethod) {
        if (!shippingAddress || "" == shippingAddress.trim()) {
          return "invalid.address.for.shipping"
        }
      }
    })
  }
}