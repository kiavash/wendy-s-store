package com.mattstine.wendysstore.taglib

import com.mattstine.wendysstore.domain.ProductCategory

class DisplayProductCategoryBreadcrumbsTagLib {

  def productCategoryBreadcrumbs = { attrs, body ->
      def admin = attrs.admin ? true : false
      traverseAncestry(out, attrs.category, admin)
  }

  def traverseAncestry(Writer out, ProductCategory productCategory, Boolean admin) {
    if (productCategory.parentCategory) {
      traverseAncestry(out, productCategory.parentCategory, admin)
      out << " &gt; "
    }

    if (admin) {
      out << link(action:'show', controller:'productCategory', id:productCategory.id) { productCategory.name }
    } else {
      out << link(action:'category', controller:'shopping', id:productCategory.id) { productCategory.name }  
    }
  }

}
