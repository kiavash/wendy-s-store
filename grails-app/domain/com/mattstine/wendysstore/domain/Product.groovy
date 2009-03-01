package com.mattstine.wendysstore.domain
class Product {
  String name
  String description
  BigDecimal price
  Boolean featured = false
  //com.mattstine.wendysstore.domain.Image thumbnail

  static constraints = {
    description(maxSize:1000)
  }

  static belongsTo = [category:ProductCategory]

  static hasMany = [images:Image,
          customizations:Customization]

  static mapping = {
    sort: "name"
  }

  
}
