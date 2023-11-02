import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

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
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';


var filePath = "";

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
        filePath = pdfPath!;
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
              child: pw.ListView.builder(
                  itemCount: widget.item.length,
                  itemBuilder: (context, index) {
                    return pw.ClipRRect(
                        verticalRadius: 5.0,
                        horizontalRadius: 5.0,
                        child: pw.Container(
                            margin: pw.EdgeInsets.only(bottom: 6.0),
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
                            height: 140,
                            child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Expanded(
                                    flex: 1,
                                    child: widget.item[index].productImage !=
                                            "0"
                                        ? pw.Image(
                                            pw.MemoryImage(
                                              File(widget
                                                      .item[index].productImage)
                                                  .readAsBytesSync(),
                                            ),
                                            fit: pw.BoxFit.fitWidth)
                                        : pw.Stack(children: [
                                      pw.Text("Image not added",
                                          style: pw.TextStyle(
                                              fontSize:
                                              18))
                                    ]), /*pw.Image(
                                        pw.MemoryImage(
                                           File("assets/images/no_image.png")
                                                .readAsBytesSync(),
                                        ),
                                        fit: pw.BoxFit.fitWidth)*/
                                  ),
                                  pw.Expanded(
                                      flex: 3,
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.only(left: 20),
                                        child: pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            mainAxisAlignment: pw
                                                .MainAxisAlignment.spaceAround,
                                            children: [
                                              pw.Text(
                                                  "Name : " +
                                                      widget.item[index]
                                                          .productName,
                                                  style: pw.TextStyle(
                                                      fontSize: 18)),
                                              pw.Text(
                                                  "Category : " +
                                                      widget
                                                          .item[index].category,
                                                  style: pw.TextStyle(
                                                      fontSize: 18)),
                                              pw.Text(
                                                  "Price : " +
                                                      widget.item[index]
                                                          .productPrice,
                                                  style: pw.TextStyle(
                                                      fontSize: 18)),
                                              pw.Text(
                                                  "Description : " +
                                                      widget.item[index]
                                                          .description,
                                                  style: pw.TextStyle(
                                                      fontSize: 18)),
                                              pw.Text(
                                                  "Code : " +
                                                      widget.item[index].code,
                                                  style: pw.TextStyle(
                                                      fontSize: 18)),
                                              pw.Text(
                                                  "Size : " +
                                                      widget.item[index]
                                                          .packagesize,
                                                  style: pw.TextStyle(
                                                      fontSize: 18)),
                                            ]),
                                      )),
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
    final filePath = '${output.path}/Products.pdf';
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "share",
            backgroundColor: green33,
            onPressed: () {
              sharePdfOnWhatsApp(["9961073453"]);  // "+919886626229"
            },
            child: Icon(
              Icons.share_outlined,
              color: white,
              size: 30 * SizeConfig.widthMultiplier!,
            ),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            heroTag: "download",
            elevation: 0,
            backgroundColor: green33,
            onPressed: () async {
              try {
                Uint8List data =
                    await File(pdfPath.toString()).readAsBytesSync();
                DocumentFileSavePlus().saveFile(
                    data,
                    "My_Products${DateTime.now().toString()}.pdf",
                    "appliation/pdf");
                snackBarErrorWidget(context, "PDF Downloaded");
              } catch (e) {
                debugPrint("File save exception is : +${e.toString()}");
              }
            },
            child: Icon(
              Icons.download_outlined,
              color: white,
              size: 30 * SizeConfig.widthMultiplier!,
            ),
          ),
        ],
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

// void sharePdfOnWhatsApp() async {
//   // Define the message you want to send (optional).
//   String message = "Check out this PDF!";
//
//   // Share the PDF file using WhatsApp.
//   await Share.shareFiles([filePath], text: message);
// }
//
void sharePdfOnWhatsApp(List<String> phoneNumbers) async {
  String message = "Check out this PDF! "; // Optional message

  // Join the phone numbers with commas to create a comma-separated list
  String numbers = phoneNumbers.join(",");

  // Create the WhatsApp URL with multiple recipients
  String url = "whatsapp://send?text=$message&phone=$numbers";

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    // Handle error
    print("Could not launch WhatsApp.");
  }
}


// Future<void> sharePdfOnWhatsApp(List<String> phoneNumbers) async {
//   String message = "Check out this PDF!"; // Optional message
//
//   final navigatorKey = GlobalKey<NavigatorState>();
//
//   for (final phoneNumber in phoneNumbers) {
//     String url = "https://wa.me/$phoneNumber/?text=${Uri.parse(message)}";
//
//     if (await canLaunch(url)) {
//       await launch(url);
//       await Future.delayed(Duration(seconds: 5)); // Wait for 5 seconds.
//       navigatorKey.currentState?.pop(); // Navigate back to the previous screen.
//     } else {
//       print("Could not launch WhatsApp for $phoneNumber.");
//     }
//   }
// }

// Future<void> sharePdfOnWhatsApp(List<String> phoneNumbers) async {
//   String message = "Check out this PDF!"; // Optional message
//
//   // Create a list of file paths to share (in this case, just one)
//   List<String> filesToShare = [filePath];
//
//   try {
//     // Share the PDF file using WhatsApp
//     await Share.shareFiles(
//       filesToShare,
//       text: message,
//       subject: 'Product PDF', // You can set a subject for the shared file
//     );
//   } catch (e) {
//     // Handle any errors that occur during sharing
//     print("Error sharing PDF: $e");
//   }
// }



