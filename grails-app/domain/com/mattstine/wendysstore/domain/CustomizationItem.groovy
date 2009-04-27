package com.mattstine.wendysstore.domain

class CustomizationItem implements Serializable {

  Customization customization

  static transients = ['instance']

  static def getInstance(def customization, def value) {
    def customizationItem

    switch (customization.type) {
      case CustomizationType.CHECKBOX:
        customizationItem = new BooleanCustomizationItem()
        customizationItem.customization = customization
        customizationItem.value = value
        break;

      case [CustomizationType.SMALLTEXT, CustomizationType.LARGETEXT]:
        customizationItem = new StringCustomizationItem()
        customizationItem.customization = customization
        customizationItem.value = value
        break;

      case CustomizationType.CHOICESET:
        customizationItem = new ChoiceSetCustomizationItem()
        def customizationChoice = CustomizationChoice.get(value.toLong())
        customizationItem.customization = customization
        customizationItem.customizationChoice = customizationChoice
        break;
    }

    return customizationItem
  }

}
