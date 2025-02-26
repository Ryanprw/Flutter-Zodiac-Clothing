import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clothing_zodiac/controllers/cart_controller.dart';
import 'package:clothing_zodiac/presentation/widgets/summary_row_widget.dart';
import 'package:clothing_zodiac/presentation/widgets/payment_bottom_sheet.dart'; // Import Bottom Sheet

class CheckoutSummaryWidget extends StatelessWidget {
  final CartController cartController;
  final double deliveryFee;

  const CheckoutSummaryWidget({
    super.key,
    required this.cartController,
    required this.deliveryFee,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Obx(
            () => SummaryRowWidget(
              title: "Sub total",
              value: "\$${cartController.subtotal.toStringAsFixed(2)}",
            ),
          ),
          SummaryRowWidget(
            title: "Delivery fee",
            value: "\$${deliveryFee.toStringAsFixed(2)}",
          ),
          const Divider(),
          Obx(
            () => SummaryRowWidget(
              title: "Total",
              value:
                  "\$${(cartController.subtotal + deliveryFee).toStringAsFixed(2)}",
              isBold: true,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // MEMUNCULKAN BOTTOM SHEET PEMBAYARAN
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => PaymentBottomSheet(),
                );
              },
              child: Text(
                "Payments",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
