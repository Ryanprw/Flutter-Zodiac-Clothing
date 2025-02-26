import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart'; // 🔥 Import Shimmer

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<dynamic> products = [];
  List<dynamic> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulasi delay API

    try {
      final String response = await rootBundle.loadString(
        'assets/products.json',
      );
      final data = json.decode(response);
      final categories = (data['categories'] ?? []) as List<dynamic>;

      List<dynamic> allProducts = [];
      for (var category in categories) {
        for (var subcategory in (category['subcategories'] ?? [])) {
          allProducts.addAll(subcategory['products'] ?? []);
        }
      }

      setState(() {
        products = allProducts;
        filteredProducts = allProducts;
      });
    } catch (e) {
      print("Error loading products: $e");
    }
  }

  void _filterProducts(String query) {
    setState(() {
      filteredProducts =
          products
              .where(
                (product) => (product['name']?.toString().toLowerCase() ?? '')
                    .contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Favorite",
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined, size: 24),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: _filterProducts,
                        decoration: InputDecoration(
                          hintText: "Search . . .",
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.search, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 🔥 GridView dengan Shimmer saat loading
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                  double childAspectRatio =
                      constraints.maxWidth > 700 ? 0.8 : 0.65;

                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount:
                        filteredProducts.isEmpty
                            ? 6
                            : filteredProducts.length, // Shimmer tampil 6 item
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (context, index) {
                      if (filteredProducts.isEmpty) {
                        return shimmerEffect();
                      }

                      final product = filteredProducts[index];
                      final List<dynamic>? images =
                          product['images'] as List<dynamic>?;
                      final String imageUrl =
                          (images != null &&
                                  images.isNotEmpty &&
                                  images[0] is String)
                              ? images[0] as String
                              : 'https://via.placeholder.com/400';

                      final String productName =
                          product['name']?.toString() ?? 'No name';
                      final double? price =
                          product['price'] is num
                              ? product['price'].toDouble()
                              : null;
                      final String priceText =
                          price != null
                              ? "\$${price.toStringAsFixed(2)}"
                              : 'No price';

                      return GestureDetector(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Colors.pink,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 15,
                                    right: 15,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "Add to Bag",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              productName,
                              style: GoogleFonts.montserrat(
                                fontSize: constraints.maxWidth > 600 ? 18 : 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              priceText,
                              style: TextStyle(
                                fontSize: constraints.maxWidth > 600 ? 16 : 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✨ Shimmer Effect untuk GridView
  Widget shimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
