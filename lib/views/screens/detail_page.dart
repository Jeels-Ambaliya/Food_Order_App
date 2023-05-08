import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_order/controllers/favourite_controller.dart';
import 'package:food_order/models/cart_model.dart';
import 'package:food_order/models/favourite_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/icon_controller.dart';
import '../../controllers/quentity_controller.dart';

class Detail_Page extends StatefulWidget {
  final Map data;
  const Detail_Page({Key? key, required this.data}) : super(key: key);

  @override
  State<Detail_Page> createState() => _Detail_PageState();
}

class _Detail_PageState extends State<Detail_Page> {
  CartController cartController = Get.find<CartController>();
  FavouriteController favouriteController = Get.find<FavouriteController>();
  QuentityController quentityController = Get.find<QuentityController>();
  IconController iconController = Get.find<IconController>();

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
          "Food Details",
          style: GoogleFonts.exo2(
            textStyle: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                iconController.tap();

                FavouriteModel data = FavouriteModel(
                  id: int.parse(widget.data['id']),
                  name: "${widget.data['name']}",
                  photo: "${widget.data['photo']}",
                  price: double.parse(widget.data['price']),
                  kcal: "${widget.data['kcal']}",
                );

                favouriteController.addProduct(product: data);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Item Added Successfully..."),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );

                Navigator.pushReplacementNamed(context, '/favourite_page');
                iconController.tap();
              },
              child: GetBuilder<IconController>(builder: (ic) {
                return Icon(
                  (iconController.icon.isTapped)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: (iconController.icon.isTapped)
                      ? Colors.pink
                      : Colors.white,
                  size: 30,
                );
              }),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: Colors.green,
            alignment: Alignment.bottomCenter,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Container(
              height: 700,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 150,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.data['name']}",
                                style: GoogleFonts.exo2(
                                  textStyle: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  "${widget.data['price']} ₹",
                                  style: GoogleFonts.exo2(
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 60,
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.green,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    quentityController.dicrement();
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                GetBuilder<QuentityController>(
                                  builder: (qc) {
                                    return Text(
                                      "${quentityController.quentity.que}",
                                      style: GoogleFonts.exo2(
                                        textStyle: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  onPressed: () {
                                    quentityController.increment();
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "⭐ ${widget.data['rate']}",
                              style: GoogleFonts.exo2(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              "🩸 ${widget.data['kcal']} Kcal",
                              style: GoogleFonts.exo2(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              "⌚️ ${widget.data['time']}min",
                              style: GoogleFonts.exo2(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              "About food",
                              style: GoogleFonts.exo2(
                                textStyle: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "${widget.data['about']}",
                            style: GoogleFonts.exo2(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
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
          ),
          Positioned(
            bottom: 500,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: MemoryImage(
                    base64Decode(widget.data['photo']),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 40),
        child: GestureDetector(
          onTap: () {
            CartModel data = CartModel(
              id: int.parse(widget.data['id']),
              name: "${widget.data['name']}",
              photo: "${widget.data['photo']}",
              price: double.parse(widget.data['price']),
              que: quentityController.quentity.que,
            );

            cartController.addProduct(product: data);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Item Added Successfully..."),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );

            quentityController.empty();
            Navigator.pushReplacementNamed(context, '/cart_page');
          },
          child: Container(
            height: 60,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.green,
            ),
            child: Text(
              "Add to cart",
              style: GoogleFonts.exo2(
                textStyle: const TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
