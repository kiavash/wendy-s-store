package com.mattstine.wendysstore.domain

class ChoiceSetCustomizationItem extends CustomizationItem {

    CustomizationChoice customizationChoice

    def getValue() {
      customizationChoice.label
    }

    static transients = ['value']

    static constraints = {
    }
}
