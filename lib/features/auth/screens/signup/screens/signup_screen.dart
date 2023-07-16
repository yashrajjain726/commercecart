import 'package:flutter/material.dart';

import '../../../../../common/ui_widgets/custom_button.dart';
import '../../../../../common/ui_widgets/custom_textfield.dart';
import '../../../../../constants/utils.dart';
import '../../../services/auth_service.dart';
import '../../login/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late TextEditingController _confirmPassController;
  late TextEditingController _nameController;
  final GlobalKey<FormState> _signUpKey = GlobalKey();
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPassController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 6,
                  child: const Text(
                    'Commercecart',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: SizedBox(
                  child: Form(
                    key: _signUpKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create an account',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Buy the latest trends today',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          text: 'Name',
                          controller: _nameController,
                          hintText: 'Enter your name',
                          validator: (String? value) =>
                              checkNullAndEmpty(value, 'name'),
                        ),
                        CustomTextField(
                          text: 'Email',
                          controller: _emailController,
                          hintText: 'Enter your email',
                          validator: (String? value) =>
                              validateEmail(value, 'email'),
                        ),
                        CustomTextField(
                            text: 'Password',
                            controller: _passwordController,
                            hintText: 'Enter your password',
                            validator: (String? value) =>
                                checkNullAndEmpty(value, 'password')),
                        CustomTextField(
                            text: 'Confirm Password',
                            obscure: true,
                            controller: _confirmPassController,
                            hintText: 'Enter your confirm password',
                            validator: (String? value) =>
                                validateConfirmPassword(
                                    _passwordController.text, value!)),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            CustomButton(
                                onPressed: () {
                                  if (_signUpKey.currentState!.validate()) {
                                    authService.signUpUser(
                                        context: context,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        name: _nameController.text);
                                  }
                                },
                                text: 'SignUp'),
                            const SizedBox(height: 10),
                            const Text('OR'),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                    child: CustomButton(
                                        onPressed: () {},
                                        text: 'Google (Coming Soon)')),
                                Expanded(
                                    child: CustomButton(
                                        onPressed: () {},
                                        text: 'Apple (Coming Soon)')),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
