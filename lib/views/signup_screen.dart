import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:studify/controllers/auth_controller.dart';
import 'package:studify/widgets/reusable_textfield.dart';
import 'package:studify/widgets/reusable_textbutton.dart';
import 'package:studify/views/login_screen.dart';
import 'package:studify/views/loading_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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
                // height: MediaQuery.of(context).size.height/1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Create\nAccount',
                        style: GoogleFonts.inika(
                            textStyle: TextStyle(color: Color(0xFF0F4206), fontSize: 40, fontWeight: FontWeight.w600)
                        )
                    ),
                    Column(
                      children: [
                        ReusableTextField(
                          validator: (val) => val!.isEmpty ? 'Enter a username' : null,
                          title: 'Username',
                          icon: Icons.person,
                          controller: userNameController,
                        ),
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
                        ),
                        ReusableTextField(
                          validator: (val) => val! != passwordController.text ? 'Password does not match' : null,
                          title: 'Confirm Password',
                          obscureText: true,
                          icon: Icons.key,
                          controller: confirmPasswordController,
                        )
                      ],
                    ),
                    ReusableTextButton(
                      title: 'Sign up',
                      color: Color(0xFF0F4206),
                      textColor: Colors.white,
                      onPress: () async{
                        if(_formKey.currentState!.validate()) {
                          setState(() => isLoading = true);
                          await AuthController.instance.register(emailController.text.trim(), passwordController.text.trim());
                          setState(() => isLoading = false);
                        }
                        },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? ",
                            style: GoogleFonts.inika(
                                textStyle: TextStyle(color: Colors.black26, fontSize: 14)
                            )
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.to(() => LoginScreen());
                            // Get.to(SignupScreen());
                          },
                          child: Text("Login",
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
