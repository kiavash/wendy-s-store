package com.mattstine.wendysstore.domain

import com.mattstine.wendysstore.domain.CustomizationItem
import com.mattstine.wendysstore.domain.CustomizationType
import com.mattstine.wendysstore.domain.Price
import com.mattstine.wendysstore.domain.Product

class OrderItem extends com.metasieve.shoppingcart.Shoppable {

  Product product
  Price price

  static hasMany = [customizationItems: CustomizationItem]

  //This is necessary for inhertance hierarchies across an association (GRAILS-3588)
  static mapping = { customizationItems(lazy: false) }

  static transients = ['totalPrice']

  BigDecimal getTotalPrice() {

    BigDecimal totalPrice = 0.00

    totalPrice += price.price

    customizationItems.each {customizationItem ->
      if (customizationItem.customization.type == CustomizationType.CHOICESET) {
        if (customizationItem.customizationChoice.chargeable) {
          totalPrice += customizationItem.customizationChoice.price
        }
      } else {
        if (customizationItem.customization.chargeable) {
          totalPrice += customizationItem.customization.price
        }
      }
    }

    totalPrice

  }

}
