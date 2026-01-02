import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: BookingPage()));
}

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF003580),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF003580),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 16),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: const Color(0xFFFFB700), width: 2),
              ),
              child: Row(
                children: const [
                  SizedBox(width: 4),
                  Icon(Icons.chevron_left, color: Colors.black, size: 28),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "Xung quanh vị trí hiện tại   23 thg 10 - 24 thg 10",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: const [
                Expanded(
                  child: _FilterButton(
                    icon: Icons.swap_vert,
                    text: "Sắp xếp",
                    iconColor: Color(0xFFC00000),
                  ),
                ),
                Expanded(
                  child: _FilterButton(icon: Icons.tune, text: "Lọc"),
                ),
                Expanded(
                  child: _FilterButton(
                    icon: Icons.map_outlined,
                    text: "Bản đồ",
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: const [
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    "757 chỗ nghỉ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                _HotelCard(
                  imageUrl:
                      "https://images.unsplash.com/photo-1582719508461-905c673771fd?auto=format&fit=crop&q=80&w=300&h=400",
                  name: "aNhill Boutique",
                  stars: 5,
                  score: "9,5",
                  ratingText: "Xuất sắc",
                  reviewCount: "95",
                  location: "Huế • Cách bạn 0,6km",
                  roomType: "1 suite riêng tư: 1 giường",
                  price: "US\$109",
                  hasBreakfast: true,
                ),
                _HotelCard(
                  imageUrl:
                      "https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&q=80&w=300&h=400",
                  name: "An Nam Hue Boutique",
                  score: "9,2",
                  ratingText: "Tuyệt hảo",
                  reviewCount: "34",
                  location: "Cư Chánh • Cách bạn 0,9km",
                  roomType: "1 phòng khách sạn: 1 giường",
                  price: "US\$20",
                  hasBreakfast: true,
                ),
                _HotelCard(
                  imageUrl:
                      "https://images.unsplash.com/photo-1613977257363-707ba9348227?auto=format&fit=crop&q=80&w=300&h=400",
                  name: "Huế Jade Hill Villa",
                  score: "8,0",
                  ratingText: "Rất tốt",
                  reviewCount: "1",
                  location: "Cư Chánh • Cách bạn 1,3km",
                  roomType: "1 biệt thự nguyên căn - 1.000 m²",
                  roomDetail:
                      "4 giường • 3 phòng ngủ • 1 phòng khách • 3 phòng tắm",
                  price: "US\$285",
                  scarcityText: "Chỉ còn 1 căn với giá này trên Booking.com",
                  perkText: "Không cần thanh toán trước",
                  hostManaged: true,
                ),
                _HotelCard(
                  imageUrl:
                      "https://images.unsplash.com/photo-1613490493576-7fde63acd811?auto=format&fit=crop&q=80&w=300&h=400",
                  name: "Êm Villa",
                  score: "7,5",
                  ratingText: "Tốt",
                  reviewCount: "15",
                  location: "Vỹ Dạ • Cách bạn 2,0km",
                  roomType: "1 biệt thự riêng",
                  price: "US\$180",
                  hasBreakfast: true,
                  hostManaged: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const _FilterButton({
    required this.icon,
    required this.text,
    this.iconColor = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}

class _HotelCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int? stars;
  final String score;
  final String ratingText;
  final String reviewCount;
  final String location;
  final String roomType;
  final String? roomDetail;
  final String price;
  final bool hasBreakfast;
  final bool hostManaged;
  final String? scarcityText;
  final String? perkText;

  const _HotelCard({
    required this.imageUrl,
    required this.name,
    this.stars,
    required this.score,
    required this.ratingText,
    required this.reviewCount,
    required this.location,
    required this.roomType,
    this.roomDetail,
    required this.price,
    this.hasBreakfast = false,
    this.hostManaged = false,
    this.scarcityText,
    this.perkText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                height: 200,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(imageUrl, fit: BoxFit.cover),
                      ),
                    ),
                    if (hasBreakfast)
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF008009),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Bao bữa sáng",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003580),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.favorite_border, size: 20),
                        ],
                      ),
                      if (stars != null)
                        Row(
                          children: List.generate(
                            stars!,
                            (index) => const Icon(
                              Icons.star,
                              size: 12,
                              color: Color(0xFFFEBB02),
                            ),
                          ),
                        ),
                      if (hostManaged)
                        const Text(
                          "Được quản lý bởi một host cá nhân",
                          style: TextStyle(fontSize: 10),
                        ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF003580),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              score,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ratingText,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "$reviewCount đánh giá",
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 14),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              location,
                              style: const TextStyle(fontSize: 11),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          roomType,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (roomDetail != null)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            roomDetail!,
                            textAlign: TextAlign.right,
                            style: const TextStyle(fontSize: 11),
                          ),
                        ),
                      if (scarcityText != null)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            scarcityText!,
                            style: const TextStyle(
                              color: Color(0xFFCC0000),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (perkText != null)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check,
                                size: 12,
                                color: Color(0xFF008009),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                perkText!,
                                style: const TextStyle(
                                  color: Color(0xFF008009),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              price,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Đã bao gồm thuế và phí",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
