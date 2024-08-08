import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia/viewmodels/second_screen_viewmodel.dart';
import '../viewmodels/third_screen_viewmodel.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ThirdScreenViewModel>(context);

    // Fetch users only if the list is empty and not loading
    if (!viewModel.isLoading && viewModel.users.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel.fetchUsers();
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Third Screen')),
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh the list by re-fetching users
          await viewModel.fetchUsers();
        },
        child: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: viewModel.users.length,
                itemBuilder: (context, index) {
                  final user = viewModel.users[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatar),
                        ),
                        title: Text(
                          '${user.firstName} ${user.lastName}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        subtitle: Text(user.email),
                        onTap: () {
                          final secondScreenViewModel =
                              Provider.of<SecondScreenViewModel>(context,
                                  listen: false);
                          secondScreenViewModel.setSelectedUserName(
                              '${user.firstName} ${user.lastName}');
                          Navigator.pop(context);
                        },
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 0.4,
                      )
                    ],
                  );
                },
              ),
      ),
    );
  }
}
