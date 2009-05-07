package com.mattstine.wendysstore.controllers

import com.mattstine.wendysstore.domain.Order
import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured (['ROLE_ADMIN'])
class OrdersController {

    def index = {
      redirect action:'list'
    }

    def list = {
      [orders:Order.list(params)]
    }

    def show = {
      [order:Order.get(params.id)]  
    }
}
