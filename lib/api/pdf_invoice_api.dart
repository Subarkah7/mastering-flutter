import 'dart:io';

import 'package:mastering_flutter/api/pdf_api.dart';
import 'package:mastering_flutter/model/customer.dart';
import 'package:mastering_flutter/model/invoice.dart';
import 'package:mastering_flutter/model/supplier.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart' as pw_two;
import 'package:intl/intl.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = pw_two.Document();

    pdf.addPage(pw_two.MultiPage(
      build: (context) => [
        buildHeader(invoice),
        pw_two.SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice),
        buildInvoice(invoice),
        pw_two.Divider(),
        buildTotal(invoice),
      ],
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static pw_two.Widget buildHeader(Invoice invoice) => pw_two.Column(
        crossAxisAlignment: pw_two.CrossAxisAlignment.start,
        children: [
          pw_two.SizedBox(height: 1 * PdfPageFormat.cm),
          pw_two.Row(
            mainAxisAlignment: pw_two.MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(invoice.supplier),
              pw_two.Container(
                height: 50,
                width: 50,
                child: pw_two.BarcodeWidget(
                  barcode: pw_two.Barcode.qrCode(),
                  data: invoice.info.number,
                ),
              ),
            ],
          ),
          pw_two.SizedBox(height: 1 * PdfPageFormat.cm),
          pw_two.Row(
            crossAxisAlignment: pw_two.CrossAxisAlignment.end,
            mainAxisAlignment: pw_two.MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(invoice.customer),
              buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static pw_two.Widget buildCustomerAddress(Customer customer) => pw_two.Column(
        crossAxisAlignment: pw_two.CrossAxisAlignment.start,
        children: [
          pw_two.Text(customer.name, style: pw_two.TextStyle(fontWeight: pw_two.FontWeight.bold)),
          pw_two.Text(customer.address),
        ],
      );

  static pw_two.Widget buildInvoiceInfo(InvoiceInfo info) {
    final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
    final titles = <String>[
      'Invoice Number:',
      'Invoice Date:',
      'Payment Terms:',
      'Due Date:'
    ];
    final data = <String>[
      info.number,
      DateFormat('dd-mm-yyy').format(info.date),
      paymentTerms,
      DateFormat('dd-mm-yyy').format(info.dueDate),
    ];

    return pw_two.Column(
      crossAxisAlignment: pw_two.CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static pw_two.Widget buildSupplierAddress(Supplier supplier) => pw_two.Column(
        crossAxisAlignment: pw_two.CrossAxisAlignment.start,
        children: [
          pw_two.Text(supplier.name, style: pw_two.TextStyle(fontWeight: pw_two.FontWeight.bold)),
          pw_two.SizedBox(height: 1 * PdfPageFormat.mm),
          pw_two.Text(supplier.address),
        ],
      );

  static pw_two.Widget buildTitle(Invoice invoice) => pw_two.Column(
        crossAxisAlignment: pw_two.CrossAxisAlignment.start,
        children: [
          pw_two.Text(
            'INVOICE',
            style: pw_two.TextStyle(fontSize: 24, fontWeight: pw_two.FontWeight.bold),
          ),
          pw_two.SizedBox(height: 0.8 * PdfPageFormat.cm),
          pw_two.Text(invoice.info.description),
          pw_two.SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static pw_two.Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Description',
      'Date',
      'Quantity',
      'Unit Price',
      'VAT',
      'Total'
    ];
    final data = invoice.items.map((item) {
      final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        item.description,
         DateFormat('dd-mm-yyy').format(item.date),
        '${item.quantity}',
        '\$ ${item.unitPrice}',
        '${item.vat} %',
        '\$ ${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return pw_two.Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: pw_two.TextStyle(fontWeight: pw_two.FontWeight.bold),
      headerDecoration: pw_two.BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: pw_two.Alignment.centerLeft,
        1: pw_two.Alignment.centerRight,
        2: pw_two.Alignment.centerRight,
        3: pw_two.Alignment.centerRight,
        4: pw_two.Alignment.centerRight,
        5: pw_two.Alignment.centerRight,
      },
    );
  }

  static pw_two.Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items
        .map((item) => item.unitPrice * item.quantity)
        .reduce((item1, item2) => item1 + item2);
    final vatPercent = invoice.items.first.vat;
    final vat = netTotal * vatPercent;
    final total = netTotal + vat;

    return pw_two.Container(
      alignment: pw_two.Alignment.centerRight,
      child: pw_two.Row(
        children: [
          pw_two.Spacer(flex: 6),
          pw_two.Expanded(
            flex: 4,
            child: pw_two.Column(
              crossAxisAlignment: pw_two.CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total',
                  value: netTotal.toString(),
                  unite: true,
                ),
                buildText(
                  title: 'Vat ${vatPercent * 100} %',
                  value: vat.toString(),
                  unite: true,
                ),
                pw_two.Divider(),
                buildText(
                  title: 'Total amount due',
                  titleStyle: pw_two.TextStyle(
                    fontSize: 14,
                    fontWeight: pw_two.FontWeight.bold,
                  ),
                  value: total.toString(),
                  unite: true,
                ),
                pw_two.SizedBox(height: 2 * PdfPageFormat.mm),
                pw_two.Container(height: 1, color: PdfColors.grey400),
                pw_two.SizedBox(height: 0.5 * PdfPageFormat.mm),
                pw_two.Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw_two.Widget buildFooter(Invoice invoice) => pw_two.Column(
        crossAxisAlignment: pw_two.CrossAxisAlignment.center,
        children: [
          pw_two.Divider(),
          pw_two.SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Address', value: invoice.supplier.address),
          pw_two.SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
        ],
      );

  static buildSimpleText({
    String title,
    String value,
  }) {
    final style = pw_two.TextStyle(fontWeight: pw_two.FontWeight.bold);

    return pw_two.Row(
      mainAxisSize: pw_two.MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw_two.Text(title, style: style),
        pw_two.SizedBox(width: 2 * PdfPageFormat.mm),
        pw_two.Text(value),
      ],
    );
  }

  static buildText({
    String title,
    String value,
    double width = double.infinity,
    pw_two.TextStyle titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? pw_two.TextStyle(fontWeight: pw_two.FontWeight.bold);

    return pw_two.Container(
      width: width,
      child: pw_two.Row(
        children: [
          pw_two.Expanded(child: pw_two.Text(title, style: style)),
          pw_two.Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}