package com.mattstine.wendysstore.taglib

class TinyUrlTaglibTagLib {

  def tinyurlService

  def renderTinyLink = { attrs, body ->
    def tinyUrl = tinyurlService.tiny(attrs.link)
    out << tinyUrl
  }

}
