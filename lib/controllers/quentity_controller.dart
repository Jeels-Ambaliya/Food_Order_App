import 'package:food_order/models/quentity_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class QuentityController extends GetxController {
  QuentityModel quentity = QuentityModel(que: 1);

  void increment() {
    quentity.que++;
    update();
  }

  void dicrement() {
    (quentity.que > 1) ? quentity.que-- : null;
    update();
  }

  void empty() {
    quentity.que = 1;
    update();
  }
}
