package com.mattstine.wendysstore.domain
class Image {
      String path
      String name
      static belongsTo = [product:Product]
}
