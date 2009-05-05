package com.mattstine.wendysstore.domain

import org.grails.paypal.Payment

class Order implements Serializable {

  static hasMany = [orderItems: OrderItem]

  User user
  String deliveryMethod
  Address shippingAddress
  Payment payment
  CouponCode couponCode

  static constraints = {
    deliveryMethod(blank: false)
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
    return total - getAmountOff(total)
  }

  def getAmountOff(def total) {
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
