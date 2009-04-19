package com.mattstine.wendysstore.taglib

import com.mattstine.wendysstore.domain.CustomizationType

class RenderCustomizationWidgetTagLib {

  def renderCustomizationWidget = {attrs, body ->
    out << render(template: "/${attrs.customization.type.widgetName}", model: [customization: attrs.customization])
  }

  def renderCartCustomizationItem = {attrs, body ->
    def customizationItem = attrs.customizationItem

    out << "<strong>${customizationItem.customization.label}</strong>"

    def customizationPrice = 0

    if (customizationItem.customization.chargeable) {
      customizationPrice += customizationItem.customization.price
    }

    if (customizationItem.customization.type == CustomizationType.CHOICESET && customizationItem.customizationChoice.chargeable) {
      customizationPrice += customizationItem.customizationChoice.price
    }

    if (customizationPrice > 0) {
      out << " (${formatNumber(format: '\$0.00', number: customizationPrice)})"
    }

    out << ": "

    if (customizationItem.customization.type == CustomizationType.LARGETEXT) {
      out << "<br/>"
    }

    out << "${attrs.customizationItem.value}"
  }

}
