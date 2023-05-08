import 'package:food_order/models/icon_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class IconController extends GetxController {
  IconModel icon = IconModel(isTapped: false);

  void tap() {
    icon.isTapped = !icon.isTapped;
    update();
  }
}
