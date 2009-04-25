package com.mattstine.wendysstore.domain
class Order {
  static hasMany = [orderItem:OrderItem]

  Address shippingAddress
  Payment payment

   static mapping = {
      table 'orders'
   }
}
