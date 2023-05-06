import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_order/views/screens/cart_page.dart';
import 'package:food_order/views/screens/detail_page.dart';
import 'package:food_order/views/screens/favourite_page.dart';
import 'package:food_order/views/screens/home_page.dart';
import 'package:food_order/views/screens/login_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login_page',
      getPages: [
        GetPage(name: '/', page: () => const Home_Page()),
        GetPage(
            name: '/detail_page',
            page: () => const Detail_Page(
                  data: {},
                )),
        GetPage(name: '/cart_page', page: () => const Cart_Page()),
        GetPage(name: '/favourite_page', page: () => const Favourite_Page()),
        GetPage(name: '/login_page', page: () => const Login_Page()),
      ],
    ),
  );
}
