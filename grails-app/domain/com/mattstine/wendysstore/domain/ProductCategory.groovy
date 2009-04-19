package com.mattstine.wendysstore.domain
class ProductCategory {
  String name
  ProductCategory parentCategory
  SortedSet products
  Set subCategories

  static hasMany = [products:Product, subCategories:ProductCategory]

  static constraints = {
    parentCategory(nullable: true)
  }

  static mapping = {
    subCategories sort: "name"
    parentCategory lazy:false
  }

  static transients = ['breadcrumbs']

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

}
