import 'dart:io';
import 'package:studify/views/videoList_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:studify/controllers/utils.dart';
import 'package:video_player/video_player.dart';
import 'package:studify/controllers/save_video.dart';

class PickVideoScreen extends StatefulWidget {
  const PickVideoScreen({Key? key}) : super(key: key);

  @override
  State<PickVideoScreen> createState() => _PickVideoScreenState();
}

class _PickVideoScreenState extends State<PickVideoScreen> {
  String? _videoURL;
  VideoPlayerController? _controller;
  String? _downloadURL;

  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Upload'),
        actions: [
          IconButton(
              onPressed: (){
                Get.to(() => VideoListScreen());
              },
              icon: const Icon(Icons.history))
        ],
      ),
      body: Center(
        child: _videoURL != null ? _videoPreviewWidget() : const Text('No Video Selected'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickVideo,
        child: Icon(Icons.video_library),
      )
    );
  }
  void _pickVideo() async{
    _videoURL = await pickVideo();
    _initializeVideoPlayer();
  }
  void _initializeVideoPlayer(){
    _controller = VideoPlayerController.file(File(_videoURL!))
        ..initialize().then((_) {
          setState(() {});
          _controller!.play();
        });
  }

  Widget _videoPreviewWidget(){
    if(_controller != null){
      return Column(
        children: [
          AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
          ),
          ElevatedButton(onPressed: _uploadVideo, child: const Text('upload')),
        ],
      );
    }
    else{
      return CircularProgressIndicator();
    }
  }
  void _uploadVideo() async{
    _downloadURL = await StoreData().uploadVideo(_videoURL!);
    await StoreData().saveVideoData(_downloadURL!);
    setState(() {
      _videoURL = null;
    });
  }
}
