import 'package:get/get.dart';

class SubCategoryController extends GetxController {
  var showSidebar = false.obs;
  var selectedProvider = Rxn<int>();

  void toggleSidebar() {
    showSidebar.value = !showSidebar.value;
    if (!showSidebar.value) selectedProvider.value = null;
  }

  void selectProvider(int index) {
    selectedProvider.value = index;
  }
}
