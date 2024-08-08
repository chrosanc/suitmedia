import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class ThirdScreenViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<UserModel> _users = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMoreData = true;
  int _currentPage = 1;

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMoreData => _hasMoreData;

  Future<void> fetchUsers() async {
    _isLoading = true;
    try {
      _currentPage = 1; // reset page count on fetch
      final fetchedUsers = await _apiService.fetchUsers(_currentPage, 10);
      _users = fetchedUsers;
      _hasMoreData = fetchedUsers.length == 10;
      print('Users loaded: ${_users.length}');
    } catch (e) {
      _hasMoreData = false;
      _users = [];
      print('Error fetching users: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoreUsers() async {
    if (!_hasMoreData || _isLoadingMore) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      _currentPage++;
      final fetchedUsers = await _apiService.fetchUsers(_currentPage, 10);
      if (fetchedUsers.isNotEmpty) {
        _users.addAll(fetchedUsers);
        _hasMoreData = fetchedUsers.length == 10;
      } else {
        _hasMoreData = false;
      }
      print('More users loaded: ${_users.length}');
    } catch (e) {
      _hasMoreData = false;
      print('Error fetching more users: $e');
    }

    _isLoadingMore = false;
    notifyListeners();
  }

  Future<void> refreshUsers() async {
    await fetchUsers();
  }
}
