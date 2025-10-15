import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  SizedBox(height: 220.h),
                  Text(
                    "Login as",
                    style: GoogleFonts.poppins(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
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
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Mobile No.",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 16.h),

                  // OTP field (simple boxes)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return Container(
                        height: 50.h,
                        width: 50.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          "-",
                          style: GoogleFonts.poppins(fontSize: 18.sp),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 30.h),

                  // Divider with Or
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade400)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          "Or",
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade400)),
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
                    onTap: () {},
                    child: Text.rich(
                      TextSpan(
                        text: "New User ? ",
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 14.sp,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign up",
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
}
