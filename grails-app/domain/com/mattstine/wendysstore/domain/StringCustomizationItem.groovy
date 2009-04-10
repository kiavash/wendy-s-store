package com.mattstine.wendysstore.domain

class StringCustomizationItem extends CustomizationItem {

    String value

    static constraints = {
      value(maxSize:4000)
    }
}
