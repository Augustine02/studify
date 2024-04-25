import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:studify/widgets/reusable_textbutton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studify/views/playVideo_screen.dart';

class LectureVideoScreenTest extends StatefulWidget {
  // LectureVideoScreenTest({required this.courseCode});
  // int courseCode;

  @override
  State<LectureVideoScreenTest> createState() => _LectureVideoScreenTestState();
}

class _LectureVideoScreenTestState extends State<LectureVideoScreenTest> {
  late Future<ListResult> futureFiles;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // /COS${widget.courseCode}
    futureFiles = FirebaseStorage.instance.ref('/finalyear/firstsemester').listAll();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 100, left: 30, right: 30, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: (){Get.back();},
                      icon: Icon(Icons.chevron_left_rounded, color: Color(0xff0F4206), size: 50,)),
                  SizedBox(height: 30),
                  Text('Semester \nCourses',
                      style: GoogleFonts.inika(
                          textStyle: TextStyle(color: Color(0xff0F4206), fontSize: 30, fontWeight: FontWeight.w600)
                      )
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: FutureBuilder<ListResult>(
                  future: futureFiles,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      final files = snapshot.data!.prefixes;

                      return ListView.builder(
                        itemBuilder: (context, index){
                          final file = files[index];
                          return ReusableTextButton(
                            title: '${file.name}',
                            color: Color(0xff0F4206),
                            textColor: Colors.white,
                            onPress: (){
                              // Get.to(() =>
                              //     LectureVideoScreen(
                              //   courseCode: 417,
                              // )
                              // );
                            },
                          );
                        },
                        itemCount: files.length,

                      );
                    }else if (snapshot.hasError){
                      return const Center(child: Text('Error occured'),);
                    }else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  }

              ),
            ),
          ],
        ),
      ),
    );
  }
}
