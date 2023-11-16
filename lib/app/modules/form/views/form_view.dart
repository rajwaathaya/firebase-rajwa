import 'dart:io';

import 'package:fire_base/app/data/book_model.dart';
import 'package:fire_base/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/form_controller.dart';

class FormView extends GetView<FormController> {
  BookModel book = Get.arguments ?? BookModel();
  // ignore: annotate_overrides
  final FormController controller = Get.put(FormController());
  GlobalKey<FormState> formKey = GlobalKey();
  bool validate = true;
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    controller.modelToController(book);
    return Scaffold(
      backgroundColor: Color(0xFFFBF2FF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFBF2FF),
        leading: IconButton(
          onPressed: () {
            Get.offAll(HomeView());
          },
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF8332A6),
        ),
        title: const Text(
          'Book\'s Form',
          style: TextStyle(
            color: Color(0xFF8332A6),
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Container(
                width: 700,
                child: Card(
                  margin: EdgeInsets.all(16),
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.book,
                                color: Color(0xFF8332A6),
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: controller.title,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelText: 'Title',
                                    labelStyle:
                                        TextStyle(color: Color(0xFF8332A6)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF8332A6))),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required';
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(
                                Icons.category,
                                color: Color(0xFF8332A6),
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: controller.category,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelText: 'Category',
                                    labelStyle:
                                        TextStyle(color: Color(0xFF8332A6)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF8332A6))),
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'This field is required';
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(
                                Icons.label_important,
                                color: Color(0xFF8332A6),
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  readOnly: !book.id.isEmptyOrNull,
                                  controller: controller.page,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    labelText: 'Page Count',
                                    labelStyle:
                                        TextStyle(color: Color(0xFF8332A6)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF8332A6))),
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'This field is required';
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Card(
                  margin: EdgeInsets.all(15),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 15),
                          child: Text(
                            'Book\'s Cover',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                          child: (controller.path.value.isNotEmpty)
                              ? Image.file(
                                  File(controller.path.value),
                                  width: 274,
                                  height: 150,
                                )
                              : !book.image.isEmptyOrNull
                                  ? Image.network(
                                      book.image!,
                                      width: 274,
                                      height: 150,
                                    )
                                  : Image.asset(
                                      'assets/images/form.png',
                                      width: 274,
                                      height: 150,
                                    )),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xFF8332A6)),
                              fixedSize:
                                  MaterialStatePropertyAll(Size(131, 32)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(16)))),
                          onPressed: () async {
                            await controller.selectImage(ImageSource.gallery);
                            Get.back();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_upload_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Upload',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, top: 40),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF8332A6)),
                    fixedSize: MaterialStateProperty.all(Size(396, 48)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.store(book);
                    } else {
                      Get.snackbar('Error', 'Data masih kosong');
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
