package com.mattstine.wendysstore.domain

import com.mattstine.wendysstore.domain.Role

/**
 * User domain class.
 */
class User implements Serializable {
  static transients = ['pass']
  static hasMany = [authorities: Role, shippingAddresses: Address]
  static belongsTo = Role

  /** Username  */
  String username
  /** User Real Name */
  String lastName
  String firstName
  /** MD5 Password  */
  String passwd
  /** enabled  */
  boolean enabled

  String email

  /** description  */
  String description = ''

  /** plain password to create a MD5 password  */
  String pass = '[secret]'

  //We want to capture a phone number for everybody
  String areaCode
  String phonePrefix
  String phoneSuffix

  static constraints = {
    username(blank: false, unique: true)
    lastName(blank: false)
    firstName(blank: false)
    passwd(blank: false)
    areaCode(blank:false,matches:/\d{3}/)
    phonePrefix(blank:false,matches:/\d{3}/)
    phoneSuffix(blank:false,matches:/\d{4}/)
    enabled()
  }
}
