import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:blog/color.dart';
import 'package:blog/main.dart';
import 'package:blog/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();

  void login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      var fetchdata = {
        'email': email,
        'password': password,
      };

      Map<String, dynamic> response =
          await ApiInstance.login('/auth/login', fetchdata);
      print(response['token']);

      if (response['token'] != null) {
        await storage.write(key: 'id', value: response['id'].toString());
        await storage.write(
            key: 'name',
            value: response['first_name'] + ' ' + response['last_name']);
        await storage.write(key: 'token', value: response['token']);
        await storage.write(key: 'email', value: response['email']);
        await storage.write(
            key: 'refreshToken', value: response['refreshToken']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
        );
      } else {
        const snackbar = SnackBar(
          content: Text('Invalid email or password'),
          backgroundColor: Color(0xFFD32F2F),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(
              left: 24, right: 24, top: MediaQuery.of(context).padding.top),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 90),
                Text(
                  'Welcome back 👋',
                  style: GoogleFonts.urbanist(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    height: 1.6,
                  ).copyWith(
                    color: AppColors.kGreyScale900,
                  ),
                ),
                Text(
                  'Please enter your email & password to sign in.',
                  style: GoogleFonts.urbanist(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 1.6,
                    letterSpacing: 0.2,
                  ).copyWith(
                    color: AppColors.kGreyScale900,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Email',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.6,
                    letterSpacing: 0.2,
                  ).copyWith(
                    color: AppColors.kGreyScale900,
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Password',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.6,
                    letterSpacing: 0.2,
                  ).copyWith(
                    color: AppColors.kGreyScale900,
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                  controller: _passwordController,
                ),
                Row(
                  children: [
                    SimpleCheckBox(
                      checked: true,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Remember me',
                      style: GoogleFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                        letterSpacing: 0.2,
                      ).copyWith(
                        color: AppColors.kGreyScale900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 48),
                      backgroundColor: AppColors.kPrimary,
                      foregroundColor: const Color(0xFFFFFFFF),
                    ),
                    onPressed: () => login(),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 1.6,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
                // Center(
                //   child: InkWell(
                //     onTap: () {},
                //     child: Text(
                //       'Forgot password?',
                //       style: GoogleFonts.urbanist(
                //         fontSize: 18,
                //         fontWeight: FontWeight.w700,
                //         height: 1.6,
                //       ).copyWith(
                //         color: AppColors.kPrimary,
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Don’t have an account?",
                //       style: GoogleFonts.urbanist(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w700,
                //         height: 1.6,
                //         letterSpacing: 0.2,
                //       ).copyWith(
                //         color: AppColors.kGreyScale900,
                //       ),
                //     ),
                //     const SizedBox(width: 8),
                //     InkWell(
                //       child: Text(
                //         'Sign up',
                //         style: GoogleFonts.urbanist(
                //           fontSize: 16,
                //           fontWeight: FontWeight.w700,
                //           height: 1.6,
                //           letterSpacing: 0.2,
                //         ).copyWith(
                //           color: AppColors.kPrimary,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.onTap,
    required this.label,
    this.color,
    this.width,
    this.height,
    this.style,
    super.key,
  });
  final void Function() onTap;
  final String label;
  final Color? color;
  final double? width;
  final double? height;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: Container(
        width: width ?? Get.width,
        height: (height ?? 58),
        decoration: BoxDecoration(
          color: color ?? AppColors.kPrimary,
          borderRadius: BorderRadius.circular(100),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: style ??
              GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.6,
                letterSpacing: 0.2,
              ).copyWith(
                color: AppColors.kWhite,
              ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SimpleCheckBox extends StatefulWidget {
  SimpleCheckBox({required this.checked, super.key});
  bool checked;
  @override
  State<SimpleCheckBox> createState() => _SimpleCheckBoxState();
}

class _SimpleCheckBoxState extends State<SimpleCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.3,
      child: Checkbox.adaptive(
        activeColor: AppColors.kPrimary,
        checkColor: AppColors.kWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: AppColors.kPrimary, width: 2.75),
        value: widget.checked,
        onChanged: (checked) {
          setState(() {
            widget.checked = checked ?? false;
          });
        },
      ),
    );
  }
}
