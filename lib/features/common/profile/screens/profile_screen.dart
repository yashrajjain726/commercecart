import 'package:commercecart/features/user/services/user_service.dart';

import '../../../../common/ui_widgets/custom_textfield.dart';
import '../../../../common/ui_widgets/custom_button.dart';
import '../../../../constants/utils.dart';
import '../../../../providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  bool isEditEnabled = false;
  final GlobalKey<FormState> _updateKey = GlobalKey();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  final UserService userService = UserService();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _nameController =
        TextEditingController(text: context.watch<UserProvider>().user.name);
    _addressController =
        TextEditingController(text: context.watch<UserProvider>().user.address);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _updateKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: CircleAvatar(
                    child: Icon(Icons.person, size: 50),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  text: 'Name',
                  controller: _nameController,
                  hintText: user.name,
                  enabled: isEditEnabled,
                  validator: (String? value) =>
                      checkNullAndEmpty(value, 'name'),
                ),
                CustomTextField(
                  text: 'Email address',
                  hintText: user.email,
                  enabled: false,
                  validator: (String? value) {},
                ),
                CustomTextField(
                  text: 'User Type',
                  hintText: user.type,
                  enabled: false,
                  validator: (String? value) {},
                ),
                CustomTextField(
                  text: 'Address',
                  hintText: user.address,
                  controller: _addressController,
                  enabled: isEditEnabled,
                  maxLines: 2,
                  validator: (String? value) =>
                      checkNullAndEmpty(value, 'address'),
                ),
                const SizedBox(height: 10),
                CustomButton(
                    text: isEditEnabled ? 'Close' : 'Edit Profile',
                    onPressed: () {
                      setState(() {
                        isEditEnabled = !isEditEnabled;
                      });
                    }),
                isEditEnabled
                    ? CustomButton(
                        text: 'Save',
                        onPressed: () {
                          if (_updateKey.currentState!.validate()) {
                            userService.updateUserData(
                                context: context,
                                address: _addressController.text,
                                name: _nameController.text);
                          }
                        })
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ));
  }
}
