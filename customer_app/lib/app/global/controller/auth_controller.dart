import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/toasts_msg.dart';
import 'package:customer_app/app/global/models/bank_details_model.dart';
import 'package:customer_app/app/global/models/plan_details_model.dart';
import 'package:customer_app/app/global/models/plan_model.dart';
import 'package:customer_app/app/global/services/db_service.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/screens/providerSide/kyc/kyc_screen.dart';
import 'package:customer_app/app/screens/providerSide/kyc/widgets/kyc_docs_screen.dart';
import 'package:customer_app/root_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global/models/user_model.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isLoading = false;
  bool isOtpLoading = false;

  String verificationId = "";
  String tempName = "";
  String tempEmail = "";
  String tempPassword = "";
  String tempPhone = "";
  String tempUserType = "customer";
  bool isGoogleFlow = false;

  //===================================== Registration Functions =====================================

  // -----------------------------
  // STEP 1 — REGISTER WITH PHONE
  // -----------------------------
  Future<void> registerWithPhone({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String userType,
  }) async {
    try {
      isLoading = true;
      update();

      tempName = name;
      tempEmail = email;
      tempPassword = password;
      tempPhone = phone;
      tempUserType = userType;
      isGoogleFlow = false;

      await sendOtp(phone);
    } catch (e) {
      showToastMessage("Error", "Failed to send OTP", kRed);
    } finally {
      isLoading = false;
      update();
    }
  }

  // -----------------------------
  // SEND OTP
  // -----------------------------
  Future<void> sendOtp(String phone) async {
    try {
      tempPhone = phone;
      update();

      await auth.verifyPhoneNumber(
        phoneNumber: "+91$phone",
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          showToastMessage("Error", e.message!, kRed);
        },
        codeSent: (String verId, int? resendToken) {
          verificationId = verId;
          Get.bottomSheet(
            otpSheet(),
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
          );
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
      );
    } catch (e) {
      showToastMessage("Error", "Failed to send OTP", kRed);
    }
  }

  // -----------------------------
  // VERIFY OTP
  // -----------------------------
  Future<void> verifyOtp(String otp) async {
    if (otp.length != 6) {
      showToastMessage("Error", "Please enter a valid 6-digit OTP", kRed);
      return;
    }

    try {
      isOtpLoading = true;
      update();

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      UserCredential userCredential;

      if (isGoogleFlow) {
        userCredential = await auth.currentUser!.linkWithCredential(credential);
      } else {
        userCredential = await auth.signInWithCredential(credential);
      }

      // Save user data to Firestore
      await DatabaseServices(uid: userCredential.user!.uid).saveUserData(
        UserModel(
          uid: userCredential.user!.uid,
          name: tempName.isEmpty ? "SkilzVilla User" : tempName,
          phNumber: tempPhone,
          email: tempEmail,
          userType: tempUserType,
          kycType: tempUserType == "customer" ? "customer" : "company",
          imageUrl:
              "https://firebasestorage.googleapis.com/v0/b/skilvilla.appspot.com/o/profileN.png?alt=media&token=75de6f1c-851d-4d1d-8e8f-a225813ba703",
          whatsApp: "",
          dob: "",
          additionalInfo: [],
          isDocSubmitted: false,
          isPhoneVerify: true,
          isGoogleAccountVerify: isGoogleFlow,
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now(),
          bankDetails: BankDetailsModel(
            accountNumber: "",
            confirmAccountNumber: "",
            ifscCode: "",
            phone: "",
            upiId: "",
            branch: "",
            documentUrl: "",
          ),
          planDetails: PlanDetailsModel(
            durationInMonths: 0,
            expiryDate: Timestamp.now(),
            features: [],
            isActive: false,
            originalPrice: "",
            paymentDocumentId: "",
            planTitle: "",
            planType: "",
            price: "",
            subscriptionDate: Timestamp.now(),
          ),
          isPlanPurchased: false,
          currentPlan: "",
          lastPaymentId: "",
          jobsCompleted: 0,
          totalEarning: 0,
          paymentHistory: [],
        ),
      );

      Get.back(); // close OTP sheet
      showToastMessage("Success", "Account created successfully", kGreenAccent);

      if (tempUserType == "customer") {
        Get.offAll(() => RootScreen());
      } else {
        Get.offAll(() => KycScreen());
      }
    } on FirebaseAuthException catch (e) {
      showToastMessage("Error", e.message ?? "Invalid OTP", kRed);
    } catch (e) {
      showToastMessage("Error", "Something went wrong", kRed);
    } finally {
      isOtpLoading = false;
      update();
    }
  }

  // -----------------------------
  // ENHANCED OTP Sheet UI
  // -----------------------------
  Widget otpSheet() {
    TextEditingController otpCtrl = TextEditingController();
    final FocusNode otpFocusNode = FocusNode();

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Center(
            child: Container(
              width: 60.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          Text(
            "Verify Phone Number",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: kDark,
            ),
          ),
          SizedBox(height: 8.h),

          Text(
            "We've sent a 6-digit OTP to +91$tempPhone",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
          SizedBox(height: 24.h),

          // OTP Input Field
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: TextField(
              controller: otpCtrl,
              focusNode: otpFocusNode,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 6,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 8.w,
              ),
              decoration: InputDecoration(
                counterText: "",
                border: InputBorder.none,
                hintText: "• • • • • •",
                hintStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8.w,
                  color: Colors.grey[400],
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 16.h,
                ),
              ),
              onChanged: (value) {
                if (value.length == 6) {
                  // Auto-submit when 6 digits are entered
                  verifyOtp(value);
                }
              },
            ),
          ),
          SizedBox(height: 8.h),

          // Resend OTP option
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't receive OTP? ",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              ),
              GestureDetector(
                onTap: () => sendOtp(tempPhone),
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
          SizedBox(height: 24.h),

          // Verify Button
          GetBuilder<AuthController>(
            builder: (controller) {
              return CircularButton(
                buttonColor: kPrimary,
                buttonText: controller.isOtpLoading
                    ? "Verifying..."
                    : "Verify OTP",
                onPressed: controller.isOtpLoading
                    ? null
                    : () => verifyOtp(otpCtrl.text.trim()),
                width: double.infinity,
                height: 50.h,
                textSize: 16.sp,
              );
            },
          ),

          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  // Method to update user type
  void setUserType(String type) {
    tempUserType = type;
    update();
  }

  //===================================== Login Functions =====================================

  bool isLoginLoading = false;
  bool isSendingOtp = false;

  // -----------------------------
  // LOGIN WITH PHONE
  // -----------------------------
  Future<void> loginWithPhone({required String phone}) async {
    try {
      isSendingOtp = true;
      update();

      tempPhone = phone;
      await sendLoginOtp(phone);
    } catch (e) {
      showToastMessage("Error", "Failed to send OTP", kRed);
    } finally {
      isSendingOtp = false;
      update();
    }
  }

  // -----------------------------
  // SEND LOGIN OTP
  // -----------------------------
  Future<void> sendLoginOtp(String phone) async {
    try {
      tempPhone = phone;

      await auth.verifyPhoneNumber(
        phoneNumber: "+91$phone",
        verificationCompleted: (PhoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException e) {
          showToastMessage("Error", e.message!, kRed);
        },
        codeSent: (String verId, int? resendToken) {
          verificationId = verId;
          showToastMessage("Success", "OTP sent successfully", kGreenAccent);
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
      );
    } catch (e) {
      showToastMessage("Error", "Failed to send OTP", kRed);
    }
  }

  // -----------------------------
  // VERIFY LOGIN OTP
  // -----------------------------
  Future<void> verifyLoginOtp(String otp) async {
    if (otp.length != 6) {
      showToastMessage("Error", "Please enter 6-digit OTP", kRed);
      return;
    }

    try {
      isLoginLoading = true;
      update();

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      UserCredential userCredential = await auth.signInWithCredential(
        credential,
      );

      // Check if user exists in Firestore
      final docRef = firestore
          .collection('users')
          .doc(userCredential.user!.uid);
      final userDoc = await docRef.get();

      if (!userDoc.exists) {
        await auth.signOut();
        showToastMessage(
          "Error",
          "User not found. Please register first.",
          kRed,
        );
        return;
      }

      // Defensive: ensure data is a map
      final data = userDoc.data();
      if (data == null) {
        // Unexpected shape
        await auth.signOut();
        showToastMessage("Error", "Invalid user data. Contact support.", kRed);
        return;
      }

      // Use your UserModel to parse (handles typos/timestamps/types)
      final userData = UserModel.fromMap(Map<String, dynamic>.from(data));

      // Debug - remove or replace with logger in production
      print(
        "DEBUG: userType=${userData.userType}, kycType=${userData.kycType}, isDocSubmitted=${userData.isDocSubmitted}",
      );

      showToastMessage("Success", "Login successful", kGreenAccent);

      // Navigate based on normalized model fields
      if (userData.userType == 'customer') {
        Get.offAll(() => RootScreen());
        return;
      }

      if (userData.userType == 'provider') {
        final kyc = userData.kycType.toLowerCase();
        if (kyc == 'company' || kyc == 'freelance') {
          if (userData.isDocSubmitted == true) {
            Get.offAll(() => RootScreen());
          } else {
            Get.offAll(() => KycDocsScreen());
          }
        } else {
          // fallback KYC screen for other provider types
          Get.offAll(() => KycScreen());
        }
        return;
      }

      // Fallback
      Get.offAll(() => RootScreen());
    } on FirebaseAuthException catch (e) {
      showToastMessage("Error", e.message ?? "Invalid OTP", kRed);
    } catch (e, st) {
      print("verifyLoginOtp error: $e\n$st");
      showToastMessage("Error", "Something went wrong", kRed);
    } finally {
      isLoginLoading = false;
      update();
    }
  }

  // -----------------------------
  // GET OTP FROM CONTROLLERS
  // -----------------------------
  String getOtpFromControllers(List<TextEditingController> controllers) {
    return controllers.map((controller) => controller.text).join();
  }

  // -----------------------------
  // AUTO SEND OTP WHEN PHONE IS COMPLETE
  // -----------------------------
  void checkAndSendOtp(String phone) {
    if (phone.length == 10) {
      loginWithPhone(phone: phone);
    }
  }
}
