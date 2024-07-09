import 'package:akadomen/repositories/fruits.dart';
import 'package:akadomen/utils/constants/colors.dart';
import 'package:akadomen/utils/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/images.dart';
import '../widgets/add_remove.dart';
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
                    left: 10.w, right: 15.w, top: 10, bottom: 50),
                itemCount: FruitsRepositorie.juiceList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  final juice = FruitsRepositorie.juiceList[index];
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
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
                            image: AssetImage(juice.image),
                          ),
                        ),
                      ),
                      ItemCard(
                        price: juice.price,
                        name: juice.name,
                      ),
                      AddAndRemoveCard(
                        onDecrement: () {},
                        onIncrement: () {},
                      )
                    ],
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.all(20),
              width: context.width / 5,
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
