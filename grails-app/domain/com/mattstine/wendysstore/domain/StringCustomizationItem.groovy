package com.mattstine.wendysstore.domain

class StringCustomizationItem extends CustomizationItem implements Serializable {

    String value

    static constraints = {
      value(maxSize:4000)
    }
}
