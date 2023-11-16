import 'package:fire_base/app/data/book_model.dart';
import 'package:fire_base/app/data/read_mode.dart';
import 'package:fire_base/app/modules/home/controllers/home_controller.dart';
import 'package:fire_base/app/modules/login/controllers/login_controller.dart';
import 'package:fire_base/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../widgets/bottomnav.dart';
import 'package:dropdown_search/dropdown_search.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<LoginController>();
  // final HomeController controller = Get.put(HomeController());
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFBF2C98), Color(0xFF8332A6)],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 40, left: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //AVATAR
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hai...',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  authC.firebaseUser.value?.email ?? 'Email',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                              size: 35,
                            ),
                            SizedBox(width: 18),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    //BOOK LIST
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Book List',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: IconButton(
                            onPressed: () {
                              Get.toNamed(Routes.FORM);
                            },
                            icon: Icon(Icons.add_circle_outline_outlined),
                            color: Colors.white,
                            iconSize: 25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    //LISTVIEW
                    Container(
                      height: 210,
                      child: Obx(
                        () => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.books.length,
                          itemBuilder: (context, index) {
                            return Obx(
                              () {
                                return GestureDetector(
                                    onTap: () {
                                      controller.editIndex.value = index;
                                    },
                                    child: controller.editIndex.value == index
                                        ? Container(
                                            width: 150,
                                            height: 200,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF8332A6)
                                                    .withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            margin: EdgeInsets.only(right: 15),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  top: 10,
                                                  right: 10,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      controller
                                                          .editIndex.value = -1;
                                                    },
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.close,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.toNamed(
                                                              Routes.FORM,
                                                              arguments:
                                                                  controller
                                                                          .books[
                                                                      index]);
                                                        },
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.white,
                                                              size: 20,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              'Edit',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      GestureDetector(
                                                        onTap: () {
                                                          controller.delete(
                                                              controller.books[
                                                                  index]);
                                                        },
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.white,
                                                              size: 20,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(
                                            width: 150,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            margin: EdgeInsets.only(right: 15),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 20),
                                                      child: controller
                                                              .books[index]
                                                              .image
                                                              .isEmptyOrNull
                                                          ? Image.asset(
                                                              'assets/images/home.png',
                                                              width: 106,
                                                              height: 60,
                                                            )
                                                          : Image.network(
                                                              controller
                                                                  .books[index]
                                                                  .image!),
                                                    ),
                                                  ),
                                                  SizedBox(height: 18),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      controller.books[index]
                                                              .title ??
                                                          'Book Name',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFBF2C98),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      controller.books[index]
                                                              .category ??
                                                          'Category',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xFFBF2C98),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      '${controller.books[index].readPage}/${controller.books[index].page} page',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xFFBF2C98),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      NumberFormat
                                                              .percentPattern(
                                                                  'id')
                                                          .format((controller
                                                                      .books[
                                                                          index]
                                                                      .readPage ??
                                                                  0) /
                                                              (controller
                                                                      .books[
                                                                          index]
                                                                      .page ??
                                                                  0)),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFBF2C98),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      child:
                                                          LinearProgressIndicator(
                                                        value: (controller
                                                                    .books[
                                                                        index]
                                                                    .readPage ??
                                                                0) /
                                                            (controller
                                                                    .books[
                                                                        index]
                                                                    .page ??
                                                                0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        backgroundColor: Colors
                                                            .grey.shade400,
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Color(
                                                                    0xFF7C39BF)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 15),
                    //   height: 200,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(16),
                    //   ),
                    //   child: Obx(() =>
                    // controller.books.length < 1
                    //         ? Center(
                    //             child: Column(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Text('No Book Found',
                    //                     style:
                    //                         TextStyle(color: Colors.white)),
                    //                 TextButton(
                    //                   onPressed: () =>
                    //                       Get.toNamed(Routes.FORM),
                    //                   child: Text(
                    //                     'Add your first book!',
                    //                     style: TextStyle(color: Colors.white),
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           )
                    //         : ListView.builder(
                    //             shrinkWrap: true,
                    //             scrollDirection: Axis.horizontal,
                    //             itemCount: controller.books.length,
                    //             physics: ScrollPhysics(),
                    //             itemBuilder: (context, index) => Padding(
                    //               padding: EdgeInsets.only(right: 16),
                    //               child:
                    //                   BookList(book: controller.books[index]),
                    //             ),
                    //           )

                    // return Obx(
                    //   () {
                    //     return GestureDetector(
                    //         onTap: () {
                    //           controller.editIndex.value = index;
                    //         },
                    //         child: controller.editIndex.value == index
                    //             ? Container(
                    //                 width: 150,
                    //                 height: 200,
                    //                 decoration: BoxDecoration(
                    //                     color: Color(0xFF8332A6)
                    //                         .withOpacity(0.9),
                    //                     borderRadius:
                    //                         BorderRadius.circular(16)),
                    //                 margin: EdgeInsets.only(right: 15),
                    //                 child: Stack(
                    //                   children: [
                    //                     Positioned(
                    //                       top: 10,
                    //                       right: 10,
                    //                       child: GestureDetector(
                    //                         onTap: () {
                    //                           controller.editIndex.value =
                    //                               -1;
                    //                         },
                    //                         child: Container(
                    //                           width: 20,
                    //                           height: 20,
                    //                           decoration: BoxDecoration(
                    //                             border: Border.all(
                    //                                 color: Colors.white),
                    //                             shape: BoxShape.circle,
                    //                           ),
                    //                           child: Center(
                    //                             child: Icon(
                    //                               Icons.close,
                    //                               color: Colors.white,
                    //                               size: 13,
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     Center(
                    //                       child: Column(
                    //                         mainAxisSize:
                    //                             MainAxisSize.min,
                    //                         children: [
                    //                           GestureDetector(
                    //                             onTap: () {},
                    //                             child: Row(
                    //                               mainAxisSize:
                    //                                   MainAxisSize.min,
                    //                               children: [
                    //                                 Icon(
                    //                                   Icons.edit,
                    //                                   color: Colors.white,
                    //                                   size: 20,
                    //                                 ),
                    //                                 SizedBox(width: 10),
                    //                                 Text(
                    //                                   'Edit',
                    //                                   style: TextStyle(
                    //                                       color: Colors
                    //                                           .white,
                    //                                       fontSize: 16),
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                           ),
                    //                           SizedBox(height: 20),
                    //                           GestureDetector(
                    //                             onTap: () {
                    //                               showDialog(
                    //                                 context: context,
                    //                                 builder: (context) {
                    //                                   return AlertDialog(
                    //                                     shape: RoundedRectangleBorder(
                    //                                         borderRadius:
                    //                                             BorderRadius
                    //                                                 .circular(
                    //                                                     20)),
                    //                                     content:
                    //                                         Container(
                    //                                       width: 400,
                    //                                       child: Column(
                    //                                         mainAxisSize:
                    //                                             MainAxisSize
                    //                                                 .min,
                    //                                         crossAxisAlignment:
                    //                                             CrossAxisAlignment
                    //                                                 .center,
                    //                                         children: [
                    //                                           Text(
                    //                                             'Confirm Delete',
                    //                                             style: TextStyle(
                    //                                                 fontSize:
                    //                                                     18,
                    //                                                 color:
                    //                                                     Color(0xFF8332A6)),
                    //                                           ),
                    //                                           SizedBox(
                    //                                               height:
                    //                                                   20),
                    //                                           Image.asset(
                    //                                             'assets/images/home.png',
                    //                                             width:
                    //                                                 100,
                    //                                             height:
                    //                                                 100,
                    //                                           ),
                    //                                           SizedBox(
                    //                                               height:
                    //                                                   20),
                    //                                           Text(
                    //                                             'Are you sure to delete this data?',
                    //                                             style:
                    //                                                 TextStyle(
                    //                                               fontSize:
                    //                                                   16,
                    //                                               color: Color(
                    //                                                   0xFF8332A6),
                    //                                             ),
                    //                                           ),
                    //                                           SizedBox(
                    //                                               height:
                    //                                                   20),
                    //                                           Row(
                    //                                             mainAxisAlignment:
                    //                                                 MainAxisAlignment
                    //                                                     .center,
                    //                                             children: [
                    //                                               ElevatedButton(
                    //                                                 onPressed:
                    //                                                     () {
                    //                                                   Navigator.of(context).pop();
                    //                                                 },
                    //                                                 style:
                    //                                                     ElevatedButton.styleFrom(
                    //                                                   backgroundColor:
                    //                                                       Colors.grey,
                    //                                                 ),
                    //                                                 child:
                    //                                                     Text('Cancel'),
                    //                                               ),
                    //                                               SizedBox(
                    //                                                   width:
                    //                                                       20),
                    //                                               ElevatedButton(
                    //                                                 onPressed:
                    //                                                     () {
                    //                                                   // controller.itemList.removeAt(index);
                    //                                                   // Get.back();
                    //                                                   // controller.update();
                    //                                                 },
                    //                                                 style:
                    //                                                     ElevatedButton.styleFrom(
                    //                                                   primary:
                    //                                                       Color(0xFF8332A6),
                    //                                                 ),
                    //                                                 child:
                    //                                                     Text('OK'),
                    //                                               ),
                    //                                             ],
                    //                                           ),
                    //                                         ],
                    //                                       ),
                    //                                     ),
                    //                                   );
                    //                                 },
                    //                               );
                    //                             },
                    //                             child: Row(
                    //                               mainAxisSize:
                    //                                   MainAxisSize.min,
                    //                               children: [
                    //                                 Icon(
                    //                                   Icons.delete,
                    //                                   color: Colors.white,
                    //                                   size: 20,
                    //                                 ),
                    //                                 SizedBox(width: 10),
                    //                                 Text(
                    //                                   'Delete',
                    //                                   style: TextStyle(
                    //                                       color: Colors
                    //                                           .white,
                    //                                       fontSize: 16),
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               )
                    //             : Container(
                    //                 width: 150,
                    //                 height: 200,
                    //                 decoration: BoxDecoration(
                    //                   color: Colors.white,
                    //                   borderRadius:
                    //                       BorderRadius.circular(16),
                    //                 ),
                    //                 margin: EdgeInsets.only(right: 15),
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(10),
                    //                   child: Column(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.start,
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     children: [
                    //                       Align(
                    //                         alignment:
                    //                             Alignment.topCenter,
                    //                         child: Padding(
                    //                           padding: EdgeInsets.only(
                    //                               top: 20),
                    //                           child: Image.asset(
                    //                             'assets/images/home.png',
                    //                             width: 106,
                    //                             height: 60,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       SizedBox(height: 18),
                    //                       Padding(
                    //                         padding:
                    //                             EdgeInsets.only(left: 10),
                    //                         child: Text(
                    //                           'Book Name',
                    //                           style: TextStyle(
                    //                             fontSize: 14,
                    //                             color: Color(0xFFBF2C98),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       Padding(
                    //                         padding:
                    //                             EdgeInsets.only(left: 10),
                    //                         child: Text(
                    //                           'Category',
                    //                           style: TextStyle(
                    //                             fontSize: 12,
                    //                             color: Color(0xFFBF2C98),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       Padding(
                    //                         padding:
                    //                             EdgeInsets.only(left: 10),
                    //                         child: Text(
                    //                           '125/250 page',
                    //                           style: TextStyle(
                    //                             fontSize: 12,
                    //                             color: Color(0xFFBF2C98),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       SizedBox(height: 10),
                    //                       Padding(
                    //                         padding:
                    //                             EdgeInsets.only(left: 10),
                    //                         child: Text(
                    //                           '50%',
                    //                           style: TextStyle(
                    //                             fontSize: 14,
                    //                             color: Color(0xFFBF2C98),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       Padding(
                    //                         padding: const EdgeInsets
                    //                             .symmetric(
                    //                             horizontal: 10),
                    //                         child: ClipRRect(
                    //                           borderRadius:
                    //                               BorderRadius.circular(
                    //                                   6),
                    //                           child:
                    //                               LinearProgressIndicator(
                    //                             value: 0.5,
                    //                             minHeight: 10,
                    //                             backgroundColor:
                    //                                 Colors.grey.shade400,
                    //                             valueColor:
                    //                                 AlwaysStoppedAnimation<
                    //                                         Color>(
                    //                                     Color(
                    //                                         0xFF7C39BF)),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ));
                    //   },
                    // );

                    //       ),
                    // ),
                    SizedBox(height: 15),
                    //RECENT ACTIVITY
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        height: 300,
                        width: 396,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 15, bottom: 15),
                              child: Text(
                                'Recent Activity',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Obx(
                              () => Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: controller.readings.length,
                                  itemBuilder: (context, index) {
                                    ReadModel reading =
                                        controller.readings[index];
                                    BookModel? book = controller.books
                                        .firstWhereOrNull((element) =>
                                            element.id ==
                                            controller.readings[index].bookId);
                                    Color backgroundColor = index % 2 == 0
                                        ? Color(0xFFBF2C98).withOpacity(0.1)
                                        : Color(0xFFBF2C98).withOpacity(0.2);

                                    return Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                      ),
                                      child: ListTile(
                                        leading:
                                            book?.image.isEmptyOrNull ?? true
                                                ? Image.asset(
                                                    'assets/images/home.png',
                                                    width: 54,
                                                    height: 30,
                                                  )
                                                : Image.network(
                                                    book!.image!,
                                                    width: 54,
                                                    height: 30,
                                                  ),
                                        title: Text(
                                          book?.title ?? 'Book Name',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        subtitle: Text(
                                          '${DateFormat.yMMMEd().format(reading.time!)} ${reading.prePage}-${reading.newPage}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 47,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFBF2C98),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${reading.prePage} - ${reading.newPage}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
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
          ),
        ],
      ),
      //READING FORM
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF8332A6),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Obx(
                  () => Form(
                    key: formKey,
                    child: Container(
                      width: 700,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Reading Form',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF8332A6),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownSearch<BookModel>(
                                  items: controller.books,
                                  itemAsString: (book) => book.title ?? '',
                                  enabled: !controller.isLoading,
                                  onChanged: (book) {
                                    controller.selectedBook = book;
                                    print(book?.readPage ?? 'Null');
                                    controller.preC.text =
                                        book?.readPage.toString() ?? '';
                                  },
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      labelText: 'Select Book',
                                      labelStyle:
                                          TextStyle(color: Color(0xFF8332A6)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF8332A6))),
                                      prefixIcon: Icon(Icons.book,
                                          size: 25, color: Color(0xFF8332A6)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  controller: controller.preC,
                                  enabled: !controller.isLoading,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'Previous Page',
                                    labelStyle:
                                        TextStyle(color: Color(0xFF8332A6)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF8332A6))),
                                    prefixIcon: Icon(
                                        Icons.remove_red_eye_outlined,
                                        size: 25,
                                        color: Color(0xFF8332A6)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: controller.curC,
                                  enabled: !controller.isLoading,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'Current Page',
                                    labelStyle:
                                        TextStyle(color: Color(0xFF8332A6)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF8332A6))),
                                    prefixIcon: Icon(Icons.menu_book,
                                        size: 25, color: Color(0xFF8332A6)),
                                  ),
                                  validator: (value) {
                                    if (value.isEmptyOrNull) {
                                      return 'This field is required';
                                    }
                                    if ((int.tryParse(value ?? '') ?? 0) <=
                                        (controller.selectedBook!.readPage
                                            as num)) {
                                      return "This field can't less than previous page";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    backgroundColor: Color(0xFF8332A6),
                                    minimumSize: Size(120, 40)),
                                onPressed: controller.isLoading
                                    ? null
                                    : () {
                                        if (formKey.currentState!.validate()) {
                                          var res =
                                              controller.saveRead(ReadModel(
                                            bookId: controller.selectedBook?.id,
                                            newPage:
                                                controller.curC.text.toInt(),
                                            prePage:
                                                controller.preC.text.toInt(),
                                          ));
                                        }
                                      },
                                child: Text('Submit'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    backgroundColor: Color(0xFF8332A6),
                                    minimumSize: Size(120, 40)),
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.white, size: 20),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNav(),
    );
  }
}

