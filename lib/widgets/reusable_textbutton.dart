import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableTextButton extends StatelessWidget {
  final String? title;
  final Color? color ;
  final Color? textColor;
  final Color borderColor;
  final VoidCallback? onPress;
  ReusableTextButton({this.title, this.color, this.textColor, this.onPress, this.borderColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(color),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
              color: borderColor,
              width: 1
            )
          )
        )
      ),
      onPressed: onPress,
      child: Text('$title',
          style: GoogleFonts.inika(
              textStyle: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w600)
          )
      ),);
  }
}