import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;

  void addToCart(Map<String, dynamic> product) {
    int index = cartItems.indexWhere((item) => item['name'] == product['name']);
    if (index != -1) {
      cartItems[index]['quantity'] += 1;
    } else {
      cartItems.add({...product, 'quantity': 1});
    }
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
  }

  void incrementQuantity(int index) {
    cartItems[index]['quantity'] += 1;
    cartItems.refresh();
  }

  void decrementQuantity(int index) {
    if (cartItems[index]['quantity'] > 1) {
      cartItems[index]['quantity'] -= 1;
      cartItems.refresh();
    }
  }

  double get subtotal => cartItems.fold(
    0,
    (sum, item) => sum + (item['price'] * item['quantity']),
  );
}
