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
    double fontSize = 3.sp;
    return Container(
      margin: EdgeInsets.only(right: context.width / 30),
      padding: const EdgeInsets.all(20),
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
        child: Expanded(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Image.asset(
                ImageManager.akadomenLogo,
                height: 150,
              ),
              SizedBox(height: 10.h),
              BlocBuilder<CalcCubit, Map<JuiceModel, int>>(
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Item',
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(fontSize: fontSize),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Quantity',
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(fontSize: fontSize),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Price',
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(fontSize: fontSize),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Total',
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(fontSize: fontSize),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
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
                                bottom: BorderSide(),
                                left: BorderSide(),
                                right: BorderSide(),
                                verticalInside: BorderSide()),
                            children: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      juice.name,
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(fontSize: fontSize),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      quantity.toString(),
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(fontSize: fontSize),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      juice.price.toStringAsFixed(2),
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(fontSize: fontSize),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      totalPrice.toStringAsFixed(2),
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(fontSize: fontSize),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                        SizedBox(height: 5.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Total Amount: ${context.read<CalcCubit>().getTotalPrice().toStringAsFixed(2)} EGP',
                            style: context.textTheme.displayMedium
                                ?.copyWith(fontSize: fontSize),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                                    context
                                        .read<InvoiceCubit>()
                                        .generateInvoice(
                                          juiceCounts: juiceCounts,
                                          customerName: _customerName!,
                                        );
                                    context.read<CalcCubit>().reset();
                                    _formkey.currentState?.reset();
                                  }
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  context.read<CalcCubit>().reset(),
                              icon: const Icon(
                                Icons.refresh,
                                color: ColorManager.brown,
                              ),
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
}
