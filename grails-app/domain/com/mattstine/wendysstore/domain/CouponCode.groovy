package com.mattstine.wendysstore.domain

class CouponCode implements Serializable {

    String code
    CouponCodeType type
    BigDecimal amount = 0.0

    static constraints = {
      code(blank:false)
      amount(validator: {
        if (it < 0) return "couponcodeamount.invalid.negative"
      })
    }
}
