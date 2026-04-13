import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("معاذ القرني"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        children: const [
          ProductBox(
            name: "سامسونج S24 Ultra",
            brand: "Samsung",
            price: "4500",
            description: "أقوى جوال أندرويد مع قلم ذكي وكاميرا خرافية",
            image: "image/samsung.jpg",
          ),
          ProductBox(
            name: "ايفون 17 Pro",
            brand: "Apple",
            price: "5500",
            description: "تصميم تيتانيوم مع أحدث معالج من ابل",
            image: "image/apple.jpg",
          ),
          ProductBox(
            name: "شاشة سامسونج",
            brand: "Samsung",
            price: "1800",
            description: "شاشة 4K ذكية تدعم الألعاب والنتفلكس",
            image: "image/samsungtv.jpg",
          ),
          ProductBox(
            name: "ماك بوك برو",
            brand: "Apple",
            price: "8500",
            description: "لابتوب جبار للمصممين والمبرمجين مع معالج M3",
            image: "image/macbook.jpg",
          ),
          ProductBox(
            name: "لابتوب هواوي",
            brand: "Huawei",
            price: "3200",
            description: "أناقة وخفة وزن مع أداء ممتاز للمكتب",
            image: "image/laptop.jpg",
          ),
        ],
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  final String name;
  final String image;
  final String brand;
  final String price;
  final String description;

  const ProductBox({
    super.key,
    required this.name,
    required this.image,
    required this.brand,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ExpansionTile(
        // هنا كبرنا المسافات والخط
        tilePadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        leading: Container(
          width: 80, // كبرنا عرض مكان الصورة
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(image, fit: BoxFit.contain), // BoxFit.contain يحافظ على شكل المنتج
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22), // خط كبير للعنوان
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // عرض الصورة بشكل أكبر عند الفتح (اختياري)
                Center(
                  child: Image.asset(image, height: 150),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("الماركة: $brand", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18)),
                    Text("$price ريال", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20)),
                  ],
                ),
                const Divider(height: 30),
                const Text("الوصف:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 8),
                Text(description, style: const TextStyle(color: Colors.black87, fontSize: 16, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
