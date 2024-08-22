import 'package:flutter/material.dart';

class CustomDefaultButton extends StatelessWidget {
  const CustomDefaultButton({super.key, required this.text, required this.onPressed});
final String text;
final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
                      onPressed:onPressed,
                      icon: const Icon(Icons.check),
                      label: Text(text),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                    );
  }
}