import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tecfy/models/InvoiceItems.dart';
import 'package:tecfy/models/Item.dart';
import 'package:provider/provider.dart';
import "package:tecfy/providers/InvoiceProvider.dart";
import 'package:http/http.dart' as http;

class NewInvoice extends StatefulWidget {
  const NewInvoice({Key? key}) : super(key: key);

  @override
  State<NewInvoice> createState() => _NewInvoiceState();
}

class _NewInvoiceState extends State<NewInvoice> {
  List<InvoiceItems> selectedItems = [];
  int startIndex = 0;

  postData() async {
    print("Hello");
    const String url = "https://63088fe746372013f5807109.mockapi.io/invoices";
    Map data = {
      'date': '2022-08-26T12:13:00.724Z',
      'customerName': context.read<InvoiceProvider>().customerName,
      'invoiceNumber': 26,
      'items':
          "${context.read<InvoiceProvider>().items.map((item) => item.name).toList()}",
    };
    var body = json.encode(data);
    print(body);
    try {
      var response = await http
          .post(Uri.parse(url),
              headers: {
                "Content-Type": "application/json",
              },
              body: body)
          .then((value) {
        print(value.body);
      });
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Invoice")),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Customer Namer'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context.read<InvoiceProvider>().setcustomerName(value);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Date'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                    },
                    onChanged: (value) {
                      context.read<InvoiceProvider>().setdate(value);
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 35),
                    child: Text("Invoice"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("S/N"),
                      Text("Item"),
                      Text("Quantity"),
                      Text("Total"),
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: selectedItems.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          key: Key(selectedItems[index].id.toString()),
                          onDismissed: (direction) {
                            // Remove the item from the data source.
                            setState(() {
                              selectedItems.removeAt(index);
                            });
                          },
                          child: MyListItem(index: index));
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedItems.add(InvoiceItems(id: startIndex));
                          startIndex += 1;
                        });
                      },
                      child: Text("Add item")),
                  ElevatedButton(
                      onPressed: () {
                        postData();
                      },
                      child: Text("Save Invoice")),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class MyListItem extends StatefulWidget {
  MyListItem({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<MyListItem> createState() => _MyListItemState();
}

class _MyListItemState extends State<MyListItem> {
  List<Item> invoiceItems = getInvoiceItems();
  List<InvoiceItems> selectedItems = [];
  int startIndex = 0;
  late Item selectedItemName = invoiceItems[0];
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int selectedNum = 1;
  static List<Item> getInvoiceItems() {
    const data = [
      {"id": 1, "Name": "Black", "Price": 5},
      {"id": 2, "Name": "Red", "Price": 10},
      {"id": 3, "Name": "Orange", "Price": 2},
    ];
    return data.map<Item>(Item.fromJson).toList();
  }

  @override
  void initState() {
    getInvoiceItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(context.watch<InvoiceProvider>().items);
    return Container(
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${widget.index}"),
          DropdownButton(
            value: selectedItemName,
            items: invoiceItems
                .map((item) => DropdownMenuItem<Item>(
                      value: item,
                      child: Text(item.name!),
                    ))
                .toList(),
            onChanged: (Item? value) {
              setState(() {
                selectedItemName = value!;
              });
              context.read<InvoiceProvider>().setitems(selectedItemName);
            },
          ),
          DropdownButton(
            value: selectedNum,
            items: numbers
                .map((item) => DropdownMenuItem<int>(
                      value: item,
                      child: Text("${item}"),
                    ))
                .toList(),
            onChanged: (int? value) {
              setState(() {
                selectedNum = value!;
              });
            },
          ),
          Text("${selectedItemName.price! * selectedNum}"),
        ],
      ),
    );
  }
}
