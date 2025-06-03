import 'package:flutter/material.dart';

void main() {
  runApp(const QuickBillApp());
}

class QuickBillApp extends StatelessWidget {
  const QuickBillApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickBill',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickBill Dashboard'),
      ),
      body: const Center(
        child: Text('Welcome to QuickBill!'),
      ),
    );
  }
}
