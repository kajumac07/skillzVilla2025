import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/list_tile_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        title: Text(
          'Settings',
          style: appStyle(18.sp, k232323, FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          buildSettingsMenus(Appimages.language, "Language", () {}),
          buildSettingsMenus(Appimages.notiIcon, "Notificatons", () {}),
          buildSettingsMenus(Appimages.privacy, "Privacy Details", () {}),
        ],
      ),
    );
  }

  Widget buildSettingsMenus(
    String imageName,
    String title,
    void Function()? onTap,
  ) {
    return Container(
      width: width,
      margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 8.w),
      // padding: EdgeInsets.all(4.h),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: ListTileOptions(
        imageName: imageName,
        title: title,
        onTap: onTap,
        // color: k232323,
      ),
    );
  }
}
