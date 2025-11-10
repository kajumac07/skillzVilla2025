import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/rounded_text_field.dart';
import 'package:customer_app/app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
            child: ClipRRect(
              child: Image.asset(
                Appimages.authBackground,
                height: MediaQuery.of(context).size.height * 0.87,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: 220.h),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Image.asset(Appimages.authImage, height: 150.h, width: width),
                  SizedBox(height: 10.h),
                  CustomText(label: "Sign Up", size: 32.sp, color: kDark),
                  SizedBox(height: 24.h),

                  // Mobile number text field
                  RoundedTextField(
                    label: "Mobile No.",
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 16.h),
                  RoundedTextField(
                    label: "Email",
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.h),
                  RoundedTextField(
                    label: "Password",
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 8.h),
                  //forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                      label: "Forgot password?",
                      size: 12.sp,
                      color: greyTextColor,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  CircularButton(
                    buttonColor: kPrimary,
                    buttonText: "Submit",
                    onPressed: () {},
                    width: double.infinity,
                  ),
                  SizedBox(height: 25.h),

                  // Divider with Or
                  Row(
                    children: [
                      Spacer(),
                      Expanded(child: Divider(color: Colors.grey.shade400)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          "Or",
                          style: appStyle(14.sp, k232323, FontWeight.w500),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade400)),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.12),

                  // Sign up text
                  GestureDetector(
                    onTap: _navigateToLogin,
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account ? ",
                        style: appStyle(14, kDark, FontWeight.w500),
                        children: [
                          TextSpan(
                            text: "Sign In",
                            style: appStyle(15, kDark, FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
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

  // _submitTap() {
  //   Get.to(() => LocationAccessScreen());
  // }

  //went to provider screen
  // _submitTap() {
  //   Get.to(() => ProviderHomeScreen());
  // }
}
