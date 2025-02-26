import 'package:flutter/material.dart';
import 'payment_option_widget.dart';

class PaymentMethodList extends StatelessWidget {
  final String selectedPayment;
  final Function(String) onPaymentSelected;

  const PaymentMethodList({
    super.key,
    required this.selectedPayment,
    required this.onPaymentSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentOptionWidget(
          method: "Gojek",
          iconPath: "assets/images/gojek.png",
          isSelected: selectedPayment == "Credit Card",
          onSelected: () => onPaymentSelected("Credit Card"),
        ),
        PaymentOptionWidget(
          method: "J&T Express",
          iconPath: "assets/images/jt.png",
          isSelected: selectedPayment == "PayPal",
          onSelected: () => onPaymentSelected("PayPal"),
        ),
        PaymentOptionWidget(
          method: "Ninja Xpress",
          iconPath: "assets/images/ninja.png",
          isSelected: selectedPayment == "Google Pay",
          onSelected: () => onPaymentSelected("Google Pay"),
        ),
      ],
    );
  }
}
