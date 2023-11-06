import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  FirebaseFirestore _auth = FirebaseFirestore.instance;
  Stream<User?> get streamAuthStatus => _auth.authStateChanges();

  var currentUser = UserModel().obs;

  var currUser = UserModel().obs;
  UserModel get user => currUser.value;
  set user(UserModel value) => currUser.value = value;

  var _isRegis = false.obs;
  bool get isRegis => _isRegis.value;
  set isRegis(value) => _isRegis.value = value;

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(value) => _isSaving.value = value;

  late Rx<User?> firebaseUser;

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController confirC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  RxString _selectedGender = ''.obs;
  RxString get selectedGender => _selectedGender;

  void setSelectedGender(String value) {
    _selectedGender = value.obs;
    update();
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
