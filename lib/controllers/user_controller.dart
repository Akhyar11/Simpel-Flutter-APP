import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class UserController extends GetxController {
  var users = <User>[].obs;
  var isLoading = true.obs;
  var error = ''.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading(true);
      error(''); // Reset error message
      
      final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=2'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> usersData = data['data'];
        users.value = usersData
            .map((userJson) => User.fromJson(userJson))
            .toList();
      } else {
        error.value = 'Failed to load users. Status code: ${response.statusCode}';
      }
    } catch (e) {
      error.value = 'Error fetching users: ${e.toString()}';
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshUsers() async {
    users.clear();
    await fetchUsers();
  }
}