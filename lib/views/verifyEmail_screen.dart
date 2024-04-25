import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studify/widgets/reusable_textbutton.dart';
import 'package:studify/controllers/auth_controller.dart';
import 'package:studify/views/home_screen.dart';
import 'dart:async';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  Future checkEmailVerified()async{
    await AuthController.instance.auth.currentUser!.reload();
    setState(() {
      isEmailVerified = AuthController.instance.auth.currentUser!.emailVerified;
    });
    if(isEmailVerified) {timer?.cancel();}
  }
  //
  @override
  void initState() {
    super.initState();
    isEmailVerified = AuthController.instance.auth.currentUser!.emailVerified;

    if(!isEmailVerified){
      print('sending mail again');
      AuthController.instance.sendVerificationEmail();
      setState(() {canResendEmail = false;});
      Future.delayed(Duration(seconds: 5));
      setState(() {canResendEmail = true;});
      // checkEmailVerified();
      timer = Timer.periodic(
          Duration(seconds: 3),
              (_) => checkEmailVerified(),
              );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: (){Get.back();},
        //     icon: Icon(Icons.chevron_left_rounded, color: Colors.white, size: 40,)),
        title: Text('Verify Email',
          style: GoogleFonts.inika(
              textStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)
          )
      ),backgroundColor: Color(0xFF0F4206),),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('A verification email has been sent to \nyour mail',
                style: GoogleFonts.inika(
                    textStyle: TextStyle(color: Color(0xFF0F4206), fontSize: 20),

                ),
              textAlign: TextAlign.center,
            ),
            ReusableTextButton(
              title: 'Resend mail',
              color: canResendEmail ? Color(0xFF0F4206): Colors.white,
              textColor: canResendEmail ? Colors.white : Color(0xFF0F4206),
              borderColor: canResendEmail ? Colors.white : Color(0xFF0F4206),
              onPress: () async {
                if(canResendEmail = true) {
                  AuthController.instance.sendVerificationEmail();
                  setState(() {canResendEmail = false;});
                  await Future.delayed(Duration(seconds: 5));
                  setState(() {canResendEmail = true;});
                } else{
                 return null;
                }
              },
            ),
            ReusableTextButton(
              title: 'cancel',
              color: Colors.white,
              textColor: Color(0xFF0F4206),
              borderColor: Color(0xFF0F4206),
              onPress: () {
                AuthController.instance.logOut();
              },
            ),
          ],
        ),
      ),

    );
  }
}

