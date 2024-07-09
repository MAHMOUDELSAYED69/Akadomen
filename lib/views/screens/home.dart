
import 'package:akadomen/controllers/pdf/pdf_cubit.dart';
import 'package:akadomen/repositories/fruits.dart';
import 'package:akadomen/utils/constants/colors.dart';
import 'package:akadomen/utils/extentions/extentions.dart';
import 'package:akadomen/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../utils/constants/images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: context.width,
        height: context.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(ImageManager.homeBackground),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: GridView.builder(
                  itemCount: FruitsRepositorie.juiceList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      crossAxisCount: 3),
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(1, -1),
                          color: ColorManager.brown.withOpacity(0.5),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            FruitsRepositorie.juiceList[index].image),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.all(20),
              width: context.width / 4,
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
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Image.asset(
                    ImageManager.akadomenLogo,
                    height: 150,
                  ),
                  BlocListener<PDFCubit, PDFState>(
                    listener: (context, state) {},
                    child: MyElevatedButton(
                      onPressed: () async {
                        final pdf =
                            await context.read<PDFCubit>().generateInvoice();

                        await Printing.layoutPdf(
                          onLayout: (PdfPageFormat format) async => pdf.save(),
                        );
                      },
                      title: 'invoice',
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
