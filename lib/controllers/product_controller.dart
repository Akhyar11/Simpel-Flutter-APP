// lib/controllers/product_controller.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;
  var error = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('https://reqres.in/api/products'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> productsData = data['data'];
        products.value = productsData
            .map((productJson) => Product.fromJson(productJson))
            .toList();
      } else {
        error.value = 'Failed to load products';
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshProducts() async {
    products.clear();
    await fetchProducts();
  }
}
