package com.mattstine.wendysstore.domain

enum CustomizationType {
  CHECKBOX('Checkbox', 'checkboxWidget'),
  SMALLTEXT('Small Text Field', 'smallTextWidget'),
  LARGETEXT('Large Text Area', 'largeTextWidget'),
  CHOICESET('Set of Choices', 'choiceSetWidget')

  CustomizationType(String labelText, String widgetName) {
    this.labelText = labelText
    this.widgetName = widgetName
  }

  String labelText
  String widgetName

}
