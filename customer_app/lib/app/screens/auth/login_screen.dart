import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/core/values/responsive_app.dart';
import 'package:customer_app/app/global/controller/auth_controller.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/rounded_text_field.dart';
import 'package:customer_app/app/screens/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  List<TextEditingController> _otpControllers = [];
  List<FocusNode> _otpFocusNodes = [];

  final AuthController authCont = Get.find<AuthController>();
  String selectedUserType = "customer";
  bool otpSent = false;

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(6, (_) => TextEditingController());
    _otpFocusNodes = List.generate(6, (_) => FocusNode());

    // Add listener to phone controller for auto-send OTP
    _phoneController.addListener(_onPhoneChanged);

    // Add listener to last OTP field for auto-verify
    _otpControllers[5].addListener(_onLastOtpChanged);
  }

  void _onPhoneChanged() {
    if (_phoneController.text.length == 10 && !otpSent) {
      // Auto send OTP when phone number reaches 10 digits
      authCont.checkAndSendOtp(_phoneController.text.trim());
      setState(() {
        otpSent = true;
      });

      // Move focus to first OTP field
      if (_otpFocusNodes[0].canRequestFocus) {
        _otpFocusNodes[0].requestFocus();
      }
    }
  }

  void _onLastOtpChanged() {
    if (_otpControllers[5].text.isNotEmpty) {
      // Auto verify when last digit (6th) is entered
      _verifyOtp();
    }
  }

  void _verifyOtp() {
    String otp = _getOtpFromControllers();
    if (otp.length == 6) {
      authCont.verifyLoginOtp(otp);
    }
  }

  String _getOtpFromControllers() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  @override
  void dispose() {
    _phoneController.removeListener(_onPhoneChanged);
    _phoneController.dispose();
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _otpFocusNodes) {
      f.dispose();
    }
    _otpControllers[5].removeListener(_onLastOtpChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveAppValue(context);
    return Scaffold(
      body: Stack(
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
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Image.asset(Appimages.authImage, height: 150.h, width: width),
                  SizedBox(height: 14.h),
                  CustomText(
                    label: "Login as",
                    size: 24.sp,
                    color: kDark,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 14.h),

                  // Customer / Service Provider toggle buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularButton(
                        buttonColor: selectedUserType == "customer"
                            ? kPrimary
                            : kSecondary,
                        buttonText: "Customer",
                        onPressed: () {
                          setState(() {
                            selectedUserType = "customer";
                          });
                        },
                        textSize: 14.sp,
                        height: responsive.screenHeight * 0.05,
                      ),
                      SizedBox(width: 12.w),
                      CircularButton(
                        buttonColor: selectedUserType == "provider"
                            ? kPrimary
                            : kSecondary,
                        buttonText: "Service Provider",
                        onPressed: () {
                          setState(() {
                            selectedUserType = "provider";
                          });
                        },
                        textSize: 14.sp,
                        height: responsive.screenHeight * 0.05,
                      ),
                    ],
                  ),

                  SizedBox(height: 15.h),

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
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // OTP Section
                  Container(
                    height: 40.h,
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
                          children: List.generate(6, (index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: index != 5 ? 4.w : 0,
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
                                  style: appStyle(
                                    14.sp,
                                    k232323,
                                    FontWeight.w500,
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
                                    if (value.isNotEmpty && index < 5) {
                                      // Changed to 5 for 6 digits
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

                  SizedBox(height: 16.h),

                  // Status message and Resend OTP
                  GetBuilder<AuthController>(
                    builder: (controller) {
                      return Column(
                        children: [
                          if (controller.isSendingOtp)
                            Text(
                              "Sending OTP...",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: kPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          else if (otpSent && !controller.isSendingOtp)
                            Text(
                              "OTP sent to +91${_phoneController.text}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: kGreenAccent,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                          SizedBox(height: 8.h),

                          // Resend OTP option
                          if (otpSent)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Didn't receive OTP? ",
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_phoneController.text.length == 10) {
                                      authCont.loginWithPhone(
                                        phone: _phoneController.text.trim(),
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Resend OTP",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: kPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      );
                    },
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
                          style: appStyle(14.sp, k232323, FontWeight.w500),
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
                        child: Icon(Icons.apple, size: 26.sp, color: k232323),
                      ),
                    ],
                  ),

                  SizedBox(height: 80.h),

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
