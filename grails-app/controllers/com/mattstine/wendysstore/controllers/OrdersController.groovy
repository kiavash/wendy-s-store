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

    def shipOrder = {
      def order = Order.get(params.id)
      if (order.shipped) {
        order.shipped = false
      } else {
        order.shipped = true
      }
      order.save()
      render "OK"
    }

    def listUnshippedOrders = {
      render (view:'list', model:[orders:Order.findAllByShipped(false)])
    }

    def listShippedOrders = {
      render (view:'list', model:[orders:Order.findAllByShipped(true)])
    }
}
