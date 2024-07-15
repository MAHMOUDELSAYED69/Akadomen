import 'package:akadomen/utils/extentions/extentions.dart';
import 'package:akadomen/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controllers/calc/calccubit_cubit.dart';
import '../../controllers/invoice/invoice_cubit.dart';
import '../../models/juice.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';
import 'custom_text_field.dart';

class InvoiceWidget extends StatefulWidget {
  const InvoiceWidget({super.key});

  @override
  State<InvoiceWidget> createState() => _InvoiceWidgetState();
}

class _InvoiceWidgetState extends State<InvoiceWidget> {
  late GlobalKey<FormState> _formkey;

  @override
  void initState() {
    _formkey = GlobalKey<FormState>();
    super.initState();
  }

  String? _customerName;

  @override
  Widget build(BuildContext context) {
    const border = BorderSide(width: 1, color: ColorManager.brown);

    final calculator = context.read<CalculatorCubit>();
    final invoice = context.read<InvoiceCubit>();
    return Container(
      margin: EdgeInsets.only(right: context.width / 30),
      width: context.width / 4.5,
      height: context.height / 1.2,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, -1),
            color: ColorManager.brown.withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Image.asset(
                ImageManager.akadomenLogo,
                height: 150,
              ),
              SizedBox(height: 10.h),
              BlocBuilder<CalculatorCubit, Map<JuiceModel, int>>(
                builder: (context, juiceCounts) {
                  final filteredJuiceCounts = juiceCounts.entries
                      .where((entry) => entry.value > 0)
                      .toList();
                  return Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(
                              children: [
                                _invoiceText('Item'),
                                _invoiceText('Quantity'),
                                _invoiceText('Price'),
                                _invoiceText('Total'),
                              ],
                            ),
                          ],
                        ),
                        // Table rows
                        ...filteredJuiceCounts.map((entry) {
                          final juice = entry.key;
                          final quantity = entry.value;
                          final totalPrice = juice.price * quantity;
                          return Table(
                            border: const TableBorder(
                              bottom: border,
                              left: border,
                              right: border,
                              verticalInside: border,
                            ),
                            children: [
                              TableRow(
                                children: [
                                  _invoiceText(juice.name),
                                  _invoiceText(quantity.toString()),
                                  _invoiceText(juice.price.toStringAsFixed(2)),
                                  _invoiceText(
                                    totalPrice.toStringAsFixed(2),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                        SizedBox(height: 3.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: _invoiceText(
                            'Total Amount: ${calculator.getTotalPrice().toStringAsFixed(2)} EGP',
                          ),
                        ),
                        if (calculator.getTotalPrice() == 0.0)
                          SizedBox(
                            height: context.height / 3,
                            child: Padding(
                              padding: EdgeInsets.only(top: 3.h),
                              child: const Placeholder(
                                strokeWidth: 1,
                                color: ColorManager.brown,
                              ),
                            ),
                          ),
                        MyTextFormField(
                          hintText: 'Customer Name',
                          onSaved: (data) => _customerName = data,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Expanded(
                              child: MyElevatedButton(
                                title: 'Get Invoice',
                                onPressed: () {
                                  if (_formkey.currentState?.validate() ??
                                      false) {
                                    _formkey.currentState?.save();
                                    invoice.generateInvoice(
                                      juiceCounts: juiceCounts,
                                      customerName: _customerName!,
                                    );
                                    calculator.reset();
                                    _formkey.currentState?.reset();
                                  }
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                calculator.reset();
                                _formkey.currentState?.reset();
                              },
                              hoverColor: ColorManager.grey.withOpacity(0.2),
                              icon: const Icon(Icons.refresh),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _invoiceText(String data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        data,
        style: context.textTheme.displayMedium?.copyWith(fontSize: 3.sp),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
