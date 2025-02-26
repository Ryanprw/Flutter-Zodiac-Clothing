import 'package:clothing_zodiac/controllers/cart_controller.dart';
import 'package:clothing_zodiac/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedImageIndex = 0;
  int quantity = 1;
  String selectedSize = 'M';
  String selectedColor = 'Beige';

  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  final List<String> colors = ['Beige', 'Black', 'Red', 'Blue'];

  @override
  Widget build(BuildContext context) {
    final images = widget.product['images'] as List<dynamic>;
    final name = widget.product['name'] ?? 'No name';
    final price = widget.product['price'] ?? 0.0;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenHeight * 0.45;
    final isSmallScreen = screenWidth < 360;

    final cartController = Get.find<CartController>();
    final navigationController = Get.find<NavigationController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: imageHeight,
                        margin: const EdgeInsets.only(top: 15),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                images[_selectedImageIndex],
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 70,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(
                                    images.length > 4 && screenHeight < 700
                                        ? 4
                                        : images.length,
                                    (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedImageIndex = index;
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            border: Border.all(
                                              color:
                                                  _selectedImageIndex == index
                                                      ? Colors.black
                                                      : Colors.transparent,
                                              width: 2,
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                images[index],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: GoogleFonts.poppins(
                                fontSize: isSmallScreen ? 18 : 20,
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "\$${price.toStringAsFixed(2)}",
                            style: GoogleFonts.poppins(
                              fontSize: isSmallScreen ? 20 : 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Size",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              sizes.map((size) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSize = size;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isSmallScreen ? 15 : 20,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          selectedSize == size
                                              ? Colors.black
                                              : Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      size,
                                      style: TextStyle(
                                        color:
                                            selectedSize == size
                                                ? Colors.white
                                                : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Color",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              colors.map((color) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = color;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isSmallScreen ? 15 : 20,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          selectedColor == color
                                              ? Colors.black
                                              : Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      color,
                                      style: TextStyle(
                                        color:
                                            selectedColor == color
                                                ? Colors.white
                                                : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.1),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    // TODO: quainty selector
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                            icon: const Icon(Icons.remove, size: 20),
                          ),
                          Text(
                            quantity.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon: const Icon(Icons.add, size: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    // TODO: logicic add to bag
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          cartController.addToCart({
                            'id': widget.product['id'],
                            'name': widget.product['name'],
                            'price': widget.product['price'],
                            'images': widget.product['images'],
                            'quantity': quantity,
                            'size': selectedSize,
                            'color': selectedColor,
                          });

                          // TODO: notification susccess
                          Get.snackbar(
                            "Success",
                            "${widget.product['name']} has been added to your bag!",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.black,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 5),
                            borderRadius: 15,
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 28,
                            ),
                            shouldIconPulse: true,
                            overlayBlur: 1.5,
                            barBlur: 5,
                            isDismissible: true,
                            forwardAnimationCurve: Curves.easeOutBack,
                          );
                          navigationController.changePage(3);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Add to Bag",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
