import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studify/views/forgotPassword_screen.dart';
import 'package:studify/views/signup_screen.dart';
import 'package:studify/widgets/reusable_textfield.dart';
import 'package:studify/widgets/reusable_textbutton.dart';
import 'package:studify/views/loading_screen.dart';
import 'package:studify/controllers/auth_controller.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return isLoading? LoadingScreen(): Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height/3,
                child: Center(child:
                Text('Studify',
                    style: GoogleFonts.kenia(
                        textStyle: TextStyle(color: Colors.white, fontSize: 40)
                    )
                ),),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color(0xff0F4206),
                    Color(0xff206F12),
                    Color(0xff51F035)
                  ]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))
                ),
              ),
              Container(
                padding: EdgeInsets.all(40),
                height: MediaQuery.of(context).size.height/1.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Login',
                        style: GoogleFonts.inika(
                            textStyle: TextStyle(color: Color(0xFF0F4206), fontSize: 40, fontWeight: FontWeight.w600)
                        )
                    ),
                    Column(
                      children: [
                        ReusableTextField(
                          validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                          title: 'Email',
                          icon: Icons.email,
                          controller: emailController,
                        ),
                        ReusableTextField(
                          validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                          title: 'Password',
                          obscureText: true,
                          icon: Icons.key,
                          controller: passwordController,
                        )
                      ],
                    ),
                    ReusableTextButton(
                        title: 'Sign in',
                        color: Color(0xFF0F4206),
                      textColor: Colors.white,
                      onPress: () async{
                        if(_formKey.currentState!.validate()){
                          setState(() => isLoading = true);
                          await AuthController.instance.login(emailController.text.trim(), passwordController.text.trim());
                          setState(() => isLoading = false);
                        }
                      },
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(() => ForgotPasswordScreen());
                      },
                      child: Text('Forgot Password?',
                          style: GoogleFonts.inika(
                              textStyle: TextStyle(color: Color(0xFF0F4206), fontSize: 20, fontWeight: FontWeight.w600)
                          )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text("Don't have an account? ",
                          style: GoogleFonts.inika(
                              textStyle: TextStyle(color: Colors.black26, fontSize: 14)
                          )
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(() => SignupScreen());
                          // Get.to(SignupScreen());
                        },
                        child: Text("Create",
                            style: GoogleFonts.inika(
                                textStyle: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600)
                            )
                        ),
                      ),
                    ],)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


