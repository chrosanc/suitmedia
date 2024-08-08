import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia/viewmodels/second_screen_viewmodel.dart';
import '../viewmodels/third_screen_viewmodel.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch users when the screen is initialized
    Provider.of<ThirdScreenViewModel>(context, listen: false).fetchUsers();

    // Add scroll listener to load more data when scrolled to bottom
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Provider.of<ThirdScreenViewModel>(context, listen: false)
            .fetchMoreUsers();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ThirdScreenViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Third Screen')),
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh the list by re-fetching users
          await Provider.of<ThirdScreenViewModel>(context, listen: false)
              .fetchUsers();
        },
        child: viewModel.isLoading && viewModel.users.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : viewModel.users.isEmpty
                ? const Center(child: Text("No users found."))
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: viewModel.users.length + 
                      (viewModel.hasMoreData ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < viewModel.users.length) {
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
                            ),
                          ],
                        );
                      } else {
                        // Show loading indicator at the bottom when fetching more data
                        return viewModel.isLoadingMore
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(child: CircularProgressIndicator()),
                              )
                            : const SizedBox.shrink();
                      }
                    },
                  ),
      ),
    );
  }
}
