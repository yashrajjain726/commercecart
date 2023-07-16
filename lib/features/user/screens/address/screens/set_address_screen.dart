import '../../../../../common/widgets/custom_textformfield.dart';
import '../../../../../constants/globals.dart';
import '../../../../../constants/utils.dart';
import '../../../services/user_service.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../../utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../common/widgets/custom_button.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = '/address';
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final AppSharedPreference appSharedPreference = AppSharedPreference();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _flatController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  String? address;
  final UserService userService = UserService();
  @override
  void dispose() {
    super.dispose();
    _areaController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    _flatController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUserAddress();
  }

  getUserAddress() async {
    address = context.read<UserProvider>().user.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: Globals.appBarGradient),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              (address != null && address!.isNotEmpty)
                  ? Column(
                      children: [
                        Text(
                          address!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text('OR'),
                      ],
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: 'Flat, House no. or Building',
                      controller: _flatController,
                      validator: (String? value) => checkNullAndEmpty(value,
                          'Please enter the Flat, house no. or building'),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      hintText: 'Area, Street',
                      controller: _areaController,
                      validator: (String? value) => checkNullAndEmpty(
                          value, 'Please enter the Area, Street address'),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      hintText: 'Pincode',
                      controller: _pincodeController,
                      validator: (String? value) {
                        checkNullAndEmpty(value, 'Please enter the pincode');
                        if (value!.length != 6) {
                          return 'Please enter valid pincode';
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      hintText: 'Town/City',
                      controller: _cityController,
                      validator: (String? value) =>
                          checkNullAndEmpty(value, 'Please enter Town/city'),
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                        text: const Text('Save Address'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final finalAddress =
                                '${_flatController.text}, ${_areaController.text} , ${_pincodeController.text} , ${_cityController.text}';
                            userService.updateAddress(
                                context: context, address: finalAddress);
                          }
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
