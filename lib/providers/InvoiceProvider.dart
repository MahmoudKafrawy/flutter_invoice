import 'package:flutter/material.dart';

class InvoiceProvider with ChangeNotifier {
  late String id;
  late int invoiceNumber;
  late String date;
  String customerName = "";
  List items = [];

  String get count => id;

  void setID(a) {
    id = a;
    notifyListeners();
  }

  void setinvoiceNumber(a) {
    invoiceNumber = a;
    notifyListeners();
  }

  void setdate(a) {
    date = a;
    notifyListeners();
  }

  void setitems(a, b) {
    items.insert(b, a);
    notifyListeners();
  }

  void editItems(a, b) {
    items.replaceRange(b, b + 1, a);
    notifyListeners();
  }

  void setcustomerName(a) {
    customerName = a;
    notifyListeners();
  }
}
