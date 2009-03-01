package com.mattstine.wendysstore.controllers

import com.mattstine.wendysstore.domain.ProductCategory

class ShoppingController {

    def index = { }


    def category = {

      def selectedCategory = ProductCategory.get(params.id)

      if (selectedCategory.subCategories.size() == 0) {
        render(view:"products", model:[category:selectedCategory])
      } else {
        render(view:"subCategories", model:[category:selectedCategory])
      }

    }
}
