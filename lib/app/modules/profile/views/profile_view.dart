import 'package:fire_base/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFFBF2FF),
      body: Stack(
        children: [
          Container(
            width: w,
            height: h * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 30,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(
                    'assets/images/avatar.png',
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'name@gmal.com',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )
                  ],
                ),
                SizedBox(width: 60),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Center(
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 40,
            child: Container(
              width: 110,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(78, 0, 0, 0), // Warna bayangan
                    blurRadius: 4, // Ukuran blur
                    offset: Offset(0, 4), // Posisi bayangan (x, y)
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total Book',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '7',
                    style: TextStyle(
                      color: Color(0xFF8332A6),
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 40,
            child: Container(
              width: 110,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(78, 0, 0, 0), // Warna bayangan
                    blurRadius: 4, // Ukuran blur
                    offset: Offset(0, 4), // Posisi bayangan (x, y)
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total Progress',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '77%',
                    style: TextStyle(
                      color: Color(0xFF8332A6),
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50, bottom: 10, top: 10),
              child: IconButton(
                onPressed: () {
                  Get.toNamed(Routes.HOME);
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50, bottom: 10, top: 10),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  color: Color(0xFF8332A6),
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
