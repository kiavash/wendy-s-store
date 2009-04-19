package com.mattstine.wendysstore.controllers

import com.mattstine.wendysstore.domain.Page

class PageController {

  def index = { redirect(action: list, params: params) }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
    [pageInstanceList: Page.list(params), pageInstanceTotal: Page.count()]
  }

  def show = {
    def pageInstance = Page.get(params.id)

    if (!pageInstance) {
      flash.message = "Page not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      log.debug(pageInstance.pageContent)
      return [pageInstance: pageInstance]
    }
  }

  def delete = {
    def pageInstance = Page.get(params.id)
    if (pageInstance) {
      try {
        pageInstance.delete()
        flash.message = "Page ${params.id} deleted"
        redirect(action: list)
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = "Page ${params.id} could not be deleted"
        redirect(action: show, id: params.id)
      }
    }
    else {
      flash.message = "Page not found with id ${params.id}"
      redirect(action: list)
    }
  }

  def edit = {
    def pageInstance = Page.get(params.id)

    if (!pageInstance) {
      flash.message = "Page not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      return [pageInstance: pageInstance]
    }
  }

  def update = {
    def pageInstance = Page.get(params.id)
    if (pageInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (pageInstance.version > version) {

          pageInstance.errors.rejectValue("version", "page.optimistic.locking.failure", "Another user has updated this Page while you were editing.")
          render(view: 'edit', model: [pageInstance: pageInstance])
          return
        }
      }
      pageInstance.properties = params
      if (!pageInstance.hasErrors() && pageInstance.save()) {
        flash.message = "Page ${params.id} updated"
        redirect(action: show, id: pageInstance.id)
      }
      else {
        render(view: 'edit', model: [pageInstance: pageInstance])
      }
    }
    else {
      flash.message = "Page not found with id ${params.id}"
      redirect(action: edit, id: params.id)
    }
  }

  def create = {
    def pageInstance = new Page()
    pageInstance.properties = params
    return ['pageInstance': pageInstance]
  }

  def save = {
    def pageInstance = new Page(params)
    if (!pageInstance.hasErrors() && pageInstance.save()) {
      flash.message = "Page ${pageInstance.id} created"
      redirect(action: show, id: pageInstance.id)
    }
    else {
      render(view: 'create', model: [pageInstance: pageInstance])
    }
  }

  def preview = {
//    log.debug(params.text)
    log.debug(params.text.encodeAsTextile())
//    log.debug(params.text.getClass())
    render(template: 'textile', model: [text: params.text])
  }
}
