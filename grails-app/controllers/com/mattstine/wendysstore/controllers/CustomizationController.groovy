package com.mattstine.wendysstore.controllers

import com.mattstine.wendysstore.domain.Customization
import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import com.mattstine.wendysstore.domain.CustomizationChoice

@Secured(['ROLE_ADMIN'])
class CustomizationController {

  static navigation = [
          title: 'Manage Customizations',
          action: 'index',
          subItems: [
                  [action: 'list', title: 'List Customizations'],
                  [action: 'create', title: 'New Customization']

          ]
  ]

  def index = { redirect(action: list, params: params) }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
    [customizationInstanceList: Customization.list(params), customizationInstanceTotal: Customization.count()]
  }

  def show = {
    def customizationInstance = Customization.get(params.id)
    def customizationChoiceInstance = new CustomizationChoice()

    if (!customizationInstance) {
      flash.message = "Customization not found with id ${params.id}"
      redirect(action: list)
    }
    else { return [customizationInstance: customizationInstance, customizationChoiceInstance: customizationChoiceInstance] }
  }

  def delete = {
    def customizationInstance = Customization.get(params.id)
    if (customizationInstance) {
      try {
        customizationInstance.delete()
        flash.message = "Customization ${params.id} deleted"
        redirect(action: list)
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = "Customization ${params.id} could not be deleted"
        redirect(action: show, id: params.id)
      }
    }
    else {
      flash.message = "Customization not found with id ${params.id}"
      redirect(action: list)
    }
  }

  def edit = {
    def customizationInstance = Customization.get(params.id)

    if (!customizationInstance) {
      flash.message = "Customization not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      return [customizationInstance: customizationInstance]
    }
  }

  def update = {
    def customizationInstance = Customization.get(params.id)
    if (customizationInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (customizationInstance.version > version) {

          customizationInstance.errors.rejectValue("version", "customization.optimistic.locking.failure", "Another user has updated this Customization while you were editing.")
          render(view: 'edit', model: [customizationInstance: customizationInstance])
          return
        }
      }
      customizationInstance.properties = params
      if (!customizationInstance.hasErrors() && customizationInstance.save()) {
        flash.message = "Customization ${params.id} updated"
        redirect(action: show, id: customizationInstance.id)
      }
      else {
        render(view: 'edit', model: [customizationInstance: customizationInstance])
      }
    }
    else {
      flash.message = "Customization not found with id ${params.id}"
      redirect(action: edit, id: params.id)
    }
  }

  def create = {
    def customizationInstance = new Customization()
    customizationInstance.properties = params
    return ['customizationInstance': customizationInstance]
  }

  def save = {
    def customizationInstance = new Customization(params)
    if (!customizationInstance.hasErrors() && customizationInstance.save()) {
      flash.message = "Customization ${customizationInstance.id} created"
      redirect(action: show, id: customizationInstance.id)
    }
    else {
      render(view: 'create', model: [customizationInstance: customizationInstance])
    }
  }

  def addChoice = {
    def choice = new CustomizationChoice(params)
    def customization = Customization.get(params.customizationId)
    customization.addToChoices(choice)
    customization.save()
    redirect(action: show, id: params.customizationId)
  }

  def deleteChoice = {
    def customization = Customization.get(params.customizationId)
    def choice = CustomizationChoice.get(params.id)
    customization.removeFromChoices(choice)
    customization.save()
    choice.delete()
    redirect(action: show, id: params.customizationId)
  }

  def editChoice = {
    def customizationChoiceInstance = CustomizationChoice.get(params.id)
    def customizationInstance = Customization.get(params.customizationId)
    render(view: 'show', model: [customizationInstance: customizationInstance, customizationChoiceInstance: customizationChoiceInstance])
  }

  def updateChoice = {
    def choice = CustomizationChoice.get(params.id)
    choice.properties = params
    choice.save()
    redirect(action: show, id: params.customizationId)
  }
}
