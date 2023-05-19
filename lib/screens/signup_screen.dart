// ignore_for_file: unnecessary_import, deprecated_member_use, use_build_context_synchronously
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/widgets/test_field_input.dart';

import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    if(_image == null){
      showSnackBar(context, "Please select a photo/image");
      cancel();
      return;
    }

    if(_usernameController.text == null || _usernameController.text.isEmpty){
      showSnackBar(context, "Please enter username");
      cancel();
      return;
    }

    if(_emailController.text == null || _emailController.text.isEmpty){
      showSnackBar(context, "Please enter email");
      cancel();
      return;
    }

    if(!validateEmail(_emailController.text)){
      showSnackBar(context, "Please enter a valid email");
      cancel();
      return;
    }

    if(_passwordController.text == null || _passwordController.text.isEmpty){
      showSnackBar(context, "Please enter password");
      cancel();
      return;
    }

    if(_passwordController.text.length < 6){
      showSnackBar(context, "Password length should be min 6");
      cancel();
      return;
    }



    if(_bioController.text == null || _bioController.text.isEmpty){
      showSnackBar(context, "Please enter Bio");
      cancel();
      return;
    }





      String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!,
      );

      if (res != 'success') {
        // ignore: use_build_context_synchronouslyr
        showSnackBar(context,res);
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
        );
      }


    setState(() {
      _isLoading = false;
    });


  }

  cancel(){
    setState(() {
      _isLoading = false;
    });
  }

  bool validateEmail(String email){

    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }


  void navigateToLogIn() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
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
              const SizedBox(height: 64),

              //cirecle widget
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg',
                          ),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 60,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              //test for username
              TextFieldInput(
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              const SizedBox(height: 16),
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
              //test for bio
              const SizedBox(height: 16),
              TextFieldInput(
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
                textEditingController: _bioController,
              ),

              const SizedBox(height: 16),

              //button login
              const SizedBox(height: 16), //space between button and text
              InkWell(
                onTap: signUpUser,
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
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Sign up'),
                ),
              ),

              const SizedBox(height: 16),
              Flexible(flex: 2, child: Container()),

              //Transition to sign up

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: const Text("Already have an account?"),
                ),
                GestureDetector(
                    onTap: navigateToLogIn,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Text(
                        "Log In",
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
