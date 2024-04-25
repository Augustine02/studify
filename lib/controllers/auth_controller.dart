import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/views/home_screen.dart';
import 'package:studify/views/login_screen.dart';
import 'package:studify/views/signup_screen.dart';
import 'package:studify/views/verifyEmail_screen.dart';

class AuthController extends GetxController{
  //Auth.Controller.instance..
  static AuthController instance = Get.find();
  //email, password, name ...
  late Rx<User?> _user;
  // bool canResendEmail = false ;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
    void onReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //our user would be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  Rx<User?> getUser(){
    return _user;
  }

  _initialScreen(User? user){
    if(user==null){
      print("login page");
      Get.offAll(() => LoginScreen() );
    }
    else if(auth.currentUser!.emailVerified == false){
      Get.to(() => VerifyEmailScreen());}
    else{
      Get.offAll(() => HomeScreen(email:user.email!) );
    }
  }

  Future<void> register(String email, password) async{
    try{
      print(email);
      print(password);
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    }catch(e){
      Get.snackbar("About User", "User message",
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
            'Account creation failed',
        style: TextStyle(
          color: Colors.white
        ),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white
          ),
        )
      );
    }
  }
  Future<void> login(String email, password) async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            'Login failed',
            style: TextStyle(
                color: Colors.white
            ),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(
                color: Colors.white
            ),
          )
      );
    }
  }
  void logOut() async{
    await auth.signOut();
  }
  Future <void> resetPassword(String email)async{
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Password", "Reset",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          // titleText: Text(
          //   'Password reset failed',
          //   style: TextStyle(
          //       color: Colors.white
          //   ),
          // ),
          messageText: Text(
            'Password Reset Email Sent',
            style: TextStyle(
                color: Colors.white
            ),
          )
      );
    }catch(e){
      Get.snackbar("Password", "Reset",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            'Password reset failed',
            style: TextStyle(
                color: Colors.white
            ),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(
                color: Colors.white
            ),
          )
      );
    }
  }
  Future sendVerificationEmail()async{
    try {
      await auth.currentUser!.sendEmailVerification();
      // await Future.delayed(Duration(seconds: 5));
      Get.snackbar("Verification", "",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          // titleText: Text(
          //   'Password reset failed',
          //   style: TextStyle(
          //       color: Colors.white
          //   ),
          // ),
          messageText: Text(
            'A verification email has been sent to your email',
            style: TextStyle(
                color: Colors.white
            ),
          )
      );
    }catch(e){
      Get.snackbar("Verification", "",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            'Verification failed',
            style: TextStyle(
                color: Colors.white
            ),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(
                color: Colors.white
            ),
          )
      );
    }
  }
  }