import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base/app/integrations/firestore.dart';
import 'package:fire_base/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widgets/bottomnav.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<LoginController>();
  final currentUser = FirebaseAuth.instance.currentUser!;
  String formatDate(Timestamp timestamp) {
    if (timestamp == null) {
      return '';
    }
    final date = timestamp.toDate();
    final dateFormatter = DateFormat('EEE, dd - MM - y');
    return dateFormatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFFBF2FF),
      body: Column(
        children: [
          Stack(
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
                          '${authC.user.username}',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          currentUser.email!,
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
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection(usersCollection)
                .doc(currentUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.data() != null) {
                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Icon(Icons.person,
                                color: Color(0xFF8332A6), size: 35),
                            SizedBox(width: 10),
                            Text(
                              userData['username'],
                              style: TextStyle(
                                fontSize: 25,
                                color: Color(0xFF8332A6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Row(
                          children: [
                            Icon(Icons.email,
                                color: Color(0xFF8332A6), size: 35),
                            SizedBox(width: 10),
                            Text(
                              userData['email'],
                              style: TextStyle(
                                fontSize: 25,
                                color: Color(0xFF8332A6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Row(
                          children: [
                            Icon(Icons.cake,
                                color: Color(0xFF8332A6), size: 35),
                            SizedBox(width: 10),
                            Text(
                              formatDate(userData['birthDate']),
                              style: TextStyle(
                                fontSize: 25,
                                color: Color(0xFF8332A6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Row(
                          children: [
                            Icon(
                              userData['gender'] == 'male'
                                  ? Icons.male_outlined
                                  : Icons.female_outlined,
                              color: Color(0xFF8332A6),
                              size: 35,
                            ),
                            SizedBox(width: 10),
                            Text(
                              userData['gender'],
                              style: TextStyle(
                                fontSize: 25,
                                color: Color(0xFF8332A6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text(
                        'Data tidak ditemukan'), // Menampilkan pesan jika data null
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
