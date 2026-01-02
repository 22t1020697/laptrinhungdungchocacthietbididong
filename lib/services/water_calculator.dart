import '../models/user_profile.dart';

class WaterCalculator {
  static double calculateDailyWater(
      double weight, ActivityLevel activityLevel) {
    double baseWater = weight * 0.033;

    switch (activityLevel) {
      case ActivityLevel.low:
        return baseWater;
      case ActivityLevel.medium:
        return baseWater + 0.3;
      case ActivityLevel.high:
        return baseWater + 0.6;
    }
  }
}
