import 'package:fire_base/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBF2FF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/login.png',
                  width: 230,
                  height: 170,
                ),
                SizedBox(height: 30),
                Container(
                  child: Card(
                    margin: EdgeInsets.all(16),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
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
                                  controller: controller.emailC,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle:
                                        TextStyle(color: Color(0xFF8332A6)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF8332A6))),
                                  ),
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
                                  controller: controller.passC,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle:
                                        TextStyle(color: Color(0xFF8332A6)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF8332A6))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF8332A6)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24))),
                        elevation: MaterialStatePropertyAll(5)),
                    onPressed: () => authC.logIn(
                        controller.emailC.text, controller.passC.text),
                    child: Container(
                      height: 48,
                      width: 400,
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Doesn’t Have Account? Register Here',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF8332A6),
                        fontStyle: FontStyle.italic),
                  ),
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
        ],
      ),
    );
  }
}
