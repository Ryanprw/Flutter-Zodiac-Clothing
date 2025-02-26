import 'package:get/get.dart';

class AddressController extends GetxController {
  var addresses =
      <Map<String, String>>[
        {
          "title": "Home",
          "phone": "+62 888 888 8888",
          "address": "Jakarta, Indonesia",
        },
        {
          "title": "Office",
          "phone": "02161 555-0115",
          "address": "Jakarta, Indonesia",
        },
      ].obs;

  void addAddress(String title, String phone, String address) {
    addresses.add({"title": title, "phone": phone, "address": address});
  }
}
