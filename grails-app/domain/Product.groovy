class Product {
  String name
  String description
  BigDecimal price
  Image thumbnail

  static hasMany = [images:Image,
          categories:ProductCategory,
          customizations:Customization]
}
