import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/address/address_bloc.dart';
import 'package:mini_zomato_user/utils/extensions/responsive_extension.dart';
import 'package:mini_zomato_user/utils/extensions/theme_extensions.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> values = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(title: Text("Add Address")),
          body: Padding(
            padding: EdgeInsets.all(context.rs(20)),
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a label';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      values['label'] = value ?? '';
                    },
                    decoration: InputDecoration(labelText: 'Label'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a state';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      values['state'] = value ?? '';
                    },
                    decoration: InputDecoration(labelText: 'State'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a city';
                      }
                      return null;
                    },

                    onSaved: (value) {
                      values['city'] = value ?? '';
                    },

                    decoration: InputDecoration(labelText: 'City'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address line 1';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      values['addressLine1'] = value ?? '';
                    },

                    decoration: InputDecoration(labelText: 'Address Line 1'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address line 2';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      values['addressLine2'] = value ?? '';
                    },
                    decoration: InputDecoration(labelText: 'Address Line 2'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a pincode';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid pincode';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      values['pincode'] = value ?? '';
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Pincode'),
                  ),
                  BlocConsumer<AddressBloc, AddressState>(
                    listener: (context, state) {
                      if (state is AddressSuccess) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.message ?? 'Address added successfully',
                            ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AddressLoading) {
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: context.rs(40)),
                          height: context.rs(70),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: SizedBox(
                              height: context.rs(30),
                              width: context.rs(30),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                      return Container(
                        width: double.infinity,
                        height: context.rs(70),
                        margin: EdgeInsets.only(top: context.rs(40)),
                        child: FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // Handle form submission
                              context.read<AddressBloc>().add(
                                AddressAddEvent(
                                  values['label'] ?? '',
                                  values['state'] ?? '',
                                  values['city'] ?? '',
                                  values['addressLine1'] ?? '',
                                  values['addressLine2'] ?? '',
                                  int.parse(values['pincode'] ?? ''),
                                ),
                              );
                            }
                          },
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: Text(
                            "Save",
                            style: context.textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
