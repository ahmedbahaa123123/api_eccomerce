// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   const CustomTextField(
//       {super.key,
//       required this.label,
//       required this.icon,
//       required this.controller});
//   final String label;
//   final Widget icon;
//   final TextEditingController controller;
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: icon,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final Icon icon;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.icon,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onChanged: onChanged,
    );
  }
}