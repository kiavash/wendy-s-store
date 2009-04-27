package com.mattstine.wendysstore.domain

class ChoiceSetCustomizationItem extends CustomizationItem implements Serializable {

    CustomizationChoice customizationChoice

    def getValue() {
      customizationChoice.label
    }

    static transients = ['value']

    static constraints = {
    }
}
