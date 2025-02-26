import 'package:clothing_zodiac/presentation/screens/home/payment_screen.dart';
import 'package:clothing_zodiac/presentation/widgets/custom_price_row.dart';
import 'package:clothing_zodiac/presentation/widgets/custom_quantity_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clothing_zodiac/controllers/cart_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find();

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double shippingCost = 10.0;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bag',
                    style: GoogleFonts.montserrat(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined, size: 30),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // TODO: search bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search . . .',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // TODO: list product
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartController.cartItems[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              item['images'][0],
                              width: screenWidth * 0.25,
                              height: screenWidth * 0.25,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "\$${item['price'].toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    QuantityButton(
                                      icon: Icons.remove,
                                      onTap:
                                          () => cartController
                                              .decrementQuantity(index),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Text(
                                        item['quantity'].toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    QuantityButton(
                                      icon: Icons.add,
                                      onTap:
                                          () => cartController
                                              .incrementQuantity(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: "Delete Item",
                                titleStyle: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                middleText:
                                    "Are you sure you deleted your cart?",
                                textConfirm: "Yes",
                                textCancel: "No",
                                confirmTextColor: Colors.white,
                                buttonColor: const Color.fromARGB(255, 0, 0, 0),
                                cancelTextColor: Colors.black,
                                onConfirm: () {
                                  cartController.removeFromCart(index);
                                  Get.back();
                                },
                                onCancel: () {
                                  Get.back();
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),

            // TODO: checkout section
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: 20,
              ),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PriceRow(
                    label: 'Subtotal:',
                    amount: "\$${cartController.subtotal.toStringAsFixed(2)}",
                  ),
                  PriceRow(
                    label: 'Tax:',
                    amount: "\$${shippingCost.toStringAsFixed(2)}",
                  ),
                  const Divider(thickness: 1),
                  PriceRow(
                    label: 'Total:',
                    amount:
                        "\$${(cartController.subtotal + shippingCost).toStringAsFixed(2)}",
                    isBold: true,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
