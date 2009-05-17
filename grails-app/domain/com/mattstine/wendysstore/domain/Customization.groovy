package com.mattstine.wendysstore.domain

class Customization implements Serializable {
  String label
  CustomizationType type
  Boolean chargeable = false
  BigDecimal price
  SortedSet choices
  Boolean required = false

  static hasMany = [choices: CustomizationChoice]

  static constraints = {
    price(nullable: true,
            scale: 2,
            validator: { value, object ->
              if (value != null && value < 0) return "price.invalid.negative"

              if (object.chargeable && value == null) return "price.null.with.chargeable"
            })
  }

}
