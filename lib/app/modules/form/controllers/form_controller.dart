import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:fire_base/app/data/book_model.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:image_picker/image_picker.dart';

class FormController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController page = TextEditingController();
  TextEditingController readPage = TextEditingController();
  // TextEditingController image = TextEditingController();

  final ImagePicker picker = ImagePicker();
  var path = ''.obs;

  Future selectImage(ImageSource source) async {
    XFile? xfile = await picker.pickImage(source: ImageSource.gallery);
    if (xfile is XFile) {
      path.value = xfile.path;
    }
  }

  modelToController(BookModel book) {
    title.text = book.title ?? '';
    category.text = book.category ?? '';
    path.value = book.image ?? '';
    page.text = (book.page ?? '').toString();
  }

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(bool value) => _isSaving.value = value;

  Future store(BookModel book) async {
    isSaving = true;
    book.title = title.text;
    book.category = category.text;
    book.page = int.tryParse(page.text);
    book.readPage = int.tryParse(readPage.text);
    if (book.id.isEmptyOrNull) {
      book.time = DateTime.now();
    }
    try {
      await book.save(file: path.value.isEmptyOrNull ? null : File(path.value));
      toast('Data Saved Succesfully');
      print('Success');
      Get.back();
    } catch (e) {
      print(e);
    } finally {
      isSaving = false;
    }
  }

  // checkControllers(BookModel book, String? path) {
  //   if (book.id.isEmptyOrNull) {
  //     if (title.text.isNotEmpty ||
  //         category.text.isNotEmpty ||
  //         page.text.isNotEmpty ||
  //         (path == null || path == '')) return true;
  //   }
  //   return false;
  // }

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
