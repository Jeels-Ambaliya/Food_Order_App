import 'package:flutter/cupertino.dart';
import 'package:food_order/models/favourite_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class FavouriteController extends ChangeNotifier {
  RxList favProduct = [].obs;

  void addProduct({required FavouriteModel product}) {
    favProduct.add(product);
    notifyListeners();
  }

  void removeProduct({required FavouriteModel product}) {
    favProduct.remove(product);
    notifyListeners();
  }
}
