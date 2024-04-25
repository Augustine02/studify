
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studify/controllers/auth_controller.dart';
import 'package:studify/widgets/reusable_textbutton.dart';
import 'package:get/get.dart';
import 'choiceOfDepartment_screen.dart';


class HomeScreen extends StatelessWidget {

  HomeScreen({ required this.email});

  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F4206),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){
                  AuthController.instance.logOut();
                },
                  icon: Icon(Icons.menu, color: Colors.white, size: 30,),),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('A',
                      style: GoogleFonts.inika(
                          textStyle: TextStyle(color: Colors.black, fontSize: 20)
                      )
                  ),
                )
              ],
            ),
           Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Welcome\nThere',
                    style: GoogleFonts.inika(
                        textStyle: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600)
                    )
                ),
                Text(
                    '$email',
                    style: GoogleFonts.inika(
                        textStyle: TextStyle(color: Colors.white54, fontSize: 16, fontWeight: FontWeight.w600)
                    )
                ),
              ],
            ),

            Center(
              child: Text("Let's Study",
                  style: GoogleFonts.irishGrover(
                      textStyle: TextStyle(color: Colors.white, fontSize: 32)
                  )
              ),
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ReusableTextButton(
                  title: 'Continue',
                  textColor: Color(0xFF0F4206),
                  color: Colors.white,
                  onPress: (){
                    Get.to(() => ChoiceOfDepartmentScreen());
                  },
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
