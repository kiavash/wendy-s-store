// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if(System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

uiperformance.enabled = true

uiperformance.continueAfterMinifyCssError = true
uiperformance.processJS = false

uiperformance.bundles = [
   [type: 'js',
    name: 'prototype/prototype.all',
    files: ['prototype/prototype',
            'prototype/scriptaculous',
            'prototype/builder',
            'prototype/controls',
            'prototype/effects',
            'prototype/slider',
            'prototype/dragdrop']]
]

grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [html: ['text/html', 'application/xhtml+xml'],
        xml: ['text/xml', 'application/xml'],
        text: 'text/plain',
        js: 'text/javascript',
        rss: 'application/rss+xml',
        atom: 'application/atom+xml',
        css: 'text/css',
        csv: 'text/csv',
        all: '*/*',
        json: ['application/json', 'text/json'],
        form: 'application/x-www-form-urlencoded',
        multipartForm: 'multipart/form-data'
]
// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"

// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true

// set per-environment serverURL stem for creating absolute links
environments {
  production {
    grails.paypal.server = "https://www.sandbox.paypal.com/cgi-bin/webscr"
    grails.paypal.email = "seller_1237686842_biz@mattstine.com"
    grails.serverURL = "http://www.duckduckgoosedesigns.com"
    store.productImages.location = "/home/webadmin/duckduckgoosedesigns.com/html/media/productImages"
    store.productImages.webPath = "media/productImages"
  }
  development {
    grails.paypal.server = "https://www.sandbox.paypal.com/cgi-bin/webscr"
    grails.paypal.email = "seller_1237686842_biz@mattstine.com"
    grails.serverURL = "http://localhost:8080"
    store.productImages.location = "/Users/mstine/Projects/wendysStore/web-app/images/productImages"
    store.productImages.webPath = "images/productImages"
  }
}

// log4j configuration
log4j = {

  debug 'grails.app.controller'


  error 'org.codehaus.groovy.grails.web.servlet',  //  controllers
          'org.codehaus.groovy.grails.web.pages', //  GSP
          'org.codehaus.groovy.grails.web.sitemesh', //  layouts
          'org.codehaus.groovy.grails."web.mapping.filter', // URL mapping
          'org.codehaus.groovy.grails."web.mapping', // URL mapping
          'org.codehaus.groovy.grails.commons', // core / classloading
          'org.codehaus.groovy.grails.plugins', // plugins
          'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
          'org.springframework',
          'org.hibernate'

  warn 'org.mortbay.log'

  error stdout:"StackTrace"
}

//log4j.logger.org.springframework.security='off,stdout'