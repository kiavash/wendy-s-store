package com.mattstine.wendysstore.domain
class Product {
  String name
  String description
  List prices
  Boolean featured = false
  Image fullSizeImage
  Image mediumImage
  Image thumbnailImage
  List customizations

  static constraints = {
    name(blank:false)
    description(blank:false,maxSize:1000)
    fullSizeImage(nullable:true)
    mediumImage(nullable:true)
    thumbnailImage(nullable:true)
  }

  static belongsTo = [category:ProductCategory]

  static hasMany = [customizations:Customization, prices:Price]

  static mapping = {
    sort: "name"
  }

  
}
