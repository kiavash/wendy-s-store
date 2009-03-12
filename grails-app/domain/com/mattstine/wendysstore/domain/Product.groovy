package com.mattstine.wendysstore.domain
class Product {
  String name
  String description
  BigDecimal price
  Boolean featured = false
  Image image
  //com.mattstine.wendysstore.domain.Image thumbnail

  static constraints = {
    description(maxSize:1000)
    image(nullable:true)
  }

  static belongsTo = [category:ProductCategory]

  static hasMany = [customizations:Customization]

  static mapping = {
    sort: "name"
  }

  
}
