import 'dart:io';

import 'package:akadomen/utils/constants/colors.dart';
import 'package:akadomen/utils/constants/routes.dart';
import 'package:akadomen/utils/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/calc/calccubit_cubit.dart';
import '../../controllers/repo/fruits_repository.dart';
import '../../models/juice.dart';
import '../../utils/constants/images.dart';
import '../widgets/add_remove.dart';
import '../widgets/invoice_widget.dart';
import '../widgets/item_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final calculator = context.read<CalculatorCubit>();
    return Scaffold(
      body: BlocBuilder<FruitsRepositoryCubit, List<JuiceModel>>(
        builder: (context, userJuiceList) {
          return Container(
            alignment: Alignment.center,
            width: context.width,
            height: context.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(ImageManager.homeBackground),
              ),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.only(
                          left: context.width / 25,
                          right: context.width / 25,
                          top: 10,
                          bottom: 50,
                        ),
                        itemCount: userJuiceList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          crossAxisCount: 4,
                        ),
                        itemBuilder: (context, index) {
                          final juice = userJuiceList[index];
                          return GestureDetector(
                            onTap: () => calculator.increment(juice),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(1, -1),
                                        color:
                                            ColorManager.brown.withOpacity(0.5),
                                        blurRadius: 5,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(File(juice.image!)),
                                    ),
                                  ),
                                ),
                                ItemCard(
                                  price: juice.price,
                                  name: juice.name,
                                ),
                                AddAndRemoveCard(
                                  onDecrement: () =>
                                      calculator.decrement(juice),
                                  onIncrement: () =>
                                      calculator.increment(juice),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const InvoiceWidget(),
                  ],
                ),
                Positioned(
                  left: 5,
                  top: 5,
                  child: IconButton(
                    hoverColor: ColorManager.white,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        ColorManager.white.withOpacity(0.7),
                      ),
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteManager.settings),
                    icon: Icon(
                      size: 7.sp,
                      Icons.settings,
                      color: ColorManager.brown,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
