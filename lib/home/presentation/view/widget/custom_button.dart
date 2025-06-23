import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, this.onPressed});
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        fixedSize: Size(105, 40),
      ),
      onPressed: onPressed,
      child: Text(title, style: TextStyle(color: Colors.white)),
    );
  }
}
