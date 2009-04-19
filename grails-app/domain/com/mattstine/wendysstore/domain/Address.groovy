package com.mattstine.wendysstore.domain

class Address {
  String name
  String addressLineOne
  String addressLineTwo
  String city
  USState state
  String zipCode
  String areaCode
  String phonePrefix
  String phoneSuffix
  Boolean defaultAddress = true

  static belongsTo = [user:User]

  static constraints = {
    name(blank:false)
    addressLineOne(blank:false)
    city(blank:false)
    zipCode(blank:false,matches:/\d{5}/)
    areaCode(blank:false,matches:/\d{3}/)
    phonePrefix(blank:false,matches:/\d{3}/)
    phoneSuffix(blank:false,matches:/\d{4}/)
    user(nullable:true)
  }
}
