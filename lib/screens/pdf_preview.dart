import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stock_check/provider/product_provider.dart';

class CustomPDFViewScreen extends StatefulWidget {

  final List<ProductModel> item;

  const CustomPDFViewScreen({super.key,required this.item});
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
      /*  Provider.of<ProductProvider>(context, listen: false);
        _item = ProductProvider().item;*/
     //   debugPrint(ProductProvider().item.first.productName);
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

    final headers = ["Product name", "price","Product Code","Product Size","Product Category","Description"];


    final data = widget.item.map((prod) => [prod.productName, prod.productPrice,prod.code,prod.packagesize,prod.category,prod.description]).toList();
 /*  List<List<dynamic>> data1 = [widget.prod_name,widget.prod_price];*/

    // Add a page to the PDF
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(
              child: pw.Column(children: [
            pw.TableHelper.fromTextArray(
                headers: headers,
                data: data)
          ]));
        },
      ),
    );

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
        onPressed: () {
          requestPermission();
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
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
