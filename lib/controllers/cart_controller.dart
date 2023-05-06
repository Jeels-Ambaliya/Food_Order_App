import 'package:flutter/cupertino.dart';
import 'package:food_order/models/cart_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CartController extends ChangeNotifier {
  RxList addedProduct = [].obs;

  get totalQuantity {
    int Quantity = 0;

    addedProduct.forEach((element) {
      Quantity += element.que as int;
    });

    return Quantity;
  }

  get totalPrice {
    double totalPrice = 0;

    addedProduct.forEach((element) {
      totalPrice += element.que * element.price;
    });

    return totalPrice;
  }

  void addProduct({required CartModel product}) {
    addedProduct.add(product);
    notifyListeners();
  }

  void removeProduct({required CartModel product}) {
    addedProduct.remove(product);
    notifyListeners();
  }

  void addQue({required CartModel product}) {
    product.que++;
    notifyListeners();
  }

  void removeQue({required CartModel product}) {
    (product.que > 1) ? product.que-- : addedProduct.remove(product);
    notifyListeners();
  }
}
