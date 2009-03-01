package com.mattstine.wendysstore.domain
class OrderItem {
  //com.mattstine.wendysstore.domain.Product product

  static hasMany = [customizationItems:CustomizationItem]
}
