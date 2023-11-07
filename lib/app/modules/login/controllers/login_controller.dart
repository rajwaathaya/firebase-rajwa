import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fire_base/app/data/class_model.dart';
import 'package:fire_base/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fire_base/app/integrations/firestore.dart';
import 'package:fire_base/app/modules/login/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> streamAuthStatus() {
    return auth.authStateChanges();
  }

  var currentUser = UserModel().obs;
  UserModel get user => currentUser.value;
  set user(UserModel value) => currentUser.value = value;

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

  Rx<DateTime?> _selectedDate = DateTime(2000).obs;
  DateTime? get selectedDate => _selectedDate.value;
  set selectedDate(DateTime? value) => _selectedDate.value = value;

  pickedDate(dynamic context) async {
    selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
  }

  login() async {
    try {
      final myUser = await _auth.signInWithEmailAndPassword(
          email: emailC.text, password: passC.text);
      if (myUser.user!.emailVerified) {
        Get.offAndToNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
          title: 'Failed to login',
          middleText:
              'Verify your email first, Does verification need to be resent?',
          onConfirm: () async {
            await myUser.user!.sendEmailVerification();
            Get.back();
            Get.snackbar(
                'Success', 'Verification code has been sent to your email');
          },
          textConfirm: 'Yes',
          textCancel: 'No',
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toast("No User found for that email");
      } else if (e.code == 'wrong-password') {
        toast("Wrong password provided for that user");
      } else {
        toast(e.toString());
      }
    } catch (e) {
      toast(e.toString());
    }
  }

  register() async {
    try {
      isSaving = true;
      UserModel user = UserModel(
        username: nameC.text,
        email: emailC.text,
        password: passC.text,
        // birthDate: pickeddate,
        image: '',
        time: DateTime.now(),
      );
      UserCredential myUser = await _auth.createUserWithEmailAndPassword(
          email: emailC.text, password: passC.text);
      await myUser.user!.sendEmailVerification();
      user.id = myUser.user!.uid;
      if (user.id != null) {
        firebaseFirestore
            .collection(usersCollection)
            .doc(user.id)
            .set(user.toJson);
      }
    } on FirebaseAuthException catch (e) {
      isSaving = false;
      if (e.code == 'weak-password') {
        toast('Password is too weak');
      } else if (e.code == 'email-already-in-use') {
        toast('An account already exists for this email');
      } else {
        toast(e.toString());
      }
    }
  }

  void logout() async {
    Get.defaultDialog(
        title: 'Logout',
        middleText: 'Are you sure?',
        onConfirm: () async {
          await FirebaseAuth.instance.signOut();
          Get.back();
          isSaving = false;
          emailC.clear();
          passC.clear();
          Get.offAndToNamed(Routes.LOGIN);
        },
        textConfirm: 'Yes',
        textCancel: 'No');
  }

  streamUser(User? fuser) {
    if (fuser != null) {
      currentUser.bindStream(UserModel().streamList(fuser.uid));
      print("auth id = ${fuser.uid}");
    } else {
      print("null auth");
      user = UserModel();
    }
  }

  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, streamUser);
  }

  @override
  void onClose() {
    emailC.clear();
    passC.clear();
    confirC.clear();
    nameC.clear();
  }
}
