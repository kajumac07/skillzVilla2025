// Sample product data
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/models/need_today.dart';
import 'package:customer_app/app/global/models/product_model.dart';
import 'package:customer_app/app/screens/userSide/home/home_screen.dart';

final List<Product> products = [
  Product(
    name: "Intense Bathroom Cleaning",
    price: "\₹455",
    rating: "4.5",
    imageUrl: Appimages.bathroomCleaning,
  ),
  Product(
    name: "Home Interior Walls Painting",
    price: "\₹555",
    rating: "4.8",
    imageUrl: Appimages.homeInterior,
  ),
  Product(
    name: "Swedish Stress Body Massage",
    price: "\₹699",
    rating: "4.3",
    imageUrl: Appimages.bodyMassage,
  ),
];

// Sample need today data
final List<NeedToday> needToday = [
  NeedToday(name: "Water Purifier", imageUrl: Appimages.waterPurifier),
  NeedToday(name: "Laptop Service", imageUrl: Appimages.laptopService),
  NeedToday(name: "Gardening", imageUrl: Appimages.garden),
  NeedToday(name: "Deep Cleaning", imageUrl: Appimages.deepClean),
];
