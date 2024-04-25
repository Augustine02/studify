import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F4206),
      // Color(0xFF228B22),
      body: Center(child:
      Text('Studify',
          style: GoogleFonts.kenia(
        textStyle: TextStyle(color: Colors.white, fontSize: 40)
      )
    ),),
    );
  }
}

