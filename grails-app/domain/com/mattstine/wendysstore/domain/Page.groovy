package com.mattstine.wendysstore.domain

class Page {

    String sidebarLinkTitle
    String pageTitle
    String pageContent

    static constraints = {
      sidebarLinkTitle(blank:false)
      pageTitle(blank:false)
      pageContent(blank:false,maxSize:4000)
    }
}
