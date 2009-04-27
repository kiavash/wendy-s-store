package com.mattstine.wendysstore.domain

class BooleanCustomizationItem extends CustomizationItem implements Serializable {

    String value

    static constraints = {
      value(maxSize:4000)
    }
}
