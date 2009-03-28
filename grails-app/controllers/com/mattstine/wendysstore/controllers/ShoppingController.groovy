package com.mattstine.wendysstore.controllers

import com.mattstine.wendysstore.domain.OrderItem
import com.mattstine.wendysstore.domain.Product
import com.mattstine.wendysstore.domain.ProductCategory
import com.mattstine.wendysstore.domain.Price

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
    shoppingCartService.addToShoppingCart(new OrderItem(product: product, price: price), params.quantity.toInteger())
    render """
      ${product.name} has been added to your cart.
      <script type="javascript">\$('ajaxMessage').setStyle({visibility: 'visible'});</script>
      """
  }

  def viewCart = {
    def modelMap = [:]
    modelMap.numberOfItems = shoppingCartService.getItems()?.size()

    if (modelMap.numberOfItems > 0) {
      def totalCharge = 0.00

      shoppingCartService.getItems().each() { item ->
        totalCharge += com.metasieve.shoppingcart.Shoppable.findByShoppingItem(item).price.price * shoppingCartService.getQuantity(item)
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
    redirect(view: "viewCart")
  }

  def checkout = {

    def checkedOutItems = shoppingCartService.checkOut()

    def url = new StringBuffer("https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_cart&upload=1")
    url << "&business=seller_1237686842_biz@mattstine.com"

    def incrementalItemId = 1
    checkedOutItems.each() {
      url << "&item_name_${incrementalItemId}=${com.metasieve.shoppingcart.Shoppable.findByShoppingItem(it['item']).product.name}"
      url << "&amount_${incrementalItemId}=${com.metasieve.shoppingcart.Shoppable.findByShoppingItem(it['item']).price.price}"
      url << "&quantity_${incrementalItemId}=${it['qty']}"
      incrementalItemId++
    }

    redirect(url:url)

  }
}
