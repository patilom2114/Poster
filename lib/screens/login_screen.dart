// ignore_for_file: unnecessary_import, deprecated_member_use, unused_import, avoid_unnecessary_containers, use_build_context_synchronously, duplicate_ignore
import 'package:flutter/material.dart';

import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/screens/signup_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/widgets/test_field_input.dart';

import '../resources/auth_methods.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res != 'Success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(res as BuildContext, context as String);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),

              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        for (int i = 0; i < 'Posters'.length; i++)
                          TextSpan(
                            text: 'Posters'[i],
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                              color: _getLetterColor(i),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                      height: 1), // Space between "Posters" and "Just Post It"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 'Just Post It'.length; i++)
                        Text(
                          'Just Post It'[i],
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Instagram',
                            height: 1.0,
                            color: _getLetterColor(i),
                          ),
                        ),
                    ],
                  ),
                ],
              ),

              // SvgPicture.asset(x
              //   'assets/ic_instagram.svg',rR
              //   color: primaryColor,
              //   height: 64,
              // ),
              const SizedBox(height: 64),
              //test for mail
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              //test for password
              const SizedBox(height: 16),
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.visiblePassword,
                textEditingController: _passwordController,
                ifPass: true,
              ),
              //button login
              const SizedBox(height: 16), //space between button and text
              InkWell(
                onTap: loginUser,
                child: Container(
                    child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: blueColor,
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        )
                      : const Text('Log In'),
                )),
              ),

              const SizedBox(height: 16),
              Flexible(flex: 2, child: Container()),

              //Transition to sign up

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: const Text("Don't have an account?"),
                ),
                GestureDetector(
                    onTap: navigateToSignUp,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ))
              ])
            ],
          ),
        ),

        //transition to sign up
      ),
    );
  }
}

Color _getLetterColor(int index) {
  final List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
  ];

  return colors[index % colors.length];
}
