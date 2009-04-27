package com.mattstine.wendysstore.domain
class Image implements Serializable {
      String path
      String name
      static belongsTo = [product:Product,category:ProductCategory]

      static constraints = {
        product(nullable:true)
        category(nullable:true)
      }
}
