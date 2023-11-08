// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<LoginController>();
  GlobalKey<FormState> _formkey = GlobalKey();
  RxBool visibilityPass = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBF2FF),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Image.asset(
                        'assets/images/login.png',
                        width: 230,
                        height: 170,
                      ),
                    ),
                    SizedBox(height: 30),
                    Card(
                      margin: EdgeInsets.all(16),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Form(
                          key: _formkey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            children: [
                              if (controller.isRegis)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Color(0xFF8332A6),
                                      size: 30,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        controller: controller.nameC,
                                        decoration: InputDecoration(
                                          labelText: 'Name',
                                          labelStyle: TextStyle(
                                              color: Color(0xFF8332A6)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF8332A6))),
                                        ),
                                        validator: (value) =>
                                            value == null || value == ''
                                                ? 'This Field Is Required'
                                                : null,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: Color(0xFF8332A6),
                                    size: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller.emailC,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle:
                                            TextStyle(color: Color(0xFF8332A6)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF8332A6))),
                                      ),
                                      validator: (value) =>
                                          value == null || value == ''
                                              ? 'This Field Is Required'
                                              : null,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Icon(
                                    Icons.lock_outline,
                                    color: Color(0xFF8332A6),
                                    size: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      obscureText: !visibilityPass.value,
                                      controller: controller.passC,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle:
                                            TextStyle(color: Color(0xFF8332A6)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF8332A6))),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            visibilityPass.value =
                                                !visibilityPass.value;
                                          },
                                          icon: visibilityPass.value
                                              ? Icon(Icons.visibility)
                                              : Icon(Icons.visibility_off),
                                        ),
                                      ),
                                      validator: (value) =>
                                          value == null || value == ''
                                              ? 'This Field Is Required'
                                              : null,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              if (controller.isRegis)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lock_outline,
                                      color: Color(0xFF8332A6),
                                      size: 30,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        obscureText: !visibilityPass.value,
                                        controller: controller.confirC,
                                        decoration: InputDecoration(
                                          labelText: 'Confirm Password',
                                          labelStyle: TextStyle(
                                              color: Color(0xFF8332A6)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF8332A6))),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              visibilityPass.value =
                                                  !visibilityPass.value;
                                            },
                                            icon: visibilityPass.value
                                                ? Icon(Icons.visibility)
                                                : Icon(Icons.visibility_off),
                                          ),
                                        ),
                                        validator: (value) =>
                                            value == null || value == ''
                                                ? 'This Field Is Required'
                                                : null,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        textInputAction: TextInputAction.done,
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(height: 15),
                              if (controller.isRegis)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.date_range,
                                      color: Color(0xFF8332A6),
                                      size: 30,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        controller: controller.dateC,
                                        decoration: InputDecoration(
                                          labelText: 'Date',
                                          labelStyle: TextStyle(
                                              color: Color(0xFF8332A6)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF8332A6))),
                                        ),
                                        onTap: () async => await controller
                                            .pickedDate(context),
                                        validator: (value) =>
                                            value == null || value == ''
                                                ? 'This Field Is Required'
                                                : null,
                                      ),
                                    ),
                                  ],
                                ),
                              if (controller.isRegis)
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 8, right: 8, top: 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Gender',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff8332A6),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Radio<String>(
                                            value: 'male',
                                            groupValue:
                                                controller.selectedGender,
                                            onChanged: (value) {
                                              controller.selectedGender =
                                                  value ?? '';
                                            },
                                            activeColor: Color(0xff8332A6),
                                          ),
                                          Text(
                                            'male',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Radio<String>(
                                            value: 'female',
                                            groupValue:
                                                controller.selectedGender,
                                            onChanged: (value) {
                                              controller.selectedGender =
                                                  value ?? '';
                                            },
                                            activeColor: Color(0xff8332A6),
                                          ),
                                          Text(
                                            'female',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF8332A6)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24))),
                        elevation: MaterialStatePropertyAll(5)),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        if (controller.isRegis) {
                          controller.register();
                        } else {
                          controller.login();
                        }
                      }
                    },
                    child: Container(
                      height: 48,
                      width: 400,
                      child: controller.isRegis
                          ? controller.isSaving
                              ? const Center(
                                  child: Text('Loading...'),
                                )
                              : const Center(
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                          : controller.isSaving
                              ? const Center(child: Text('Loading...'))
                              : const Center(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                child: Text(
                  controller.isRegis
                      ? 'Already Have Account? Login Here'
                      : 'Doesn\'t Have Account? Register Here',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF8332A6),
                      fontStyle: FontStyle.italic),
                ),
                onTap: () {
                  controller.isRegis = !controller.isRegis;
                  controller.nameC.clear();
                  controller.emailC.clear();
                  controller.passC.clear();
                  controller.confirC.clear();
                },
              ),
              SizedBox(height: 5),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF8332A6),
                      fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
