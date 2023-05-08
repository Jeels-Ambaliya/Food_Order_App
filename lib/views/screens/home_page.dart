import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_order/controllers/favourite_controller.dart';
import 'package:food_order/controllers/icon_controller.dart';
import 'package:food_order/controllers/quentity_controller.dart';
import 'package:food_order/views/screens/detail_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/helper/firebase_auth_helper.dart';
import '../../controllers/helper/firestore_helper.dart';
import '../components/my_drawer.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  Uint8List? imageBytes;
  CartController cartController = Get.put(CartController());
  FavouriteController favouriteController = Get.put(FavouriteController());
  QuentityController quentityController = Get.put(QuentityController());
  IconController iconController = Get.put(IconController());

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.green,
                size: 30, // Changing Drawer Icon Size
              ),
              onPressed: () {
                My_Drawer(user: data['user']);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.green,
            ),
            Text(
              " Jakatnaka, Surat",
              style: GoogleFonts.exo2(
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/favourite_page');
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.pink,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuthHelper.firebaseAuthHelper.logOut();

              Navigator.of(context)
                  .pushNamedAndRemoveUntil('login_page', (route) => false);
            },
            icon: const Icon(
              Icons.power_settings_new_sharp,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      // drawer: My_Drawer(user: data['user']),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.pushNamed(context, '/cart_page');
        },
        child: const Icon(
          Icons.shopping_cart,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: StreamBuilder(
          stream: FirestoreHelper.firestoreHelper.fetchRecords(),
          builder: (context, snapShot) {
            if (snapShot.hasError) {
              return Center(
                child: Text("Error : ${snapShot.error}"),
              );
            } else if (snapShot.hasData) {
              QuerySnapshot<Map<String, dynamic>>? data = snapShot.data;

              if (data == null) {
                return const Center(
                  child: Text("No Any Data Available...."),
                );
              } else {
                List<QueryDocumentSnapshot<Map<String, dynamic>>> allFoods =
                    data.docs;

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "HI Jeels",
                              style: GoogleFonts.exo2(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              "Find your food",
                              style: GoogleFonts.exo2(
                                textStyle: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xfff4fff1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Icon(
                                          Icons.search,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Text(
                                          "Search Food",
                                          style: GoogleFonts.exo2(
                                            textStyle: const TextStyle(
                                              fontSize: 22,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
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
                      Expanded(
                        flex: 4,
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 5,
                          children: List.generate(
                            allFoods.length,
                            (index) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green.shade50,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Detail_Page(
                                          data: allFoods[index].data(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: MemoryImage(
                                                base64Decode(
                                                  allFoods[index]
                                                      .data()['photo'],
                                                ),
                                              ),
                                              // fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "${allFoods[index].data()['name']}",
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.exo2(
                                                  textStyle: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${allFoods[index].data()['time']}min",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.exo2(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${allFoods[index].data()['rate']}⭐",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.exo2(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "${allFoods[index].data()['price']} ₹",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.exo2(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
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
                          ),
                        ),
                        // child: ListView.builder(
                        //   itemCount: allFoods.length,
                        //   itemBuilder: (context, i) {
                        //     return Padding(
                        //       padding: const EdgeInsets.only(bottom: 15),
                        //       child: Container(
                        //         height: 140,
                        //         width: double.infinity,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(25),
                        //           color: Colors.grey.shade200,
                        //           border: Border.all(
                        //             width: 0.2,
                        //             color: Colors.deepPurple,
                        //           ),
                        //           boxShadow: [
                        //             BoxShadow(
                        //               spreadRadius: 1,
                        //               blurRadius: 5,
                        //               offset: const Offset(3, 3),
                        //               color: Colors.deepPurple.shade100,
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           children: [
                        //             Expanded(
                        //               flex: 2,
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(5),
                        //                 child: Container(
                        //                   decoration: BoxDecoration(
                        //                     image: DecorationImage(
                        //                       image: MemoryImage(
                        //                         base64Decode(allFoods[i]
                        //                             .data()['photo']),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             Expanded(
                        //               flex: 3,
                        //               child: Padding(
                        //                 padding: const EdgeInsets.only(
                        //                   left: 10,
                        //                 ),
                        //                 child: Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceEvenly,
                        //                   children: [
                        //                     Text(
                        //                       allFoods[i].data()['name'],
                        //                       overflow: TextOverflow.ellipsis,
                        //                       style: GoogleFonts.poppins(
                        //                         textStyle: const TextStyle(
                        //                           fontSize: 20,
                        //                           fontWeight: FontWeight.w600,
                        //                         ),
                        //                       ),
                        //                     ),
                        //                     Text(
                        //                       "${allFoods[i].data()['kcal']}",
                        //                       overflow: TextOverflow.ellipsis,
                        //                       style: GoogleFonts.poppins(
                        //                         textStyle: const TextStyle(
                        //                           fontSize: 18,
                        //                           fontWeight: FontWeight.w400,
                        //                         ),
                        //                       ),
                        //                     ),
                        //                     Text(
                        //                       "⭐ 4.2",
                        //                       style: GoogleFonts.poppins(
                        //                         textStyle: const TextStyle(
                        //                           fontSize: 18,
                        //                           fontWeight: FontWeight.w400,
                        //                         ),
                        //                       ),
                        //                     ),
                        //                     Container(
                        //                       height: 30,
                        //                       width: 70,
                        //                       alignment: Alignment.center,
                        //                       decoration: BoxDecoration(
                        //                         color:
                        //                             Colors.deepPurple.shade100,
                        //                         borderRadius:
                        //                             BorderRadius.circular(15),
                        //                       ),
                        //                       child: Text(
                        //                         "Love",
                        //                         style: GoogleFonts.poppins(
                        //                           textStyle: const TextStyle(
                        //                             fontSize: 15,
                        //                             color: Colors.white,
                        //                             fontWeight: FontWeight.w700,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: IconButton(
                        //                 onPressed: () {
                        //                   showDialog(
                        //                     context: context,
                        //                     builder: (context) => AlertDialog(
                        //                       title:
                        //                           const Text('Are you sure?'),
                        //                       content: const Text(
                        //                           'This action will permanently delete this data'),
                        //                       actions: [
                        //                         TextButton(
                        //                           onPressed: () =>
                        //                               Navigator.pop(
                        //                                   context, false),
                        //                           child: const Text('Cancel'),
                        //                         ),
                        //                         TextButton(
                        //                           onPressed: () async {},
                        //                           child: const Text('Delete'),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   );
                        //                 },
                        //                 icon: const Icon(
                        //                   Icons.delete_outline,
                        //                   color: Colors.red,
                        //                   size: 30,
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // ),
                      ),
                    ],
                  ),
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  void validateInsert() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Center(
              child: Text(
                "Add Records",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () async {
                        ImagePicker picker = ImagePicker();

                        XFile? xFile = await picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 40,
                        );

                        imageBytes = await xFile!.readAsBytes();
                        setState(() {});
                      },
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.deepPurple.shade100,
                        foregroundImage: (imageBytes != null)
                            ? MemoryImage(imageBytes!)
                            : null,
                        child: const Text(
                          "ADD",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              OutlinedButton(
                child: const Text("Add"),
                onPressed: () async {
                  String photoString = base64Encode(imageBytes!);

                  print("===================================================");
                  print("===================================================");
                  log(photoString);
                  print("===================================================");
                  print("===================================================");

                  Navigator.pop(context);
                },
              ),
              OutlinedButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
