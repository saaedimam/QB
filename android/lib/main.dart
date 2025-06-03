import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_screen.dart';
import 'invoice_form.dart';
import 'roles.dart';
import 'export_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AccountingApp());
}

class AccountingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickBill',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorSchemeSeed: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/invoice': (context) => InvoiceForm(),
      },
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String role = 'loading';

  @override
  void initState() {
    super.initState();
    getUserRole().then((value) {
      setState(() {
        role = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (role == 'loading') {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text('ড্যাশবোর্ড')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(child: ListTile(title: Text("মোট আয়: BDT 0"))),
            Card(child: ListTile(title: Text("মোট খরচ: BDT 0"))),
            Card(child: ListTile(title: Text("নিট মুনাফা: BDT 0"))),
            Card(child: ListTile(title: Text("বকেয়া ইনভয়েস: 0"))),
            SizedBox(height: 20),
            if (role != 'accountant') ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/invoice'),
              child: Text("ইনভয়েস তৈরি করুন"),
            ),
            ElevatedButton(
              onPressed: () async {
                await exportReportAsPDF("QuickBill Report Summary");
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PDF Exported')));
              },
              child: Text("PDF এক্সপোর্ট করুন"),
            ),
            ElevatedButton(
              onPressed: () async {
                await exportReportAsCSV([
                  {"customer": "Rahim", "amount": 2000, "date": "2025-06-03"},
                  {"customer": "Karim", "amount": 3000, "date": "2025-06-03"}
                ]);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('CSV Exported')));
              },
              child: Text("CSV এক্সপোর্ট করুন"),
            )
          ],
        ),
      ),
    );
  }
}
