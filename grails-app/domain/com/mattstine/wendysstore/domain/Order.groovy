package com.mattstine.wendysstore.domain
class Order implements Serializable {

  static hasMany = [orderItems: OrderItem]

  Address shippingAddress
  Payment payment
  CouponCode couponCode

  static constraints = {
    shippingAddress(nullable: true)
    payment(nullable: true)
    couponCode(nullable: true)
  }

  static mapping = {
    table 'orders'
  }

  static transients = ['totalCharge', 'subTotal', 'amountOff']

  def getTotalCharge() {
    def subTotal = getSubtotal()
    if (couponCode != null) {
      return applyCouponCode(subTotal)
    } else {
      return subTotal
    }
  }

  private def applyCouponCode(def total) {
    return total - getAmountOff()
  }

  def getAmountOff() {
    switch (couponCode.type) {
      case CouponCodeType.PERCENT_OFF:
        return total * couponCode.amount / 100
      case CouponCodeType.DOLLARS_OFF:
        return couponCode.amount
    }
  }

  def getSubtotal() {
    def subtotal = 0.00

    orderItems.each() {item ->
      subtotal += item.totalPrice * item.quantity
    }

    return subtotal
  }
}
