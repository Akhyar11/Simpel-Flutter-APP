// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/product_list_page.dart';
import 'pages/user_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Changed from MaterialApp to GetMaterialApp
      title: 'Beranda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Beranda'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              key: const Key('productButton'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              onPressed: () => Get.to(() => ProductListPage()),
              child: const Text('Daftar Produk'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key('userButton'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              onPressed: () => Get.to(() => UserListPage()),
              child: const Text('Daftar Pengguna'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key('cartButton'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              onPressed: () {
                // TODO: Navigate to cart
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const CartPage()),
                // );
              },
              child: const Text('Keranjang'),
            ),
          ],
        ),
      ),
    );
  }
}
