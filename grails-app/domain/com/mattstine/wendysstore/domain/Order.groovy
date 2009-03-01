package com.mattstine.wendysstore.domain
class Order {
  static hasMany = [orderItem:OrderItem]
  static belongsTo = [customer:Customer]

  Address shippingAddress
  Address billingAddress
  Payment payment

   static mapping = {
      table 'orders'
   }
}
