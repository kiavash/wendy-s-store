package com.mattstine.wendysstore.controllers

import com.mattstine.wendysstore.domain.Image
import com.mattstine.wendysstore.domain.Product
import groovy.xml.MarkupBuilder
import org.springframework.dao.DataIntegrityViolationException
import org.grails.plugins.imagetools.ImageTool

class ProductController {

  static navigation = [
          title: 'Manage Products',
          action: 'index',
          subItems: [
                  [action: 'list', title: 'List Products'],
                  [action: 'create', title: 'New Product']

          ]
  ]

  def index = { redirect(action: list, params: params) }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
    [productInstanceList: Product.list(params), productInstanceTotal: Product.count()]
  }

  def show = {
    def productInstance = Product.get(params.id)

    if (!productInstance) {
      flash.message = "Product not found with id ${params.id}"
      redirect(action: list)
    }
    else { return [productInstance: productInstance] }
  }

  def uploadProductImage = {
    def f = request.getFile('newProductImage')
    if (!f.empty) {

      def imagePath = grailsApplication.config.store.productImages.location

      //Create unique name for this image set based on current timestamp
      def name = "image" + new Date().getTime()

      def originalFilename = "${name}.jpg"
      def largeFilename = "${name}_large.jpg"
      def mediumFilename = "${name}_medium.jpg"
      def thumbnailFilename = "${name}_thumb.jpg"

      def file = new File("${imagePath}/${originalFilename}")
      f.transferTo(file)

      def imageTool = new ImageTool()
      imageTool.load(file.readBytes())

      imageTool.thumbnailSpecial(800, 600, 3, 2)
      imageTool.writeResult("${imagePath}/${largeFilename}", "JPEG")

      imageTool.thumbnailSpecial(250, 158, 3, 2)
      imageTool.writeResult("${imagePath}/${mediumFilename}", "JPEG")

      imageTool.thumbnailSpecial(192, 121, 3, 2)
      imageTool.writeResult("${imagePath}/${thumbnailFilename}", "JPEG")

      def product = Product.get(params['id'])
      product.fullSizeImage = new Image(path: imagePath, name: largeFilename)
      product.mediumImage = new Image(path: imagePath, name: mediumFilename)
      product.thumbnailImage = new Image(path: imagePath, name: thumbnailFilename)
      product.save()

      def writer = new StringWriter()
      def xml = new MarkupBuilder(writer)

      xml.html {
        body {
          textarea {
            a(href: resource(dir: grailsApplication.config.store.productImages.webPath, file: product.fullSizeImage.name), rel: 'lightbox') {
              img(src: resource(dir: grailsApplication.config.store.productImages.webPath, file: product.mediumImage.name), width: '250')
              br ('Click to Enlarge')
            }
          }
        }
      }

      render writer.toString()
    }
    else {
      flash.message = 'file cannot be empty'
      redirect(action: show)
    }
  }

  def delete = {
    def productInstance = Product.get(params.id)
    if (productInstance) {
      try {
        productInstance.delete()
        flash.message = "Product ${params.id} deleted"
        redirect(action: list)
      }
      catch (DataIntegrityViolationException e) {
        flash.message = "Product ${params.id} could not be deleted"
        redirect(action: show, id: params.id)
      }
    }
    else {
      flash.message = "Product not found with id ${params.id}"
      redirect(action: list)
    }
  }

  def edit = {
    def productInstance = Product.get(params.id)

    if (!productInstance) {
      flash.message = "Product not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      return [productInstance: productInstance]
    }
  }

  def update = {
    def productInstance = Product.get(params.id)
    if (productInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (productInstance.version > version) {

          productInstance.errors.rejectValue("version", "product.optimistic.locking.failure", "Another user has updated this com.mattstine.wendysstore.domain.Product while you were editing.")
          render(view: 'edit', model: [productInstance: productInstance])
          return
        }
      }
      productInstance.properties = params
      if (!productInstance.hasErrors() && productInstance.save()) {
        flash.message = "Product ${params.id} updated"
        redirect(action: show, id: productInstance.id)
      }
      else {
        render(view: 'edit', model: [productInstance: productInstance])
      }
    }
    else {
      flash.message = "Product not found with id ${params.id}"
      redirect(action: edit, id: params.id)
    }
  }

  def create = {
    def productInstance = new Product()
    productInstance.properties = params
    return ['productInstance': productInstance]
  }

  def save = {
    def productInstance = new Product(params)
    if (!productInstance.hasErrors() && productInstance.save()) {
      flash.message = "Product ${productInstance.id} created"
      redirect(action: show, id: productInstance.id)
    }
    else {
      render(view: 'create', model: [productInstance: productInstance])
    }
  }
}
