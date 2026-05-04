import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_model.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductScreen(),
    ));

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // دالة جلب البيانات من السيرفر المحلي
  Future<List<Product>> getData() async {
    // استخدم localhost لأنك تشغل التطبيق على المتصفح
    var url = Uri.parse('http://localhost/task_api/get_products.php');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('خطأ في الاتصال بالسيرفر');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // خلفية رمادية فاتحة مثل الصورة
      appBar: AppBar(
        title: Text("معاذ القرني", style: TextStyle(color: Colors.black54)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 19, 19, 19), // لون الـ AppBar في تصميمك
        elevation: 0,
      ),
      body: FutureBuilder<List<Product>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                var product = snapshot.data![i];
                return Card(
                  margin: EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ExpansionTile(
                    leading: Image.network(
                      product.image, // رابط الصورة من قاعدة البيانات
                      width: 60,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.image),
                    ),
                    title: Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // عرض صورة كبيرة للمنتج عند التوسيع
                            Center(
                              child: Image.network(
                                product.image,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("الماركة: ${product.brand}", 
                                     style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                                Text("ريال ${product.price}", 
                                     style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18)),
                              ],
                            ),
                            Divider(),
                            Text("الوصف:", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(product.description, style: TextStyle(color: Colors.grey[700])),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return  Center(child:Text("Erorr") );
          
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
