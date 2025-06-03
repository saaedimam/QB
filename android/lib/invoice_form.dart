import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InvoiceForm extends StatefulWidget {
  @override
  _InvoiceFormState createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceForm> {
  final _customerController = TextEditingController();
  final _amountController = TextEditingController();

  Future<void> _submitInvoice() async {
    final customer = _customerController.text;
    final amount = double.tryParse(_amountController.text);

    if (customer.isEmpty || amount == null) return;

    await FirebaseFirestore.instance.collection('invoices').add({
      'customer': customer,
      'amount': amount,
      'date': Timestamp.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invoice saved')));
    _customerController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Invoice')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _customerController, decoration: InputDecoration(labelText: 'Customer Name')),
            TextField(controller: _amountController, decoration: InputDecoration(labelText: 'Amount (BDT)'), keyboardType: TextInputType.number),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _submitInvoice, child: Text('Submit Invoice')),
          ],
        ),
      ),
    );
  }
}
