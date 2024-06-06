// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:newproject4/components/my_button.dart';
import 'package:newproject4/components/my_textfield.dart';
import 'package:newproject4/services/Auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void register() async {
    //get auth services
    final _authService = AuthService();
    //check if passwords match -> create user
    if (passwordController.text == confirmPasswordController.text) {
      //try creating user
      try {
        await _authService.signUpWithEmailPassword(
          emailController.text,
          passwordController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }
    //if password dont match -> show error
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password don't match!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Image.asset(
                'image/allure.png',
                width: 150,
                height: 150,
              ),

              const SizedBox(
                height: 1,
              ),
              //app slogan
              Text(
                "Let's create an account for you",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              //email text
              MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),

              const SizedBox(
                height: 10,
              ),
              //password text
              MyTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),

              const SizedBox(
                height: 10,
              ),
              //password text
              MyTextField(
                controller: confirmPasswordController,
                hintText: "Confirm password",
                obscureText: true,
              ),

              const SizedBox(
                height: 10,
              ),

              const SizedBox(
                height: 5,
              ),
              //sign Up button
              MyButton(
                text: "Sign Up",
                onTap: register, // Memanggil fungsi register di sini
              ),

              const SizedBox(
                height: 15,
              ),

              //Already have an account? Login now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login Now",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
