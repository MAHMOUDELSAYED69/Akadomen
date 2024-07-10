import 'package:akadomen/utils/constants/images.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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

    final Uint8List logoBytes = await rootBundle
        .load(ImageManager.akadomenLogo)
        .then((value) => value.buffer.asUint8List());

    final List<List<String>> data = juiceCounts.entries
        .map((entry) {
          if (entry.value > 0) {
            final juice = FruitsRepositorie.juiceList
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
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Image(
                pw.MemoryImage(logoBytes),
                width: 150,
                height: 150,
              ),
              pw.Text('City Road - empty',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.Text('Phone: empty', style: const pw.TextStyle(fontSize: 14)),
              pw.Text('Tax Number: empty',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.SizedBox(height: 10),
              pw.BarcodeWidget(
                barcode: pw.Barcode.code128(),
                data: '000002',
                width: 200,
                height: 80,
              ),
              pw.SizedBox(height: 10),
              pw.Text('Invoice Number: empty',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text('Simple Sales Invoice',
                  style: const pw.TextStyle(fontSize: 18)),
              pw.SizedBox(height: 10),
              pw.Text('Date: $formattedDate',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.Text('Time: $formattedTime',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.SizedBox(height: 10),
              pw.Text('Customer Name: empty',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.SizedBox(height: 10),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                context: context,
                border: pw.TableBorder.all(),
                headers: <String>[
                  'Item',
                  'Price (EGP)',
                  'Tax (EGP)',
                  'Discount (EGP)',
                  'Total (EGP)',
                  'Quantity'
                ],
                data: data,
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                          'Total Amount: ${totalAmount.toStringAsFixed(2)} EGP',
                          style: const pw.TextStyle(fontSize: 14)),
                      pw.Text('Tax: ${tax.toStringAsFixed(2)} EGP',
                          style: const pw.TextStyle(fontSize: 14)),
                      pw.Text(
                          'Grand Total: ${grandTotal.toStringAsFixed(2)} EGP',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
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