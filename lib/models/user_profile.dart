enum ActivityLevel { low, medium, high }

class UserProfile {
  final double weight;
  final double height;
  final String gender;
  final ActivityLevel activityLevel;

  UserProfile({
    required this.weight,
    required this.height,
    required this.gender,
    required this.activityLevel,
  });

  /// TÍNH LƯỢNG NƯỚC (LÍT)
  double get dailyWaterLiters {
    double base = weight * 0.033;

    switch (activityLevel) {
      case ActivityLevel.low:
        return base;
      case ActivityLevel.medium:
        return base + 0.3;
      case ActivityLevel.high:
        return base + 0.6;
    }
  }

}
