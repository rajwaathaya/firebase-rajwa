import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../login/controllers/login_controller.dart';
import 'package:fire_base/app/integrations/firestore.dart';
import 'package:fire_base/app/data/database.dart';
import 'package:fire_base/app/data/class_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController extends GetxController {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  // Stream<User?> streamAuthStatus() {
  //   return auth.authStateChanges();
  // }

  // var currentUser = UserModel().obs;
  // UserModel get user => currentUser.value;
  // set user(UserModel value) => currentUser.value = value;
  // RxString fullNameRx = RxString('');
  // RxString emailRx = RxString('');
  // // RxString birthdayRx = RxString('');

  // FirebaseAuth _auth = FirebaseAuth.instance;
  // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // final authC = Get.find<LoginController>();

  // User? user;

  // Future<void> getUserData() async {
  //   try {
  //     user = _auth.currentUser;
  //     if (user != null) {
  //       DocumentSnapshot userData =
  //           await firebaseFirestore.collection('users').doc(user!.uid).get();

  //       // Mengambil data yang Anda butuhkan dari dokumen
  //       String fullName = userData.get('fullName');
  //       String email = userData.get('email');
  //       // String birthday = userData.get('birthday');

  //       fullNameRx.value = fullName;
  //       emailRx.value = email;
  //       // birthdayRx.value = birthday;
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  //   getUserData();
  // }
}