// class BookList extends GetView<HomeController> {
//   BookList({required this.book});
//   final BookModel book;
//   @override
//   Widget build(BuildContext context) {
//     RxBool showEdit = false.obs;
//     return Obx(
//       () => Stack(
//         children: [
//           InkWell(
//             onTap: () => showEdit.value = !showEdit.value,
//             child: Container(
//               width: 150,
//               height: 200,
//               child: Column(
//                 children: [
//                   Align(
//                     alignment: Alignment.center,
//                     child: book.image.isEmptyOrNull
//                         ? Image.asset(
//                             'assets/images/home.png',
//                             height: 60,
//                           )
//                         : Image.network(
//                             book.image!,
//                             height: 60,
//                           ),
//                   ),
//                   16.height,
//                   Text(book.title ?? "Book Title",
//                       style: TextStyle(
//                         color: Color(0xFF8332A6),
//                       )),
//                   8.height,
//                   Text(book.category ?? "Book Category",
//                       style: TextStyle(
//                         color: Color(0xFF8332A6),
//                         fontSize: 12,
//                       )),
//                   8.height,
//                   Text("${book.readPage}/${book.page} Page",
//                       style: TextStyle(
//                         color: Color(0xFF8332A6),
//                         fontSize: 12,
//                       )),
//                   8.height,
//                   Text(
//                       NumberFormat.percentPattern('id')
//                           .format((book.readPage ?? 0) / (book.page ?? 1)),
//                       style: TextStyle(
//                         color: Color(0xFF8332A6),
//                       )),
//                   2.height,
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(16),
//                     child: LinearProgressIndicator(
//                       value: (book.readPage ?? 0) / (book.page ?? 1),
//                       minHeight: 10,
//                       backgroundColor: const Color.fromARGB(255, 221, 94, 94),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (showEdit.value)
//             Container(
//               width: 150,
//               height: 200,
//               color: Color(0xFF8332A6).withOpacity(0.7),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: IconButton(
//                       onPressed: () {
//                         showEdit.value = !showEdit.value;
//                       },
//                       icon: Icon(
//                         Icons.cancel_outlined,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   TextButton.icon(
//                     onPressed: () {
//                       Get.toNamed(Routes.FORM, arguments: book);
//                       showEdit.value = false;
//                     },
//                     icon: Icon(
//                       Icons.edit,
//                       color: Colors.white,
//                     ),
//                     label: Text("Edit", style: TextStyle(color: Colors.white)),
//                   ),
//                   TextButton.icon(
//                     onPressed: () {
//                       controller.delete(book);
//                       showEdit.value = false;
//                     },
//                     icon: Icon(
//                       Icons.delete,
//                       color: Colors.white,
//                     ),
//                     label:
//                         Text("Delete", style: TextStyle(color: Colors.white)),
//                   ),
//                 ],
//               ),
//             )
//         ],
//       ),
//     );
//   }
// }
