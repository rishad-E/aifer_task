import 'package:aifer_task/utils/common/color.dart';
import 'package:aifer_task/view/product_list.dart';
import 'package:aifer_task/widgets/appbar.dart';
import 'package:aifer_task/widgets/bottom_nav.dart';
import 'package:aifer_task/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarHome(),
        backgroundColor: kblack,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                categoryContainer('Activity', kwhite, kblack),
                categoryContainer('Community', kwhite, kblack),
                categoryContainer('Shop', kblack, kwhite),
              ],
            ),
            choiceBox(height: 25),
             const Expanded(
              child: Stack(
                children: [
                  ProductList(),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: BottomNav()
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
     
    );
  }
}