import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/rounded_text_field.dart';
import 'package:customer_app/app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Curved background shape
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.87,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: authBackground,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(290),
                  bottomLeft: Radius.circular(120),
                ),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: 220.h),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.26),

                  CustomText(
                    label: "Sign Up",
                    size: 24.sp,
                    color: Colors.black87,
                  ),
                  SizedBox(height: 24.h),

                  // Mobile number text field
                  RoundedTextField(
                    label: "Mobile No.",
                    icon: Icons.phone,
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 16.h),
                  RoundedTextField(
                    label: "Email",
                    icon: Icons.email,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.h),
                  RoundedTextField(
                    label: "Password",
                    icon: Icons.remove_red_eye_outlined,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 8.h),
                  //forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                      label: "Forgot password?",
                      size: 14.sp,
                      color: kPrimary,
                    ),
                  ),

                  SizedBox(height: 30.h),

                  CircularButton(
                    buttonColor: kPrimary,
                    buttonText: "Submit",
                    onPressed: () {},
                    width: double.infinity,
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),

                  // Sign up text
                  GestureDetector(
                    onTap: _navigateToLogin,
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account ? ",
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 14.sp,
                        ),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _navigateToLogin() {
    Get.to(() => const LoginScreen());
  }
}
