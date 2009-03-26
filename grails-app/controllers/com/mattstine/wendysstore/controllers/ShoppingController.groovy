package com.mattstine.wendysstore.controllers

import com.mattstine.wendysstore.domain.OrderItem
import com.mattstine.wendysstore.domain.Product
import com.mattstine.wendysstore.domain.ProductCategory

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
    shoppingCartService.addToShoppingCart(new OrderItem(product: product), params.quantity.toInteger())
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
        totalCharge += com.metasieve.shoppingcart.Shoppable.findByShoppingItem(item).product.price * shoppingCartService.getQuantity(item)
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
}
