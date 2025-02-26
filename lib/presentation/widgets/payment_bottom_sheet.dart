import 'package:clothing_zodiac/presentation/screens/home/succes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentBottomSheet extends StatefulWidget {
  @override
  _PaymentBottomSheetState createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  String selectedPaymentMethod = "Credit Card";

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Order Confirmation",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // TODO: payment method
                paymentMethod("Credit Card", "assets/images/mastercard.png"),
                paymentMethod("Debit Card", "assets/images/visa.png"),
                paymentMethod("PayPal", "assets/images/PayPal.png"),
                const SizedBox(height: 20),

                // TODO: Payment button
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
                      Get.showSnackbar(
                        GetSnackBar(
                          title: "Payment",
                          message: "Processing payment...",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.black,
                          duration: const Duration(seconds: 2),
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
                        ),
                      );

                      // TODO: navigasi to succescreen
                      Future.delayed(const Duration(seconds: 3), () {
                        Get.to(
                          () => const SuccessScreen(),
                          transition: Transition.rightToLeftWithFade,
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.fastOutSlowIn,
                        );
                      });
                    },

                    child: Text(
                      "Make a Payment",
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
          ),
        );
      },
    );
  }

  Widget paymentMethod(String title, String asset) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                selectedPaymentMethod == title
                    ? Colors.black
                    : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(asset, width: 40, height: 40),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Radio(
              value: title,
              groupValue: selectedPaymentMethod,
              activeColor: Colors.black,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value.toString();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
