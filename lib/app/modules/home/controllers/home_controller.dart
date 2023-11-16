import 'package:fire_base/app/data/read_mode.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../data/book_model.dart';

class HomeController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final RxInt editIndex = (-1).obs;
  // var itemList = <String>["Item 1", "Item 2", "Item 3"].obs;
  RxList<BookModel> rxBooks = RxList<BookModel>();
  List<BookModel> get books => rxBooks.value;
  set books(List<BookModel> value) => rxBooks.value = value;

  RxList<ReadModel> rxreadings = RxList<ReadModel>();
  List<ReadModel> get readings => rxreadings.value;
  set readings(List<ReadModel> value) => rxreadings.value = value;

  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  BookModel? selectedBook;
  TextEditingController preC = TextEditingController();
  TextEditingController curC = TextEditingController();

  controllertoModel(ReadModel read) {
    read.prePage = int.tryParse(preC.text);
    read.newPage = int.tryParse(curC.text);
    read.time = DateTime.now();
    return read;
  }

  modelToContoller(ReadModel read) {
    preC.text = (read.prePage ?? '').toString();
    curC.text = (read.newPage ?? '').toString();
  }

  Future<ReadModel?> saveRead(ReadModel reading) async {
    try {
      isLoading = true;

      var res = await reading.save();
      BookModel book = books.firstWhere(
          (element) => element.id == reading.bookId,
          orElse: () => BookModel());
      if (!book.id.isEmptyOrNull) {
        book.readPage = reading.newPage;
        await book.save();
      }
      Get.back();
      toast("Read activity saved ");
      return res;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
    }
  }

  Future delete(BookModel book) async {
    if (book.id.isEmptyOrNull) {
      Get.snackbar('Error', 'Book Id not found');
      return Future.value(null);
    }
    try {
      Get.defaultDialog(
        onConfirm: () async {
          try {
            await book.delete();
            Get.back();
          } catch (e) {
            print(e);
          }
        },
        textConfirm: 'OK',
        textCancel: 'Cancel',
        content: Column(
          children: [
            Image.asset(
              'assets/images/home.png',
              width: Get.width,
              height: 100,
            ),
            8.height,
            Text('Are you sure to delete this data?'),
          ],
        ),
        title: 'Confirm delete',
      );
    } on Exception catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    rxBooks.bindStream(BookModel().streamList());
    rxreadings.bindStream(ReadModel().streamAllList());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
