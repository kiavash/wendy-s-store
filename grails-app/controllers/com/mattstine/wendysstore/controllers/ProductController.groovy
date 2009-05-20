package com.mattstine.wendysstore.controllers

import com.mattstine.wendysstore.domain.Image
import com.mattstine.wendysstore.domain.Price
import com.mattstine.wendysstore.domain.Product
import groovy.xml.MarkupBuilder
import org.springframework.dao.DataIntegrityViolationException
import org.codehaus.groovy.grails.plugins.springsecurity.Secured
import org.im4java.core.IMOperation
import org.im4java.core.ConvertCmd


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

  @Secured (['ROLE_ADMIN'])
  def list = {
    params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
    [productInstanceList: Product.list(params), productInstanceTotal: Product.count()]
  }

  def show = {
    def productInstance = Product.get(params.id)
    def priceInstance = new Price()

    if (!productInstance) {
      flash.message = "Product not found with id ${params.id}"
      redirect(action: list)
    }
    else { return [productInstance: productInstance, priceInstance: priceInstance] }
  }

  @Secured (['ROLE_ADMIN'])
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

      IMOperation imageOperation = new IMOperation()
      imageOperation.addImage("${imagePath}/${originalFilename}")
      imageOperation.resize(800)
      imageOperation.addImage("${imagePath}/${largeFilename}")
      ConvertCmd convertCmd = new ConvertCmd()
      convertCmd.run(imageOperation)

      imageOperation = new IMOperation()
      imageOperation.addImage("${imagePath}/${originalFilename}")
      imageOperation.resize(500)
      imageOperation.addImage("${imagePath}/${mediumFilename}")
      convertCmd = new ConvertCmd()
      convertCmd.run(imageOperation)

      imageOperation = new IMOperation()
      imageOperation.addImage("${imagePath}/${originalFilename}")
      imageOperation.resize(230)
      imageOperation.addImage("${imagePath}/${thumbnailFilename}")
      convertCmd = new ConvertCmd()
      convertCmd.run(imageOperation)

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
              img(class: 'productImage', src: resource(dir: grailsApplication.config.store.productImages.webPath, file: product.mediumImage.name), width: '500')
              br('Click to Enlarge')
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

  @Secured (['ROLE_ADMIN'])
  def addPrice = {
    def price = new Price(params)
    def product = Product.get(params.productId)
    if (price.validate()) {
      product.addToPrices(price)
      product.save()
      redirect(action: show, id: params.productId)
    } else {
      render(view: 'show', model: [productInstance: product, priceInstance: price])
    }
  }

  @Secured (['ROLE_ADMIN'])
  def deletePrice = {
    def product = Product.get(params.productId)
    def price = Price.get(params.id)
    product.removeFromPrices(price)
    product.save()
    price.delete()
    redirect(action: show, id: params.productId)
  }

  @Secured (['ROLE_ADMIN'])
  def editPrice = {
    def priceInstance = Price.get(params.id)
    def productInstance = Product.get(params.productId)
    render(view: 'show', model: [productInstance: productInstance, priceInstance: priceInstance])
  }

  @Secured (['ROLE_ADMIN'])
  def updatePrice = {
    def price = Price.get(params.id)
    price.properties = params
    if (price.save()) {
      redirect(action: show, id: params.productId)
    } else {
      def product = Product.get(params.productId)
      render(view: 'show', model: [productInstance: product, priceInstance: price])
    }
  }

  @Secured (['ROLE_ADMIN'])
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

  @Secured (['ROLE_ADMIN'])
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

  @Secured (['ROLE_ADMIN'])
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

  @Secured (['ROLE_ADMIN'])
  def create = {
    def productInstance = new Product()
    productInstance.properties = params
    return ['productInstance': productInstance]
  }

  @Secured (['ROLE_ADMIN'])
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

  @Secured (['ROLE_ADMIN'])
  def sortCustomizations = {

    def productId = params.productId
    def sortOrder = params['productCustomizations[]']

    def sortOrderMap = [:]
    def index = 0
    sortOrder.each {customizationId ->
      sortOrderMap[customizationId] = index
      index++
    }

    def product = Product.get(productId)

    def sortedCustomizationList = new ArrayList(product.customizations.size())

    product.customizations.each {customization ->
      sortedCustomizationList[sortOrderMap["${customization.id}"]] = customization
    }

    product.customizations = sortedCustomizationList
  }
}
