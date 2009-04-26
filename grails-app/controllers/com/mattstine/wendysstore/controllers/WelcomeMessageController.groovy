package com.mattstine.wendysstore.controllers

class WelcomeMessageController {

    def index = { }

    def update = {
      servletContext.setAttribute("welcomeMessage",params.value)
      render params.value
    }
}
