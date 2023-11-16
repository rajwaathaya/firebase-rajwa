import 'dart:io';
import 'package:fire_base/app/data/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../integrations/firestore.dart';

class BookModel {
  String? id;
  String? title;
  String? category;
  int? page;
  int? readPage;
  String? image;
  DateTime? time;

  BookModel(
      {this.id,
      this.title,
      this.category,
      this.page,
      this.readPage,
      this.image,
      this.time});

  BookModel.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? json = doc.data() as Map<String, dynamic>?;
    id = doc.id;
    title = json?['title'];
    category = json?['category'];
    page = json?['page'];
    readPage = json?['readPage'];
    image = json?['image'];
    time = (json?['time'] as Timestamp?)?.toDate();
  }

  Map<String, dynamic> get toJson => {
        'id': id,
        'title': title,
        'category': category,
        'page': page,
        'readPage': readPage,
        'image': image,
        'time': time
      };

  Database db = Database(
      collectionReference: firebaseFirestore.collection(
        bookCollection,
      ),
      storageReference: firebaseStorage.ref(bookCollection));

  Future<BookModel> save({File? file}) async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    if (file != null && id != null) {
      image = await db.upload(id: id!, file: file);
      db.edit(toJson);
    }
    return this;
  }

  Future delete() async {
    if (id.isEmptyOrNull) {
      Get.snackbar("Error", "Invalid documents Id");
      return;
    }
    return await db.delete(id!, url: image);
  }

  Stream<List<BookModel>> streamList() async* {
    yield* db.collectionReference.snapshots().map((query) {
      List<BookModel> list = [];
      for (var doc in query.docs) {
        list.add(
          BookModel.fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }

// print('event id = ${event.id}');
  // return fromJson(event);

  // Stream<List<BookModel>> allstreamList() async* {
  //   yield* db.collectionReference.snapshots().map((query) {
  //     List<BookModel> list = [];
  //     for (var doc in query.docs) {
  //       list.add(
  //         BookModel().fromJson(
  //           doc,
  //         ),
  //       );
  //     }
  //     return list;
  //   });
  // }
}
