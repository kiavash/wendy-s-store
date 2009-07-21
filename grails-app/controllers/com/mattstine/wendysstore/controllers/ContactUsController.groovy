package com.mattstine.wendysstore.controllers

import com.mattstine.wendysstore.domain.ContactUs
import org.codehaus.groovy.grails.plugins.springsecurity.Secured

class ContactUsController {

  def recaptchaService

  def index = {
    def config = recaptchaService.getRecaptchaConfig()
    [publicKey: config.recaptcha.publicKey]
  }

  def sendMessage = {
    if (evaluateCaptcha(request.getRemoteAddr(), params.recaptcha_challenge_field, params.recaptcha_response_field)) {
      withForm {
        def msg = new ContactUs(params['msg'])

        if (msg.save()) {
          sendMail {
            to "matt.stine@gmail.com"
            from "contactus@duckduckgoosedesigns.com"
            subject "Message from Contact Us Form at DuckDuckGooseDesigns.com!"
            html g.render(template:"email", model: [message: msg]) 
          }

          render(template: 'messageSent')
        } else {
          render(template: 'errors', model: [message: msg])
        }
      }.invalidToken {
        render(template: 'tokenError')
      }
    } else {
      render(template: 'recaptchaError')
    }

  }

  private def evaluateCaptcha(def remoteIp, def challenge, def response) {
    def config = recaptchaService.getRecaptchaConfig()

    def urlString = "http://api-verify.recaptcha.net/verify"
    def queryString = "privatekey=${config.recaptcha.privateKey}&remoteip=${remoteIp}&challenge=${challenge}&response=${URLEncoder.encode(response)}"

    def url = new URL(urlString)
    def connection = url.openConnection()
    connection.setRequestMethod("POST")
    connection.doOutput = true

    Writer writer = new OutputStreamWriter(connection.outputStream)
    writer.write(queryString)
    writer.flush()
    writer.close()
    connection.connect()

    def recaptchaResponse = connection.content.text
    log.debug(recaptchaResponse)

    recaptchaResponse.startsWith("true")
  }

  @Secured (['ROLE_ADMIN'])
  def showMessages = {
    [messages: ContactUs.list(params)]
  }

  def reRenderCaptcha = {
    render(template: 'recaptcha')
  }
}
