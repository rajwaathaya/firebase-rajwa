import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../login/controllers/login_controller.dart';
import 'package:fire_base/app/integrations/firestore.dart';
import 'package:fire_base/app/data/database.dart';
import 'package:fire_base/app/data/class_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
    final authC = Get.find<LoginController>();

  User? user = FirebaseAuth.instance.currentUser;

  void getUserData() {
    print(user.displayName)
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
