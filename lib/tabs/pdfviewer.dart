import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  final String pdfAssetPath;

  const PdfViewerScreen({super.key, required this.pdfAssetPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Book")),
      body: SfPdfViewer.asset(pdfAssetPath),
    );
  }
}