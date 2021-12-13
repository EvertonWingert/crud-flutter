import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:organizador_de_boletos/app/data/controller/auth_controller.dart';
import 'package:organizador_de_boletos/app/data/repository/auth_repository.dart';
import 'package:organizador_de_boletos/app/data/repository/billet_repository.dart';
import 'package:organizador_de_boletos/app/routes/app_routes.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailFieldController = TextEditingController(text: '');
  TextEditingController passwordFieldController = TextEditingController();
  var passwordVisibility = true;
  var errors = [];

  final _formKey = GlobalKey<FormState>();

  _signUp(context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    var service = AuthRepository();
    final authController = AuthController();

    try {
      final response = await service.register(
          emailFieldController.text, passwordFieldController.text);
      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, Routes.home);
        authController.register();
      }
    } catch (e) {
      print('erro : ${e}');
    } finally {
      print('acabou');
    }
  }

  _required(val) {
    if (val!.isEmpty) {
      return 'Campo obrigatório';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Registrar',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailFieldController,
                  validator: (val) => _required(val),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: passwordFieldController,
                  obscureText: passwordVisibility,
                  validator: (val) => _required(val),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Senha',
                    prefixIcon: Icon(
                      Icons.password,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(
                          () => {passwordVisibility = !passwordVisibility},
                        );
                      },
                      icon: Icon(
                        passwordVisibility
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(
                      double.infinity,
                      40,
                    ),
                  ),
                  onPressed: () => _signUp(context),
                  child: const Text(
                    'Registrar',
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, Routes.signin),
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
