package com.mattstine.wendysstore.controllers

import com.mattstine.wendysstore.domain.ProductCategory

class ProductCategoryController {

  static navigation = [
          title : 'Manage Categories',
          action : 'index',
          subItems : [
                  [action:'list',title: 'List Categories'],
                  [action:'create', title: 'New Category']

          ]
  ]

  def index = { redirect(action: list, params: params) }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
    [productCategoryInstanceList: ProductCategory.list(params), productCategoryInstanceTotal: ProductCategory.count()]
  }

  def show = {
    def productCategoryInstance = ProductCategory.get(params.id)

    if (!productCategoryInstance) {
      flash.message = "ProductCategory not found with id ${params.id}"
      redirect(action: list)
    }
    else { return [productCategoryInstance: productCategoryInstance] }
  }

  def delete = {
    def productCategoryInstance = ProductCategory.get(params.id)
    if (productCategoryInstance) {
      try {
        productCategoryInstance.delete()
        flash.message = "ProductCategory ${params.id} deleted"
        redirect(action: list)
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = "ProductCategory ${params.id} could not be deleted"
        redirect(action: show, id: params.id)
      }
    }
    else {
      flash.message = "ProductCategory not found with id ${params.id}"
      redirect(action: list)
    }
  }

  def edit = {
    def productCategoryInstance = ProductCategory.get(params.id)

    if (!productCategoryInstance) {
      flash.message = "ProductCategory not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      return [productCategoryInstance: productCategoryInstance]
    }
  }

  def update = {
    def productCategoryInstance = ProductCategory.get(params.id)
    if (productCategoryInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (productCategoryInstance.version > version) {

          productCategoryInstance.errors.rejectValue("version", "productCategory.optimistic.locking.failure", "Another user has updated this com.mattstine.wendysstore.domain.ProductCategory while you were editing.")
          render(view: 'edit', model: [productCategoryInstance: productCategoryInstance])
          return
        }
      }
      productCategoryInstance.properties = params

      /*log.debug("params = ${params}")

      def parent = ProductCategory.get(params.parentCategory)
      productCategoryInstance.parentCategory = parent

      def subCategories = ProductCategory.findAllByIdInList(params.subCategories)
      productCategoryInstance.subCategories = subCategories*/

      if (!productCategoryInstance.hasErrors() && productCategoryInstance.save()) {
        flash.message = "ProductCategory ${params.id} updated"
        redirect(action: show, id: productCategoryInstance.id)
      }
      else {
        render(view: 'edit', model: [productCategoryInstance: productCategoryInstance])
      }
    }
    else {
      flash.message = "ProductCategory not found with id ${params.id}"
      redirect(action: edit, id: params.id)
    }
  }

  def create = {
    def productCategoryInstance = new ProductCategory()
    productCategoryInstance.properties = params
    return ['productCategoryInstance': productCategoryInstance]
  }

  def save = {
    def productCategoryInstance = new ProductCategory(params)
    if (!productCategoryInstance.hasErrors() && productCategoryInstance.save()) {
      flash.message = "ProductCategory ${productCategoryInstance.id} created"
      redirect(action: show, id: productCategoryInstance.id)
    }
    else {
      render(view: 'create', model: [productCategoryInstance: productCategoryInstance])
    }
  }
}
