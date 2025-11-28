import 'package:cloud_firestore/cloud_firestore.dart';

String calculateRemainingDays(
  Timestamp subscriptionDate,
  Timestamp expiryDate,
) {
  try {
    DateTime now = DateTime.now();
    DateTime expiry = expiryDate.toDate();

    // Calculate difference in days
    int remainingDays = expiry.difference(now).inDays;

    if (remainingDays > 0) {
      return '$remainingDays';
    } else if (remainingDays == 0) {
      return 'Expires today';
    } else {
      return 'Expired ${remainingDays.abs()} days ago';
    }
  } catch (e) {
    return 'Date error';
  }
}
