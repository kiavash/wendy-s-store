package com.mattstine.wendysstore.domain

class Customization {
  String label
  CustomizationType type
  Boolean chargeable = false
  BigDecimal price
  Set choices
  Boolean required = false

  static hasMany = [choices:CustomizationChoice]

  static constraints = {
    price(nullable:true)
  }

  

}
