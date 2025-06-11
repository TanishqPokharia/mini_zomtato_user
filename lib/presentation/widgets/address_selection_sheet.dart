import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/address/address_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/cart/cart_bloc.dart';
import 'package:mini_zomato_user/presentation/screens/add_address_screen.dart';
import 'package:mini_zomato_user/presentation/widgets/address_tile.dart';
import 'package:mini_zomato_user/utils/extensions/responsive_extension.dart';
import 'package:mini_zomato_user/utils/extensions/theme_extensions.dart';

class AddressSelectionSheet extends StatefulWidget {
  const AddressSelectionSheet({super.key});

  @override
  State<AddressSelectionSheet> createState() => _AddressSelectionSheetState();
}

class _AddressSelectionSheetState extends State<AddressSelectionSheet> {
  @override
  void initState() {
    super.initState();
    context.read<AddressBloc>().add(AddressFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight / 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: context.rs(24), left: context.rs(16)),
            child: Text(
              "Select an address",
              style: context.textTheme.headlineMedium,
            ),
          ),
          Divider(),
          Expanded(
            child: ListView(
              children: [
                Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: context.rs(16),
                    vertical: context.rs(12),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddAddressScreen(),
                        ),
                      );
                    },
                    leading: Icon(Icons.add, color: Colors.redAccent),
                    trailing: Icon(Icons.arrow_forward_ios),
                    title: Text(
                      "Add address",
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade700)),
                    Text(
                      "Saved Addresses",
                      style: context.textTheme.headlineSmall!.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade700)),
                  ],
                ),
                BlocConsumer<AddressBloc, AddressState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is AddressLoading) {
                      return Padding(
                        padding: EdgeInsets.only(top: context.rs(100)),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (state is AddressFailure) {
                      return Padding(
                        padding: EdgeInsets.only(top: context.rs(100)),
                        child: Center(child: Text(state.message)),
                      );
                    } else if (state is AddressSuccess) {
                      if (state.addresses.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.only(top: context.rs(100)),
                          child: Center(
                            child: Text(
                              "No saved addresses",
                              style: context.textTheme.bodyLarge,
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.all(context.rs(10)),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.addresses.length,
                            itemBuilder: (context, index) {
                              final address = state.addresses[index];
                              return AddressTile(
                                address: address,
                                onAddressSelected: () {
                                  context.read<CartBloc>().add(
                                    CartAddressSetEvent(address),
                                  );
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        );
                      }
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
