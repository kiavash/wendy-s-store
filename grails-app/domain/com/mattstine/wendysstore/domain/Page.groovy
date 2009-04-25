package com.mattstine.wendysstore.domain

class Page {

  String sidebarLinkTitle
  String pageTitle
  String pageContent
  Long sortIndex

  static constraints = {
    sidebarLinkTitle(blank: false)
    pageTitle(blank: false)
    pageContent(blank: false, maxSize: 4000)
    sortIndex(nullable: true)
  }

  def beforeInsert = {
    def maxSortIndex = Product.executeQuery("select max(sortIndex) from Page")
    if (maxSortIndex[0]) {
      sortIndex = maxSortIndex[0] + 1
    } else {
      sortIndex = 1
    }
  }
}
