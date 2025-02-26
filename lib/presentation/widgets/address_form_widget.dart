import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clothing_zodiac/controllers/address_controller.dart';

class AddressFormWidget extends StatelessWidget {
  final AddressController addressController;

  const AddressFormWidget({super.key, required this.addressController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController addressTextController = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add New Address",
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: titleController,
            decoration: _customInputDecoration("Title"),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: phoneController,
            decoration: _customInputDecoration("Phone Number"),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: addressTextController,
            decoration: _customInputDecoration("Address"),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                addressController.addAddress(
                  titleController.text,
                  phoneController.text,
                  addressTextController.text,
                );
                Navigator.pop(context);
              },
              child: Text(
                "Save Address",
                style: GoogleFonts.montserrat(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // TODO: custom input
  InputDecoration _customInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.grey.shade700,
      ),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}
