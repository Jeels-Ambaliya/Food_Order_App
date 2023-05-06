import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/favourite_controller.dart';

class Favourite_Page extends StatefulWidget {
  const Favourite_Page({Key? key}) : super(key: key);

  @override
  State<Favourite_Page> createState() => _Favourite_PageState();
}

class _Favourite_PageState extends State<Favourite_Page> {
  FavouriteController favouriteController = Get.find<FavouriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
        title: Text(
          "Favourite Page",
          style: GoogleFonts.exo2(
            textStyle: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 10,
              child: Obx(
                () {
                  return ListView.builder(
                    itemCount: favouriteController.favProduct.length,
                    itemBuilder: (context, i) {
                      return Card(
                        elevation: 0,
                        child: Container(
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: MemoryImage(
                                          base64Decode(favouriteController
                                              .favProduct[i].photo),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${favouriteController.favProduct[i].name}",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.exo2(
                                            textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${favouriteController.favProduct[i].price}  🩸${favouriteController.favProduct[i].kcal} kcal",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.exo2(
                                            textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: Colors.green.shade50,
                                          title: Text(
                                            "Are You Sure ?",
                                            style: GoogleFonts.exo2(
                                              textStyle: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          content: Text(
                                            "This action will permanently delete this data",
                                            style: GoogleFonts.exo2(
                                              textStyle: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              child: Text(
                                                "Cancel",
                                                style: GoogleFonts.exo2(
                                                  textStyle: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                favouriteController
                                                    .removeProduct(
                                                        product:
                                                            favouriteController
                                                                .favProduct[i]);

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Record Deleted Successfully..."),
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                  ),
                                                );

                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Sure",
                                                style: GoogleFonts.exo2(
                                                  textStyle: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
