import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:studify/views/playVideo_screen.dart';

class LectureVideoScreen extends StatefulWidget {
  LectureVideoScreen({required this.department, required this.semester, required this.year,required this.courseName});
  String? department;
  String? semester;
  String? year;
  String? courseName;

  @override
  State<LectureVideoScreen> createState() => _LectureVideoScreenState();
}

class _LectureVideoScreenState extends State<LectureVideoScreen> {
  late Future<ListResult> futureFiles;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/${widget.department}/${widget.year}/${widget.semester}/${widget.courseName}').listAll();
    // futureFiles = FirebaseStorage.instance.ref('/finalyear/firstsemester/COS${widget.courseCode}').listAll();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecture Videos'),
      ),
      body: FutureBuilder<ListResult>(
          future: futureFiles,
          builder: (context, snapshot){
            if(snapshot.hasData){
              final files = snapshot.data!.items;

              return ListView.builder(
                  itemBuilder: (context, index){
                    final file = files[index];
                    return ListTile(
                      title: Text(file.name),
                      trailing: IconButton(
                          onPressed: () async{
                           String videoURL = await file.getDownloadURL();
                           // CircularProgressIndicator();
                            Get.to(() => PlayVideoScreen(
                                videoURL: videoURL,
                                videoName: file.name));
                          },
                          icon: Icon(Icons.video_camera_back_rounded)),
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
    );
  }
}
