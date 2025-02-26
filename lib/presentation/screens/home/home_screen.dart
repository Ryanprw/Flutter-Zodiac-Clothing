import 'dart:convert';
import 'package:clothing_zodiac/presentation/screens/home/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final String response = await rootBundle.loadString('assets/products.json');
    final data = json.decode(response);
    final categories = data['categories'] as List<dynamic>;

    List<dynamic> allProducts = [];
    for (var category in categories) {
      for (var subcategory in category['subcategories']) {
        allProducts.addAll(subcategory['products']);
      }
    }

    setState(() {
      products = allProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO: header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ZODIAC",
                    style: GoogleFonts.montserrat(
                      fontSize: isTablet ? 30 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none, size: 30),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // TODO: search bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 15),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // TODO: banner promo
              AspectRatio(
                aspectRatio: isTablet ? 16 / 6 : 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'http://idoxa9y.sufydely.com/banner.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "MEN'S NEW\nCOLLECTIONS\nFOR FALL",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 28 : 20,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Discounts up to 70%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 18 : 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // TODO: popular section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular",
                    style: TextStyle(
                      fontSize: isTablet ? 26 : 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "See more",
                    style: TextStyle(
                      fontSize: isTablet ? 18 : 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // TODO: product gridview
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isTablet ? 3 : 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: isTablet ? 0.8 : 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];

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
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(
                              milliseconds: 500,
                            ),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ProductDetailScreen(product: product),
                            transitionsBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                            ) {
                              var slideAnimation = Tween<Offset>(
                                begin: const Offset(0.0, 1.0),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOutQuad,
                                ),
                              );

                              return SlideTransition(
                                position: slideAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },

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
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.black,
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
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        // TODO: logic to add bag
                                      },
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
                              fontSize: isTablet ? 18 : 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            priceText,
                            style: TextStyle(
                              fontSize: isTablet ? 16 : 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
