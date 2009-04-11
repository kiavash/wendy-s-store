package com.mattstine.wendysstore.domain

import java.text.DecimalFormat

class Price {

    String description
    BigDecimal price

    static DecimalFormat format = new DecimalFormat("\$0.00")

    String getDisplay() {
      "${description} (${format.format(price)})"  
    }

    static transients = ['display']

    static constraints = {
      price(scale:2, validator: {
        if (it < 0) return "price.invalid.negative"
      })
    }
}
