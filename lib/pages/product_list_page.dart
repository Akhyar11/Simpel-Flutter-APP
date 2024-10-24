// lib/pages/product_list_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Daftar Produk'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => productController.refreshProducts(),
          ),
        ],
      ),
      body: Obx(
        () {
          if (productController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (productController.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${productController.error.value}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => productController.fetchProducts(),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (productController.products.isEmpty) {
            return const Center(child: Text('Tidak ada produk'));
          }

          return RefreshIndicator(
            onRefresh: productController.refreshProducts,
            child: ListView.builder(
              itemCount: productController.products.length,
              itemBuilder: (context, index) {
                final product = productController.products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(
                            int.parse('0xFF${product.color.substring(1)}')),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    title: Text(product.name),
                    subtitle: Text('Year: ${product.year}'),
                    trailing: Text(product.pantoneValue),
                    onTap: () {
                      // TODO: Navigate to product detail
                      Get.snackbar(
                        'Product Selected',
                        'You tapped on ${product.name}',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
