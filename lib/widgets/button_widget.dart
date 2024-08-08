import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Function()? onTap;
  final String title;

  const ButtonWidget({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
        backgroundColor: const Color(0xFF2B637B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
