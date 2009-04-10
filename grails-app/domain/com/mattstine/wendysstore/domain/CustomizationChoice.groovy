package com.mattstine.wendysstore.domain

import java.text.DecimalFormat

class CustomizationChoice {

    String label
    Boolean chargeable = false
    BigDecimal price

    static constraints = {
      price(nullable:true)
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
