import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/models/provider_model.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/screens/userSide/chooseProviderList/widgets/provider_card.dart';
import 'package:customer_app/app/screens/userSide/products/widgets/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChooseProviderLists extends StatefulWidget {
  const ChooseProviderLists({super.key});

  @override
  State<ChooseProviderLists> createState() => _ChooseProviderListsState();
}

class _ChooseProviderListsState extends State<ChooseProviderLists> {
  final List<ProviderModel> providers = [
    ProviderModel(
      name: "Shivam Kumar",
      role: "AC Technician",
      rating: 4.5,
      price: 519,
      oldPrice: 600,
      imageUrl: Appimages.providerIcon,
    ),
    ProviderModel(
      name: "Rahul Sharma",
      role: "AC Technician",
      rating: 4.5,
      price: 519,
      oldPrice: 600,
      imageUrl: Appimages.providerIcon,
    ),
    ProviderModel(
      name: "Amit Singh",
      role: "AC Technician",
      rating: 4.5,
      price: 519,
      oldPrice: 600,
      imageUrl: Appimages.providerIcon,
    ),
    ProviderModel(
      name: "Vivek Yadav",
      role: "AC Technician",
      rating: 4.5,
      price: 519,
      oldPrice: 600,
      imageUrl: Appimages.providerIcon,
    ),

    ProviderModel(
      name: "Anup Singh",
      role: "AC Technician",
      rating: 4.5,
      price: 519,
      oldPrice: 600,
      imageUrl: Appimages.providerIcon,
    ),
    ProviderModel(
      name: "Arpit Pandya",
      role: "AC Technician",
      rating: 4.5,
      price: 519,
      oldPrice: 600,
      imageUrl: Appimages.providerIcon,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a Provider"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: GridView.builder(
          itemCount: providers.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 230,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return ProviderCard(provider: providers[index]);
          },
        ),
      ),
      bottomNavigationBar: CircularButton(
        buttonColor: kPrimary,
        buttonText: "Continue",
        onPressed: () => Get.to(() => ProductDetailsScreen()),
      ),
      // backgroundColor: const Color(0xfff5f5f5),
    );
  }
}
