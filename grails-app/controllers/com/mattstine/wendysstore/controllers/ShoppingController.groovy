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
    render(view: "cart")
  }

  def updateQuantities = {

    params.findAll {key, value ->
      key.startsWith("quantityForItem")
    }.each {key, value ->
      def matcher = (key =~ /quantityForItem([0-9+])/)
      def orderItemId = matcher[0][1]

      def orderItem = com.metasieve.shoppingcart.Shoppable.get(orderItemId.toLong())

      shoppingCartService.removeFromShoppingCart(orderItem, shoppingCartService.getQuantity(orderItem))
      shoppingCartService.addToShoppingCart(orderItem, value.toInteger())
    }

    render(view: "cart")
  }

  def updateQuantity 

  def deleteItemFromCart = {

    def nameOfButtonClicked = params.find {key, value ->
      key.startsWith("deleteItem")
    }

    def matcher = (nameOfButtonClicked =~ /deleteItem([0-9+])/)
    def orderItemId = matcher[0][1]

    def orderItem = com.metasieve.shoppingcart.Shoppable.get(orderItemId.toLong())

    shoppingCartService.removeFromShoppingCart(orderItem, shoppingCartService.getQuantity(orderItem))
  }
}
