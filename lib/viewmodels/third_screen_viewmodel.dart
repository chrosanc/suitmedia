import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user_model.dart';

class ThirdScreenViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<UserModel> _users = [];
  bool _isLoading = true;
  int _page = 1;
  final int _perPage = 10;

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;

  Future<void> fetchUsers() async {
    _isLoading = true;
    final fetchedUsers = await _apiService.fetchUsers(_page, _perPage);
    _users = fetchedUsers;
    _isLoading = false;
    notifyListeners();
  }

  void loadMore() {
    _page++;
    fetchUsers();
  }
}
