package com.mattstine.wendysstore.controllers

import com.mattstine.wendysstore.domain.*
import org.codehaus.groovy.grails.plugins.springsecurity.Secured

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
      def totalCharge = calculateTotalChargeForCart()
      modelMap.totalCharge = totalCharge
    }

    render(view: "cart", model: modelMap)
  }

  def calculateTotalChargeForCart() {
    def totalCharge = 0.00

    shoppingCartService.getItems().each() {item ->
      totalCharge += com.metasieve.shoppingcart.Shoppable.findByShoppingItem(item).totalPrice * shoppingCartService.getQuantity(item)
    }
    return totalCharge
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
  def prepareOrder = {
    def user = authenticateService.userDomain()
    user = User.get(user.id)
    [totalCharge: calculateTotalChargeForCart(), person: user]
  }

  def checkout = {

    def checkedOutItems = shoppingCartService.checkOut()

    def url = new StringBuffer("https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_cart&upload=1")
    url << "&business=seller_1237686842_biz@mattstine.com"

    def incrementalItemId = 1
    checkedOutItems.each() {
      url << "&item_name_${incrementalItemId}=${com.metasieve.shoppingcart.Shoppable.findByShoppingItem(it['item']).product.name}"
      url << "&amount_${incrementalItemId}=${com.metasieve.shoppingcart.Shoppable.findByShoppingItem(it['item']).totalPrice}"
      url << "&quantity_${incrementalItemId}=${it['qty']}"
      incrementalItemId++
    }

    redirect(url: url)

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
    rowMap.values().each { row ->
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
    rowMap.values().each { row ->
      row.each {
        categoryIds << it.toLong()
      }
    }

    log.debug(categoryIds)

    shoppingService.saveCategorySortOrder(categoryIds)

    render("Category sort order saved!")
  }
}