class Customer {
  static hasMany = [orders:Order, billingAddresses:Address, shippingAddresses:Address]

  String firstName
  String lastName
  String email

  String username
  String password


}
