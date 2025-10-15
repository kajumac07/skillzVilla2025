import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/rounded_text_field.dart';
import 'package:customer_app/app/screens/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: 220.h),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.26),

                  CustomText(label: "Login as", size: 32.sp, color: kDark),
                  SizedBox(height: 24.h),

                  // Customer / Service Provider toggle buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CircularButton(
                          buttonColor: kSecondary,
                          buttonText: "Customer",
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CircularButton(
                          buttonColor: kPrimary,
                          buttonText: "Service Provider",
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30.h),

                  // Mobile number text field
                  RoundedTextField(
                    label: "Mobile/Email ID",
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 16.h),

                  // OTP field (simple boxes)
                  Container(
                    height: 46.h,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            label: "OTP",
                            size: 14,
                            fontWeight: FontWeight.w300,
                          ),
                          Row(
                            children: List.generate(5, (index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  right: index != 4 ? 4.w : 0,
                                ),
                                child: Container(
                                  height: 30.h,
                                  width: 29.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    "",
                                    style: GoogleFonts.poppins(fontSize: 18.sp),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Divider with Or
                  Row(
                    children: [
                      Spacer(),
                      Expanded(child: Divider(color: Colors.grey.shade400)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          "Or",
                          style: GoogleFonts.poppins(color: Colors.black26),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade400)),
                      Spacer(),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // Social login buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 22.r,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          Appimages.googleIcon,
                          height: 44.h,
                          width: 44.w,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      CircleAvatar(
                        radius: 22.r,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.apple, size: 26.sp),
                      ),
                    ],
                  ),

                  SizedBox(height: 90.h),

                  // Sign up text
                  GestureDetector(
                    onTap: _navigateToRegister,
                    child: Text.rich(
                      TextSpan(
                        text: "New User ? ",
                        style: appStyle(15, kDark, FontWeight.normal),
                        children: [
                          TextSpan(
                            text: "Sign up",
                            style: appStyle(14, kDark, FontWeight.w600),
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

  _navigateToRegister() {
    Get.to(() => const RegisterScreen());
  }
}
