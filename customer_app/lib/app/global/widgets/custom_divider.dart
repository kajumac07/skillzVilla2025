import 'package:customer_app/app/core/constants/consts.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.color = kE9E9E9});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Divider(color: color);
  }
}
