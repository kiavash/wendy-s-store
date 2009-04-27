package com.mattstine.wendysstore.domain

public enum CouponCodeType {
  PERCENT_OFF('Percentage (%) Off'),
  DOLLARS_OFF('Dollars ($) Off')

  CouponCodeType(def labelText) {
    this.labelText = labelText
  }

  String labelText
}