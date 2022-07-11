
import 'package:flutter/material.dart';
import 'package:pagamento/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      title: 'Flutter Demo', 
      home: const HomePage(),
    );
  }
}



