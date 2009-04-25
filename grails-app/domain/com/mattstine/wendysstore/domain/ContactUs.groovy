package com.mattstine.wendysstore.domain

class ContactUs {

    String name
    String email
    String message
    Date dateCreated

    static constraints = {
      name(blank:false)
      email(blank:false)
      message(blank:false,maxSize:1000)
    }
}
