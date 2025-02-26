import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildHeader(),
          Positioned(top: 220, left: 0, right: 0, child: _buildContent()),
          Positioned(
            top: 130,
            left: MediaQuery.of(context).size.width / 2 - 55,
            child: _buildProfilePicture(),
          ),
        ],
      ),
    );
  }

  // TODO: Header
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Profile',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.login_outlined,
                size: 28,
                color: Colors.white,
              ),
              onPressed: () {
                Get.defaultDialog(
                  title: "Logout",
                  titleStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  middleText: "Are you sure you want to log out?",
                  textConfirm: "Yes",
                  textCancel: "No",
                  confirmTextColor: Colors.white,
                  buttonColor: Colors.black,
                  cancelTextColor: Colors.black,
                  barrierDismissible: false,
                  onConfirm: () {
                    Get.offAllNamed('/login');
                  },
                  onCancel: () {
                    Get.back();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // TODO: ImagePicture
  Widget _buildProfilePicture() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          'http://idoxa9y.sufydely.com/reynmen.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // TODO: fill content
  Widget _buildContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Ryan Prawira',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Orders',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'View all',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildProductList(),
          const SizedBox(height: 60),
          _buildSettingsItem(Icons.payment, 'Payment settings'),
          _buildSettingsItem(Icons.privacy_tip, 'Privacy & Policy'),
        ],
      ),
    );
  }

  // TODO: List Product
  Widget _buildProductList() {
    return SizedBox(
      height: 220,
      child:
          products.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
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

                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Image.network(
                                  imageUrl,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                left: 15,
                                right: 15,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent
                                        .withOpacity(0.4),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    'Details',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productName,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  priceText,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
