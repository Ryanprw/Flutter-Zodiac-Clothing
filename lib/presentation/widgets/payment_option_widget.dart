import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentOptionWidget extends StatelessWidget {
  final String method;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onSelected;

  const PaymentOptionWidget({
    super.key,
    required this.method,
    required this.iconPath,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Radio(
              value: method,
              groupValue: isSelected ? method : null,
              activeColor: Colors.black,
              onChanged: (_) => onSelected(),
            ),
            Image.asset(iconPath, width: 40, height: 40, fit: BoxFit.contain),
            const SizedBox(width: 10),
            Text(
              method,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
