import 'package:commercecart/common/ui_widgets/custom_button.dart';
import 'package:commercecart/common/ui_widgets/custom_textfield.dart';
import 'package:commercecart/common/ui_widgets/loader.dart';
import 'package:commercecart/constants/utils.dart';
import 'package:commercecart/features/auth/screens/signup_screeen.dart';
import 'package:commercecart/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _signInKey = GlobalKey();
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                const Text('Don\t have an account? '),
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, SignUpScreen.routeName),
                  child: const Text(
                    'Sign Up',
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
                  height: MediaQuery.of(context).size.height / 4,
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
                    key: _signInKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hi, Welcome Back!',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Hello again, you\'ve been missed!',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
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
                            obscure: true,
                            controller: _passwordController,
                            hintText: 'Enter your password',
                            validator: (String? value) =>
                                checkNullAndEmpty(value, 'password')),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Forgot password ? (Coming soon)',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            CustomButton(
                                onPressed: () {
                                  if (_signInKey.currentState!.validate()) {
                                    authService.sigInUser(
                                      context: context,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                  }
                                },
                                text: 'Login'),
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
