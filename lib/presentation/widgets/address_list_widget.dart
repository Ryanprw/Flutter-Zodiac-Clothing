import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clothing_zodiac/controllers/address_controller.dart';

import 'address_option_widget.dart';

class AddressListWidget extends StatelessWidget {
  final AddressController addressController;
  final String selectedAddress;
  final Function(String) onAddressSelected;

  const AddressListWidget({
    super.key,
    required this.addressController,
    required this.selectedAddress,
    required this.onAddressSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children:
            addressController.addresses.map((address) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AddressOptionWidget(
                  title: address["title"]!,
                  phone: address["phone"]!,
                  address: address["address"]!,
                  isSelected: selectedAddress == address["title"],
                  onSelected: () => onAddressSelected(address["title"]!),
                ),
              );
            }).toList(),
      ),
    );
  }
}
