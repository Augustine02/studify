import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studify/controllers/auth_controller.dart';
import 'package:studify/views/login_screen.dart';
import 'package:studify/widgets/reusable_textfield.dart';
import 'package:studify/widgets/reusable_textbutton.dart';
import 'package:studify/views/loading_screen.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return isLoading? LoadingScreen(): Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){Get.back();},
            icon: Icon(Icons.chevron_left_rounded, color: Color(0xFF0F4206), size: 50,)),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Receive an email to\nreset your password',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inika(
                      textStyle: TextStyle(color: Color(0xFF0F4206), fontSize: 25, fontWeight: FontWeight.w600)
                  )
              ),
              SizedBox(
                height: 25,
              ),
              ReusableTextField(
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                title: 'Email',
                icon: Icons.email,
                controller: emailController,
              ),
              SizedBox(
                height: 25,
              ),
              ReusableTextButton(
                title: 'Reset Password',
                color: Color(0xFF0F4206),
                textColor: Colors.white,
                onPress: () async{
                  if(_formKey.currentState!.validate()){
                    setState(() => isLoading = true);
                    await AuthController.instance.resetPassword(emailController.text.trim());
                    setState(() => isLoading = false);
                  }
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
