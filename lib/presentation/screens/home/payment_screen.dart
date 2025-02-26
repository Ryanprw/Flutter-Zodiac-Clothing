import 'package:clothing_zodiac/controllers/cart_controller.dart';
import 'package:clothing_zodiac/controllers/address_controller.dart';
import 'package:clothing_zodiac/presentation/widgets/address_form_widget.dart';
import 'package:clothing_zodiac/presentation/widgets/address_list_widget.dart';
import 'package:clothing_zodiac/presentation/widgets/checkout_summary_widget.dart';
import 'package:clothing_zodiac/presentation/widgets/payment_method_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedAddress = "Home";
  String selectedPayment = "Credit Card";

  final CartController cartController = Get.find<CartController>();
  final AddressController addressController = Get.put(AddressController());
  final double deliveryFee = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDeliveryAddressSection(),
                  const SizedBox(height: 20),
                  _buildPaymentMethodSection(),
                ],
              ),
            ),
          ),
          CheckoutSummaryWidget(
            cartController: cartController,
            deliveryFee: deliveryFee,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Checkout",
        style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildDeliveryAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Delivery to",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add, size: 25, color: Colors.black),
              onPressed: _showAddAddressForm,
            ),
          ],
        ),
        const SizedBox(height: 10),
        AddressListWidget(
          addressController: addressController,
          selectedAddress: selectedAddress,
          onAddressSelected: (value) {
            setState(() {
              selectedAddress = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delivery Method",
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        PaymentMethodList(
          selectedPayment: selectedPayment,
          onPaymentSelected: (value) {
            setState(() {
              selectedPayment = value;
            });
          },
        ),
      ],
    );
  }

  void _showAddAddressForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => AddressFormWidget(addressController: addressController),
    );
  }
}
