import 'package:flutter/material.dart';
import 'package:newproject4/components/my_button.dart';
import 'package:newproject4/components/my_textfield.dart';
import 'package:newproject4/services/Auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //login method
  void login() async {
    final _authService = AuthService();

    //TRY SIGN IN
    try {
      await _authService.signInWithEmailPassword(
        emailController.text,
        passwordController.text,
      );
    }
    //display error
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
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
                "  PT. Allure Berkah Sejahtera\nConcrete & Civil Laboratories,\n   Investigation & Consultan",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),

              const SizedBox(
                height: 25,
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
              //forgot password
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     GestureDetector(
              //       onTap: widget.onTap,
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 25.0),
              //         child: Text(
              //           "Forgot Password?",
              //           style: TextStyle(
              //               color: Theme.of(context).colorScheme.inversePrimary,
              //               fontWeight: FontWeight.bold),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              // const SizedBox(
              //   height: 15,
              // ),
              //sign in button
              MyButton(
                text: "Sign in",
                onTap: login,
              ),

              const SizedBox(
                height: 25,
              ),

              //not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Register Now",
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
