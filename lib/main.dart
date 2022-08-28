import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecfy/Pages/HomePage.dart';
import 'package:tecfy/Pages/NewInvoice.dart';
import 'package:tecfy/providers/InvoiceProvider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => InvoiceProvider())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        "/homepage": (context) => const HomePage(),
        "/newinvoice": (context) => const NewInvoice(),
      },
    );
  }
}
