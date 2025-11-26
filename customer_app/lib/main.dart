import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/global/controller/auth_controller.dart';
import 'package:customer_app/app/global/controller/kyc_controller.dart';
import 'package:customer_app/app/global/controller/profile_controller.dart';
import 'package:customer_app/app/screens/splash/splash_screen.dart';
import 'package:customer_app/root_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Initialize
  Get.put(AuthController());
  Get.put(KycController());
  Get.put(ProfileController());
  runApp(DevicePreview(enabled: false, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 825),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: (context, widget) {
            // 🧱 LOCK text scale and system font override here
            final mediaQuery = MediaQuery.of(
              context,
            ).copyWith(textScaleFactor: 1.0);
            return MediaQuery(data: mediaQuery, child: widget!);
          },
          debugShowCheckedModeBanner: false,
          title: 'Customer App',
          theme: ThemeData(
            fontFamily: 'ProductSans',
            useMaterial3: true,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontFamily: 'ProductSans'),
              bodyMedium: TextStyle(fontFamily: 'ProductSans'),
              bodySmall: TextStyle(fontFamily: 'ProductSans'),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          // home: const SplashScreen(),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: kWhite,
                  child: Center(
                    child: CircularProgressIndicator(backgroundColor: kPrimary),
                  ),
                );
              }
              if (snapshot.hasData) {
                return const RootScreen();
              }
              return const SplashScreen();
            },
          ),
        );
      },
    );
  }
}
