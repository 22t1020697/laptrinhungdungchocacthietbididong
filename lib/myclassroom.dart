import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: MyClassroom()));
}

class MyClassroom extends StatelessWidget {
  const MyClassroom({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 238, 238),
      appBar: AppBar(
        title: const Text(
          "Google Classroom",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black54),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
          const CircleAvatar(
            backgroundColor: Color.fromARGB(255, 230, 115, 198),
            radius: 16,
            child: Text("N", style: TextStyle(fontSize: 14)),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          _ClassCard(
            title: "XML và ứng dụng - Nhóm 1",
            code: "2025-2026.1.TIN4583.001",
            students: "58 học viên",
            bgImage:
                "https://images.unsplash.com/photo-1740638733796-99124a3b0a4b?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          ),
          _ClassCard(
            title: "Lập trình ứng dụng cho các thiết bị di động - Nhóm 3",
            code: "2025-2026.1.TIN4403.006",
            students: "55 học viên",
            bgImage:
                "https://media.istockphoto.com/id/2235460342/vi/anh/h%C3%ACnh-n%E1%BB%81n-h%C3%ACnh-c%E1%BA%A7u-tr%E1%BB%ABu-t%C6%B0%E1%BB%A3ng-h%C3%ACnh-n%E1%BB%81n-%C4%91i%E1%BB%87n-tho%E1%BA%A1i-di-%C4%91%E1%BB%99ng-h%C3%ACnh-n%E1%BB%81n-m%C3%A1y-t%C3%ADnh-k%E1%BA%BFt-xu%E1%BA%A5t-3d.jpg?s=1024x1024&w=is&k=20&c=iEqVI55y-3BcDM1wNzC_k8bSREjiRuENgGv9U9g_L_A=",
          ),
          _ClassCard(
            title: "Lập trình ứng dụng cho các thiết bị di động - Nhóm 3",
            code: "2025-2026.1.TIN4403.005",
            students: "52 học viên",
            bgImage:
                "https://media.istockphoto.com/id/1399876669/vector/flat-abstrack-background-vector-illustration-for-desktop-premium-vector-vintage-wallpaper.webp?a=1&s=612x612&w=0&k=20&c=bEzB47i6qQUH6vpgDviDcg_hEN9mNVadIPewWyKatp0=",
          ),
          _ClassCard(
            title: "Lập trình ứng dụng cho các thiết bị di động - Nhóm 3",
            code: "2025-2026.1.TIN4403.004",
            students: "50 học viên",
            bgImage:
                "https://media.istockphoto.com/id/530577174/photo/background-from-colour-circles.webp?a=1&s=612x612&w=0&k=20&c=D5KpEPZVHCaKpkOavGAj7dO8Xdp_FdGD1osS-4G3s8w=",
          ),
          _ClassCard(
            title: "Lập trình ứng dụng cho các thiết bị di động - Nhóm 3",
            code: "2025-2026.1.TIN4403.003",
            students: "52 học viên",
            bgImage:
                "https://media.istockphoto.com/id/1137081158/vector/abstract-background-with-colored-spheres.webp?a=1&s=612x612&w=0&k=20&c=EWwBfjE_2iNCIIdCIMmE9qy59T3nqo7dhZ8i-VlSQ8E=",
          ),
        ],
      ),
    );
  }
}

class _ClassCard extends StatelessWidget {
  final String title;
  final String code;
  final String students;
  final String bgImage;

  const _ClassCard({
    required this.title,
    required this.code,
    required this.students,
    required this.bgImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(bgImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                          size: 28,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      code,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Text(
                    students,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 83, 19, 19),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
