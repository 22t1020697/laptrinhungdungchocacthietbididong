class BmiResult {
  final double bmi;
  final String status;
  final String advice;

  BmiResult({
    required this.bmi,
    required this.status,
    required this.advice,
  });
}

class BmiCalculator {
  static BmiResult calculate(double weight, double heightCm) {
    final heightM = heightCm / 100;
    final bmi = weight / (heightM * heightM);

    if (bmi < 18.5) {
      return BmiResult(
        bmi: bmi,
        status: 'Thiếu cân',
        advice:
            'Bạn nên ăn đầy đủ dưỡng chất, tăng bữa ăn và kết hợp tập luyện nhẹ.',
      );
    } else if (bmi < 25) {
      return BmiResult(
        bmi: bmi,
        status: 'Bình thường',
        advice:
            'Cơ thể bạn đang rất tốt 👍 Hãy duy trì ăn uống lành mạnh và uống đủ nước.',
      );
    } else if (bmi < 30) {
      return BmiResult(
        bmi: bmi,
        status: 'Thừa cân',
        advice:
            'Bạn nên giảm tinh bột, uống nhiều nước và tăng vận động hàng ngày.',
      );
    } else {
      return BmiResult(
        bmi: bmi,
        status: 'Béo phì',
        advice:
            'Nên điều chỉnh chế độ ăn, tăng vận động và theo dõi sức khỏe định kỳ.',
      );
    }
  }
}
