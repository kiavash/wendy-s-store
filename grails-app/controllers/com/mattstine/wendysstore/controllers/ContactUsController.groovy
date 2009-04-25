package com.mattstine.wendysstore.controllers

import com.mattstine.wendysstore.domain.ContactUs
import org.codehaus.groovy.grails.plugins.springsecurity.Secured

class ContactUsController {

  def recaptchaService

  def index = { }

  def sendMessage = {
    if (recaptchaService.verifyAnswer(session, request.getRemoteAddr(), params)) {
      recaptchaService.cleanUp(session)

      def msg = new ContactUs(params['msg'])

      if (msg.save()) {
        render(template: 'messageSent')
      } else {
        render(template: 'errors', model: [message: msg])
      }
    } else {
      render(template: 'recaptchaError')
    }
  }

  @Secured (['ROLE_ADMIN'])
  def showMessages = {
    [messages: ContactUs.list(params)]
  }
}
