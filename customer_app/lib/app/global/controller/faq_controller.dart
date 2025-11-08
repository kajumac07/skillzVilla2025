import 'package:get/get.dart';

class FaqController extends GetxController {
  var expandedIndex = (-1).obs;

  void toggleIndex(int index) {
    expandedIndex.value = expandedIndex.value == index ? -1 : index;
  }
}
