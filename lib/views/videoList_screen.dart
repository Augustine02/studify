import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:studify/views/playVideo_screen.dart';

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({Key? key}) : super(key: key);

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video List'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('videos').snapshots(), 
                  builder: (context, snapshot){
                    List<Row> videoWidgets = [];
                    if(!snapshot.hasData){
                      const CircularProgressIndicator();
                    }
                    else{
                      final videos = snapshot.data?.docs.reversed.toList();
                      for(var video in videos!){
                        final videoWidget = Row(
                          children: [
                            Text(video['name']),
                            IconButton(
                                onPressed: (){
                                  Get.to(() => PlayVideoScreen(
                                    videoURL: video['url'],
                                    videoName: video['name'],
                                  ));
                                },
                                icon: const Icon(Icons.play_arrow_rounded))
                          ],
                        );
                        videoWidgets.add(videoWidget);
                      }
                    }
                    return Expanded(
                        child: ListView(
                          children: videoWidgets,
                        ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
