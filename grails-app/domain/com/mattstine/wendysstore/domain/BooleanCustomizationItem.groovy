package com.mattstine.wendysstore.domain

class BooleanCustomizationItem extends CustomizationItem {

    String value

    static constraints = {
      value(maxSize:4000)
    }
}
