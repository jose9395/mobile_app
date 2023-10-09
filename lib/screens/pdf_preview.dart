import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stock_check/const/app_text_style.dart';
import 'package:stock_check/provider/product_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';

import '../widget/snack_bar.dart';

class CustomPDFViewScreen extends StatefulWidget {
  final List<ProductModel> item;

  const CustomPDFViewScreen({super.key, required this.item});

  @override
  _CustomPDFViewScreenState createState() => _CustomPDFViewScreenState();
}

class _CustomPDFViewScreenState extends State<CustomPDFViewScreen> {
  String? pdfPath;

  @override
  void initState() {
    super.initState();
    // Generate the PDF when the screen is initialized
    generateCustomPDF().then((path) {
      setState(() {
        pdfPath = path;
      });
    });
  }

  Future<void> requestPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status == PermissionStatus.granted) {
        downloadPDF(pdfPath.toString(), "Products.pdf");
      } else {
        Permission.storage.request();
      }
    }
  }

  Future<void> downloadPDF(String localFilePath, String pdfFileName) async {
    await FlutterDownloader.enqueue(
      url: localFilePath,
      // Leave it empty for local file download
      savedDir: '/downloads',
      // Replace with your desired directory
      fileName: pdfFileName,
      // Replace with the desired file name
      showNotification: true,
      openFileFromNotification: true,
    );
  }

  Future<String> generateCustomPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Center(
              child:pw.ListView.builder(
                  itemCount: widget.item.length,
                  itemBuilder: (context, index) {
                    return pw.ClipRRect(
                        verticalRadius: 5.0,
                        horizontalRadius: 5.0,
                        child:  pw.Container(
                            margin:  pw.EdgeInsets.only(bottom: 6.0),
                            decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(5.0),
                              color: PdfColors.grey100,
                              boxShadow: [
                                pw.BoxShadow(
                                  color: PdfColors.grey, //(x,y)
                                  blurRadius: 12.0,
                                ),
                              ],
                            ),
                            height: 120,
                            child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Image(
                                        pw.MemoryImage(
                                          File(widget.item[index].productImage)
                                              .readAsBytesSync(),
                                        ),
                                        fit: pw.BoxFit.fitWidth),
                                  ),
                                  pw.Expanded(
                                      flex: 3,
                                      child:pw.Padding(
                                        padding: pw.EdgeInsets.only(left: 20),
                                        child:  pw.Column(
                                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                                            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                                            children: [
                                              pw.Text(
                                                  "Name : " +
                                                      widget.item[index].productName,
                                                  style: pw.TextStyle(fontSize: 18)),
                                              pw.Text(
                                                  "Category : " +
                                                      widget.item[index].category,
                                                  style: pw.TextStyle(fontSize: 18)),
                                              pw.Text(
                                                  "Price : " +
                                                      widget.item[index].productPrice,
                                                  style: pw.TextStyle(fontSize: 18)),
                                              pw.Text(
                                                  "Description : " +
                                                      widget.item[index].description,
                                                  style: pw.TextStyle(fontSize: 18)),
                                              pw.Text(
                                                  "Code : " +
                                                      widget.item[index].code,
                                                  style: pw.TextStyle(fontSize: 18)),
                                              pw.Text(
                                                  "Size : " +
                                                      widget.item[index].packagesize,
                                                  style: pw.TextStyle(fontSize: 18)),
                                            ]),
                                      )
                                  ),
                                ])));
                  }))
        ],
      ),
    );


   /* pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(
              child:pw.ListView.builder(
                  itemCount: widget.item.length,
                  itemBuilder: (context, index) {
                    return pw.ClipRRect(
                        verticalRadius: 5.0,
                        horizontalRadius: 5.0,
                    child:  pw.Container(
                        margin:  pw.EdgeInsets.only(bottom: 6.0),
                        decoration: pw.BoxDecoration(
                          borderRadius: pw.BorderRadius.circular(5.0),
                          color: PdfColors.grey100,
                          boxShadow: [
                            pw.BoxShadow(
                              color: PdfColors.grey, //(x,y)
                              blurRadius: 12.0,
                            ),
                          ],
                        ),
                        height: 120,
                        child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Expanded(
                                flex: 1,
                                child: pw.Image(
                                    pw.MemoryImage(
                                      File(widget.item[index].productImage)
                                          .readAsBytesSync(),
                                    ),
                                    fit: pw.BoxFit.fitWidth),
                              ),
                              pw.Expanded(
                                flex: 3,
                                child:pw.Padding(
                                  padding: pw.EdgeInsets.only(left: 20),
                                  child:  pw.Column(
                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                                      children: [
                                        pw.Text(
                                            "Name : " +
                                                widget.item[index].productName,
                                            style: pw.TextStyle(fontSize: 18)),
                                        pw.Text(
                                            "Category : " +
                                                widget.item[index].category,
                                            style: pw.TextStyle(fontSize: 18)),
                                        pw.Text(
                                            "Price : " +
                                                widget.item[index].productPrice,
                                            style: pw.TextStyle(fontSize: 18)),
                                        pw.Text(
                                            "Description : " +
                                                widget.item[index].description,
                                            style: pw.TextStyle(fontSize: 18)),
                                        pw.Text(
                                            "Code : " +
                                                widget.item[index].code,
                                            style: pw.TextStyle(fontSize: 18)),
                                        pw.Text(
                                            "Size : " +
                                                widget.item[index].packagesize,
                                            style: pw.TextStyle(fontSize: 18)),
                                      ]),
                                )
                              ),
                            ])));
                  }));
        },
      ),
    );*/

    // Save the PDF to a file
    final output = await getTemporaryDirectory();
    final filePath = '${output.path}/custom_pdf_example.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Return the path to the generated PDF
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green33,
        title: const Text('Products PDF'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "download",
        elevation: 0,
        backgroundColor: green33,
        onPressed: ()async {
          try{
            Uint8List data = await File(pdfPath.toString()).readAsBytesSync();
            DocumentFileSavePlus().saveFile(data, "My_Products${widget.item.length.toString()}.pdf", "appliation/pdf");
            snackBarErrorWidget(context,"PDF Downloaded");
          }catch (e){
           debugPrint("File save exception is : +${e.toString()}");
          }
        },
        child: Icon(
          Icons.download_outlined,
          color: white,
          size: 30 * SizeConfig.widthMultiplier!,
        ),
      ),
      body: pdfPath != null
          ? PDFView(
              filePath: pdfPath,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
