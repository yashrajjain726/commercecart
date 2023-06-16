import 'package:commercecart/common/widgets/custom_button.dart';
import 'package:commercecart/common/widgets/custom_textformfield.dart';
import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService authService = AuthService();

  final GlobalKey<FormState> _signInKey = GlobalKey();
  final GlobalKey<FormState> _signUpKey = GlobalKey();
  Auth _auth = Auth.signup;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.greyBackgroundCOlor,
      appBar: AppBar(title: const Text('Auth Screen')),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 20),
            ),
            ListTile(
              selected: _auth == Auth.signup,
              selectedTileColor: Colors.white,
              leading: Radio(
                activeColor: Globals.secondaryColor,
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? _val) {
                  setState(() {
                    _auth = _val!;
                  });
                },
              ),
              title: const Text(
                'Create Account.',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            _auth == Auth.signup
                ? Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _signUpKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                              controller: _emailController, hintText: 'Email'),
                          const SizedBox(height: 10),
                          CustomTextFormField(
                              controller: _nameController, hintText: 'Name'),
                          const SizedBox(height: 10),
                          CustomTextFormField(
                              obscure: true,
                              controller: _passwordController,
                              hintText: 'Password'),
                          const SizedBox(height: 10),
                          CustomButton(
                              text: 'Create Account',
                              onPressed: () {
                                if (_signUpKey.currentState!.validate()) {
                                  authService.signUpUser(
                                    context: context,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    name: _nameController.text,
                                  );
                                }
                              })
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            ListTile(
              selected: _auth == Auth.signin,
              selectedTileColor: Colors.white,
              leading: Radio(
                activeColor: Globals.secondaryColor,
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (Auth? _val) {
                  setState(() {
                    _auth = _val!;
                  });
                },
              ),
              title: const Text(
                'Sign In',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            _auth == Auth.signin
                ? Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _signInKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                              controller: _emailController, hintText: 'Email'),
                          const SizedBox(height: 10),
                          CustomTextFormField(
                              obscure: true,
                              controller: _passwordController,
                              hintText: 'Password'),
                          const SizedBox(height: 10),
                          CustomButton(
                              text: 'Sign In',
                              onPressed: () {
                                if (_signInKey.currentState!.validate()) {
                                  authService.sigInUser(
                                    context: context,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                }
                              })
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      )),
    );
  }
}
