import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

Future<void> exportReportAsPDF(String reportText) async {
  final pdf = pw.Document();
  pdf.addPage(pw.Page(build: (pw.Context context) {
    return pw.Center(child: pw.Text(reportText));
  }));

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/report.pdf");
  await file.writeAsBytes(await pdf.save());
}

Future<void> exportReportAsCSV(List<Map<String, dynamic>> rows) async {
  final csv = StringBuffer();
  csv.writeln("Customer,Amount,Date");

  for (var row in rows) {
    csv.writeln("${row['customer']},${row['amount']},${row['date']}");
  }

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/report.csv");
  await file.writeAsString(csv.toString());
}
