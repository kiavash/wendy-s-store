package com.mattstine.wendysstore.controllers

import com.mattstine.wendysstore.domain.*

class ShoppingController {

  def shoppingCartService

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

    def product = Product.get(params.id)
    def price = Price.get(params.priceId)

    def orderItem = new OrderItem(product: product, price: price)

    def errors = []

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

    if (errors.size() == 0) {
      shoppingCartService.addToShoppingCart(orderItem, params.quantity.toInteger())
      render(template: 'productAdded', model: [product: product])
    } else {
      render(template: 'errors', model: [errors: errors])
    }
  }

  def viewCart = {
    def modelMap = [:]
    modelMap.numberOfItems = shoppingCartService.getItems()?.size()

    if (modelMap.numberOfItems > 0) {
      def totalCharge = 0.00

      shoppingCartService.getItems().each() {item ->
        totalCharge += com.metasieve.shoppingcart.Shoppable.findByShoppingItem(item).totalPrice * shoppingCartService.getQuantity(item)
      }

      modelMap.totalCharge = totalCharge
    }

    render(view: "cart", model: modelMap)
  }

  def updateQuantity = {
    def orderItem = com.metasieve.shoppingcart.Shoppable.get(params.id)
    shoppingCartService.removeFromShoppingCart(orderItem, shoppingCartService.getQuantity(orderItem))
    shoppingCartService.addToShoppingCart(orderItem, params.quantity.toInteger())
    redirect(action: "viewCart")
  }

  def deleteItemFromCart = {
    def orderItem = com.metasieve.shoppingcart.Shoppable.get(params.id)
    shoppingCartService.removeFromShoppingCart(orderItem, shoppingCartService.getQuantity(orderItem))
    redirect(action: "viewCart")
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
}