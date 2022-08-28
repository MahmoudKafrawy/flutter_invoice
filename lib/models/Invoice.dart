class Invoice {
  String? id;
  int? invoiceNumber;
  String? date;
  String? customerName;
  String? items;

  Invoice({
    this.id,
    this.invoiceNumber,
    this.date,
    this.customerName,
    this.items,
  });

  factory Invoice.fromJson(json) => Invoice(
        id: json["id"],
        invoiceNumber: json["invoiceNumber"],
        customerName: json["customerName"],
        date: json["date"],
        items: json["items"],
      );
}
