import 'package:clothing_zodiac/presentation/widgets/custom_quantity_button.dart';
import 'package:flutter/material.dart';
import 'package:clothing_zodiac/controllers/cart_controller.dart';

class CartItemWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final int index;
  final CartController cartController;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.index,
    required this.cartController,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    QuantityButton(
                      icon: Icons.remove,
                      onTap: () => cartController.decrementQuantity(index),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                      onTap: () => cartController.incrementQuantity(index),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => cartController.removeFromCart(index),
            icon: const Icon(Icons.delete_outline, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
