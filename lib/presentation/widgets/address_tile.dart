import 'package:flutter/material.dart';
import 'package:mini_zomato_user/domain/entities/address.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({super.key, required this.address, this.onAddressSelected});

  final Address address;
  final void Function()? onAddressSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onAddressSelected,
      title: Text(address.label),
      leading: Icon(Icons.location_on, color: Colors.redAccent),
      trailing: Icon(Icons.arrow_forward_ios),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(address.addressLine1),
          Text(address.addressLine2),
          Text("${address.city}, ${address.state} - ${address.pincode}"),
        ],
      ),
      isThreeLine: true,
    );
  }
}
