import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/controller/auth_controller.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authCont) {
          return Stack(
            children: [
              // Curved background shape
              Positioned(
                top: 0,
                left: 0,
                child: ClipRRect(
                  child: Image.asset(
                    Appimages.authBackground,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Main content
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.071,
                      ),
                      Image.asset(
                        Appimages.authImage,
                        height: 140.h,
                        width: width,
                      ),
                      SizedBox(height: 10.h),
                      CustomText(
                        label: "Sign Up",
                        size: 24.sp,
                        color: kDark,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 24.h),

                      // Customer / Service Provider toggle buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularButton(
                            buttonColor: authCont.tempUserType == "customer"
                                ? kPrimary
                                : kSecondary,
                            buttonText: "Customer",
                            onPressed: () {
                              authCont.setUserType("customer");
                            },
                            textSize: 14.sp,
                            height: 35.h,
                          ),
                          SizedBox(width: 12.w),
                          CircularButton(
                            buttonColor: authCont.tempUserType == "provider"
                                ? kPrimary
                                : kSecondary,
                            buttonText: "Service Provider",
                            onPressed: () {
                              authCont.setUserType("provider");
                            },
                            textSize: 14.sp,
                            height: 35.h,
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Mobile number text field
                            RoundedTextField(
                              label: "Mobile No.",
                              obscureText: false,
                              keyboardType: TextInputType.phone,
                              controller: _phoneController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your mobile number';
                                } else if (value.length != 10) {
                                  return 'Mobile number must be 10 digits';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10.h),
                            RoundedTextField(
                              label: "Email",
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!GetUtils.isEmail(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10.h),
                            RoundedTextField(
                              label: "Password",
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      ),

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

                      // Submit Button with loading state
                      CircularButton(
                        buttonColor: kPrimary,
                        buttonText: authCont.isLoading
                            ? "Submitting..."
                            : "Submit",
                        onPressed: authCont.isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  authCont.registerWithPhone(
                                    name: _nameController.text.trim().isEmpty
                                        ? "SkilzVilla User"
                                        : _nameController.text.trim(),
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    phone: _phoneController.text.trim(),
                                    userType: authCont.tempUserType,
                                  );
                                }
                              },
                        width: double.infinity,
                      ),

                      SizedBox(height: 15.h),

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

                      SizedBox(height: 15.h),

                      // Social login buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // authCont.signInWithGoogle();
                            },
                            child: CircleAvatar(
                              radius: 22.r,
                              backgroundColor: Colors.white,
                              child: Image.asset(
                                Appimages.googleIcon,
                                height: 44.h,
                                width: 44.w,
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          CircleAvatar(
                            radius: 22.r,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.apple,
                              size: 26.sp,
                              color: k232323,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),

                      // Sign up text
                      GestureDetector(
                        onTap: _navigateToLogin,
                        child: Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            style: appStyle(14, kDark, FontWeight.w500),
                            children: [
                              TextSpan(
                                text: "Sign In",
                                style: appStyle(15, kPrimary, FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50.h),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _navigateToLogin() {
    Get.to(() => const LoginScreen());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
