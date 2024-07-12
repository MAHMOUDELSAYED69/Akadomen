import 'package:akadomen/repositories/fruits.dart';
import 'package:akadomen/utils/constants/colors.dart';
import 'package:akadomen/utils/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/calc/calccubit_cubit.dart';
import '../../utils/constants/images.dart';
import '../widgets/add_remove.dart';
import '../widgets/invoice_widget.dart';
import '../widgets/item_card.dart';

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
              child: GridView.builder(
                padding: EdgeInsets.only(
                    left: context.width / 25,
                    right: context.width / 25,
                    top: 10,
                    bottom: 50),
                itemCount: FruitsRepository.juiceList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  final juice = FruitsRepository.juiceList[index];
                  return GestureDetector(
                    onTap: () => context.read<CalcCubit>().increment(juice),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
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
                              image: AssetImage(juice.image!),
                            ),
                          ),
                        ),
                        ItemCard(
                          price: juice.price,
                          name: juice.name,
                        ),
                        AddAndRemoveCard(
                          onDecrement: () =>
                              context.read<CalcCubit>().decrement(juice),
                          onIncrement: () =>
                              context.read<CalcCubit>().increment(juice),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const InvoiceWidget(),
          ],
        ),
      ),
    );
  }
}
