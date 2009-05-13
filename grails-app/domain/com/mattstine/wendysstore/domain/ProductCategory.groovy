package com.mattstine.wendysstore.domain
class ProductCategory implements Comparable, Serializable {
  String name
  String description
  ProductCategory parentCategory
  SortedSet products
  SortedSet subCategories
  Long sortIndex
  Image image

  static hasMany = [products: Product, subCategories: ProductCategory]

  static constraints = {
    description(nullable: true, blank: true, maxSize:1000)
    parentCategory(nullable: true)
    sortIndex(nullable: true)
    image(nullable:true)
  }

  static mapping = {
    subCategories sort: "name"
    parentCategory lazy: false
  }

  static transients = ['breadcrumbs']

  int compareTo(obj) {
    sortIndex.compareTo(obj.sortIndex)
  }

  def getBreadcrumbs() {
    def out = ""
    out = traverseAncestry(this, out)
    out
  }

  def traverseAncestry(ProductCategory productCategory, def out) {
    if (productCategory.parentCategory) {
      out = traverseAncestry(productCategory.parentCategory, out)
      out += " > "

    }

    out += productCategory.name
    out
  }

  static def findAllMinusMe(def me) {
    def all = ProductCategory.findAll()
    all.remove(me)
    return all
  }

  def beforeInsert = {
    def maxSortIndex = Product.executeQuery("select max(sortIndex) from ProductCategory")
    if (maxSortIndex[0]) {
      sortIndex = maxSortIndex[0] + 1
    } else {
      sortIndex = 1
    }
  }

}
