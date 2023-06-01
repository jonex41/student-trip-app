import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:student_project/booking/view/pdf_view.dart';
import 'package:student_project/data/models/booking_model.dart';

import 'dart:collection';

Future getPdf( BuildContext context,BookingModel model, bool viewPdf) async {
  // pw.Document pdf = pw.Document();

  final pdf = pw.Document();

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(children: [
          pw.Center(child: pw.Text(
              'Booking details',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 25),
            ), ),
            pw.SizedBox(height: 50),
          pw.Row(children: [
            
            pw.Text(
              'Booking reference No.',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
            ),
           pw.SizedBox(width: 50),
            pw.Text(
              model.bookinRef!,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
            ),
          ]),
          pw.Row(children: [
            pw.Text(
              'Source',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
            ),
             pw.SizedBox(width: 50),
            pw.Text(
              model.source!,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
            ),
          ]),
          pw.Row(children: [
            pw.Text(
              'Destination',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
            ),
             pw.SizedBox(width: 50),
            pw.Text(
              model.destination!,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
            ),
          ]),
          pw.Row(children: [
            pw.Text(
              'Amount Paid',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
            ),
             pw.SizedBox(width: 50),
            pw.Text(
              '${model.noPassenger! * 100}',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
            ),
          ]),
          pw.Row(children: [
            pw.Text(
              'Departure Date',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
            ),
             pw.SizedBox(width: 50),
            pw.Text(
              model.departureDate!,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
            ),
          ]),
          pw.Row(children: [
            pw.Text(
              'Departure Time',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
            ),
             pw.SizedBox(width: 50),
            pw.Text(
              model.departureTime!,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
            ),
          ]),
        ]); // Center
      })); // Page
  final documentPath = await getExternalStorageDirectory();
  // String documentPath = documentDirectory.path;
  print(' this is the part $documentPath');
  // String path = '${documentPath!.path}/vote.pdf';
  final diraa = await getTemporaryDirectory();
  final path = diraa.absolute.path + "/Booking Details.pdf";
  print(' this is the part $path');
  File receiptFile = File(path);
  receiptFile.writeAsBytesSync(await pdf.save());
  if(viewPdf){
    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  PdfView(receiptFile)),
                    );
  }else{
     Share.shareFiles([path]);
  }
 
}
