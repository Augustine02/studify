import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconData? icon;
  const ReusableTextField({this.title, this.icon, this.controller, this.obscureText = false, this. validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.green,),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2),
              borderRadius: BorderRadius.circular(30)
          ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white60, width: 2),
                borderRadius: BorderRadius.circular(30)
            ),
            filled: false,
            fillColor: Colors.black12,
            errorStyle: TextStyle(color: Colors.red),
            hintText: title,
            hintStyle: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w400
            )
        ),
      ),
    );
  }
}