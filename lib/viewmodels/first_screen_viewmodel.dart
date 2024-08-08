import 'package:flutter/material.dart';

class FirstScreenViewModel extends ChangeNotifier {
  String _name = '';

  String get name => _name;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  bool isPalindrome(String sentence) {
    final cleanedText = sentence.replaceAll(RegExp(r'\W'), '').toLowerCase();
    final reversedText = cleanedText.split('').reversed.join('');
    return cleanedText == reversedText;
  }
}
