import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTileOptions extends StatelessWidget {
  const ListTileOptions({
    super.key,
    required this.imageName,
    required this.title,
    required this.onTap,
    this.color = kSecondary,
  });
  final String imageName;
  final String title;
  final void Function()? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.asset(imageName, height: 24.h, width: 24.w, color: color),
      title: CustomText(
        label: title,
        size: 16.sp,
        color: kGrey300,
        fontWeight: FontWeight.w500,
      ),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
