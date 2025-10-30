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
  List<TextEditingController> _otpControllers = [];
  List<FocusNode> _otpFocusNodes = [];

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(5, (_) => TextEditingController());
    _otpFocusNodes = List.generate(5, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _otpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Image.asset(Appimages.authImage, height: 150.h, width: width),
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
                          textSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CircularButton(
                          buttonColor: kPrimary,
                          buttonText: "Service Provider",
                          onPressed: () {},
                          textSize: 14.sp,
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

                  // OTP input field with TextFields
                  Container(
                    height: 60.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
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
                              child: SizedBox(
                                width: 29.w,
                                height: 30.h,
                                child: TextField(
                                  controller: _otpControllers[index],
                                  focusNode: _otpFocusNodes[index],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  cursorWidth: 1.5,
                                  cursorColor: Colors.black,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 1.1,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide(
                                        color: kPrimary,
                                        width: 1.3,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty && index < 4) {
                                      _otpFocusNodes[index + 1].requestFocus();
                                    } else if (value.isEmpty && index > 0) {
                                      _otpFocusNodes[index - 1].requestFocus();
                                    }
                                  },
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
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

                  SizedBox(height: 50.h),

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
