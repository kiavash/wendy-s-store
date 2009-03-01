package com.mattstine.wendysstore.controllers

import com.mattstine.wendysstore.domain.Product

class HomeController {

    def index = {
      [featuredProducts:Product.findAllByFeatured(true)]
    }
}
