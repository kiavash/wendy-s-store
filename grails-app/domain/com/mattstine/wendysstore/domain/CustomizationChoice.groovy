package com.mattstine.wendysstore.domain

import java.text.DecimalFormat

class CustomizationChoice implements Serializable, Comparable {

  String label
  Boolean chargeable = false
  BigDecimal price
  Integer sortIndex

  int compareTo(obj) {
    sortIndex.compareTo(obj.sortIndex)
  }

  static constraints = {
    price(nullable: true,
            scale: 2,
            validator: {value, object ->
              if (value != null && value < 0) return "price.invalid.negative"

              if (object.chargeable && value == null) return "price.null.with.chargeable"
            })
  }

  static transients = ['display']

  def getDisplay() {
    def decimalFormat = new DecimalFormat("\$0.00")
    if (chargeable) {
      return "${label} (${decimalFormat.format(price)})"
    } else {
      return label
    }
  }
}
