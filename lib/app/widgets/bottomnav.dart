import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import '../routes/app_pages.dart';

class BottomNav extends StatelessWidget {
  BottomNav({this.initialindex});
  int? initialindex;
  RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50, bottom: 10, top: 10),
                child: IconButton(
                  onPressed: () {
                    currentIndex.value = 0;
                    Get.toNamed(Routes.HOME);
                  },
                  icon: Icon(
                    Icons.home,
                    color: currentIndex.value == 0
                        ? Color(0xFF8332A6)
                        : Colors.grey,
                    size: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50, bottom: 10, top: 10),
                child: IconButton(
                  onPressed: () {
                    currentIndex.value = 1;
                    Get.toNamed(Routes.PROFILE);
                  },
                  icon: Icon(
                    Icons.person,
                    color: currentIndex.value == 1
                        ? Color(0xFF8332A6)
                        : Colors.grey,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
