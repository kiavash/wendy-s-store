package com.mattstine.wendysstore.taglib

class TinyUrlTaglibTagLib {

  def tinyurlService

  def renderTinyLink = { attrs, body ->
    log.debug("Link: ${attrs.link}")
    def tinyUrl = tinyurlService.tiny(attrs.link)
    out << tinyUrl
  }

}
