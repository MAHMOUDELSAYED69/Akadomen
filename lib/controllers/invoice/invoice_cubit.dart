import 'package:akadomen/utils/constants/images.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta/meta.dart';
import 'package:pdf/pdf.dart' show PdfColor;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:akadomen/repositories/fruits.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceInitial());

  Future<pw.Document> generateInvoice(Map<String, int> juiceCounts) async {
    final pdf = pw.Document();
    final textColor = PdfColor.fromHex('#352300');

    final Uint8List logoBytes = await rootBundle
        .load(ImageManager.akadomenLogo)
        .then((value) => value.buffer.asUint8List());

    final List<List<String>> data = juiceCounts.entries
        .map((entry) {
          if (entry.value > 0) {
            final juice = FruitsRepository.juiceList
                .firstWhere((j) => j.name == entry.key);
            final price = juice.price;
            final quantity = entry.value;
            final total = price * quantity;
            return [
              juice.name,
              price.toStringAsFixed(2),
              '0.00',
              '0.00',
              total.toStringAsFixed(2),
              quantity.toString()
            ];
          } else {
            return <String>[];
          }
        })
        .where((element) => element.isNotEmpty)
        .toList();
    final totalAmount =
        data.fold<double>(0, (sum, item) => sum + double.parse(item[4]));
    const tax = 0.00;
    final grandTotal = totalAmount + tax;

    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);
    final formattedTime = DateFormat('HH:mm:ss').format(now);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Image(
                pw.MemoryImage(logoBytes),
                width: 200,
                height: 200,
              ),
              pw.Text('City Road - empty',
                  style: pw.TextStyle(fontSize: 14, color: textColor)),
              pw.Text('Phone: 01061172139',
                  style: pw.TextStyle(fontSize: 14, color: textColor)),
              pw.Text('Tax Number: 000002',
                  style: pw.TextStyle(fontSize: 14, color: textColor)),
              pw.SizedBox(height: 5.h),
              pw.BarcodeWidget(
                color: textColor,
                barcode: pw.Barcode.code128(),
                data: '000000000000002',
                width: 100.w,
                height: 60,
              ),
              pw.Text('Invoice Number: 15',
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: textColor)),
              pw.SizedBox(height: 5.h),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Text('Date: $formattedDate',
                    style: pw.TextStyle(fontSize: 14, color: textColor)),
                pw.SizedBox(width: 5.h),
                pw.Text('Time: $formattedTime',
                    style: pw.TextStyle(fontSize: 14, color: textColor)),
              ]),
              pw.SizedBox(height: 5.h),
              pw.Text('Customer Name: mahmoud',
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: textColor)),
              pw.SizedBox(height: 5.h),
              pw.Table.fromTextArray(
                context: context,
                border: pw.TableBorder.all(color: textColor),
                headers: <String>[
                  'Item',
                  'Price (EGP)',
                  'Tax (EGP)',
                  'Discount (EGP)',
                  'Total (EGP)',
                  'Quantity'
                ],
                cellStyle: pw.TextStyle(color: textColor),
                headerStyle: pw.TextStyle(color: textColor),
                data: data,
              ),
              pw.SizedBox(height: 5.h),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                          'Total Amount: ${totalAmount.toStringAsFixed(2)} EGP',
                          style: pw.TextStyle(fontSize: 14, color: textColor)),
                      pw.Text('Tax: ${tax.toStringAsFixed(2)} EGP',
                          style: pw.TextStyle(fontSize: 14, color: textColor)),
                      pw.Text(
                          'Grand Total: ${grandTotal.toStringAsFixed(2)} EGP',
                          style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                              color: textColor)),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(bytes: await pdf.save(), filename: 'invoice.pdf');
    return pdf;
  }
}

    // await Printing.layoutPdf(
    //   onLayout: (PdfPageFormat format) async => pdf.save(),
    // );