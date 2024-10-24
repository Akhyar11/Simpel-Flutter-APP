import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class UserListPage extends StatelessWidget {
  UserListPage({super.key});

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('User List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => userController.refreshUsers(),
          ),
        ],
      ),
      body: Obx(
        () {
          if (userController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userController.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${userController.error.value}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => userController.fetchUsers(),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (userController.users.isEmpty) {
            return const Center(child: Text('Tidak ada user'));
          }

          return RefreshIndicator(
            onRefresh: userController.refreshUsers,
            child: ListView.builder(
              itemCount: userController.users.length,
              itemBuilder: (context, index) {
                final user = userController.users[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                    onTap: () {
                      Get.snackbar(
                        'User Selected',
                        'You tapped on ${user.firstName} ${user.lastName}',
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
