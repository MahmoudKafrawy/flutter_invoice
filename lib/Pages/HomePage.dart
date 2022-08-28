import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tecfy/models/Invoice.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Invoice>> invoicesFuture = getInovice();

  //Get data from fake api
  static Future<List<Invoice>> getInovice() async {
    const url = "https://63088fe746372013f5807109.mockapi.io/invoices";
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    return data.map<Invoice>(Invoice.fromJson).toList();
  }

  @override
  void initState() {
    getInovice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: FutureBuilder<List<Invoice>>(
            future: invoicesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.data!.isNotEmpty) {
                return buildInvoice(snapshot.data!);
              } else {
                return const Text("No data");
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.pushNamed(context, "/newinvoice");
        }),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildInvoice(List<Invoice> invoices) => ListView.builder(
        itemCount: invoices.length,
        itemBuilder: (context, index) {
          final invoice = invoices[index];
          return Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('ID: ${invoice.id!} '),
                    Text('Name : ${invoice.customerName!}'),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Text('Items : ${invoice.items!}')
              ]),
            ),
          );
        },
      );
}
