class Item {
  int? id;
  String? name;
  int? price;

  Item({
    this.id,
    this.name,
    this.price,
  });

  factory Item.fromJson(json) => Item(
        id: json["id"],
        name: json["Name"],
        price: json["Price"],
      );
}
