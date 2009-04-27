package com.mattstine.wendysstore.domain
class Product implements Comparable, Serializable {
  String name
  String description
  List prices
  Boolean featured = false
  Image fullSizeImage
  Image mediumImage
  Image thumbnailImage
  List customizations
  Long sortIndex

  static constraints = {
    name(blank:false)
    description(blank:false,maxSize:1000)
    fullSizeImage(nullable:true)
    mediumImage(nullable:true)
    thumbnailImage(nullable:true)
    sortIndex(nullable:true)
  }

  static belongsTo = [category:ProductCategory]

  static hasMany = [customizations:Customization, prices:Price]

  static mapping = {
    sort: "name"
  }

  int compareTo(obj) {
    sortIndex.compareTo(obj.sortIndex)
  }

  //When inserting a new product, always assign it's initial sortIndex as the previous max sortIndex...(i.e. insert it at the
  //bottom of the list).
  def beforeInsert = {
    def maxSortIndex = Product.executeQuery("select max(sortIndex) from Product")
    if (maxSortIndex[0]) {
      sortIndex = maxSortIndex[0] + 1
    } else {
      sortIndex = 1
    }
  }

  
}
