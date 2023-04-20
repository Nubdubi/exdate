class Product {
  BigInt? PRODUCT_ID;
  BigInt? BUCKET_ID;
  String? name;
  String? bar_cd;
  int? delete_flag;
  DateTime? create_date;
  DateTime? update_date;

  Product(
      {this.PRODUCT_ID,
      this.BUCKET_ID,
      this.name,
      this.bar_cd,
      this.delete_flag,
      this.create_date,
      this.update_date});
}
