import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/provider/product_provider.dart';
import 'package:provider/provider.dart';


class CustomPDFViewScreen extends StatefulWidget {
  @override
  _CustomPDFViewScreenState createState() => _CustomPDFViewScreenState();
}

class _CustomPDFViewScreenState extends State<CustomPDFViewScreen> {
  String? pdfPath;
  List<ProductModel> _item = [];

  @override
  void initState() {
    super.initState();
    // Generate the PDF when the screen is initialized
    generateCustomPDF().then((path) {
      setState(() {
        pdfPath = path;
       Provider.of<ProductProvider>(context, listen: false).selectProducts();
       _item = ProductProvider().item;
      });
    });
  }

  Future<String> generateCustomPDF() async {
    final pdf = pw.Document();

    // Add a page to the PDF
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Text('PDF Content', style: pw.TextStyle(fontSize: 20)),
                pw.SizedBox(height: 20),
                pw.Paragraph(
                  text: 'This is a custom PDF design.',
                  style: pw.TextStyle(fontSize: 14),
                ),
                // You can add more content to the PDF here
              ],
            ),
          );
        },
      ),
    );

    // Save the PDF to a file
    final output = await getTemporaryDirectory();
    final filePath = '${output.path}/custom_pdf_example.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await  pdf.save());

    // Return the path to the generated PDF
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green33,
        title: Text('Custom PDF Viewer'),
      ),
      body: pdfPath != null
          ? PDFView(
        filePath: pdfPath,
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}