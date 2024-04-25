import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideoScreen extends StatefulWidget {
  PlayVideoScreen({required this.videoURL, required this.videoName});
  final String videoURL;
  final String videoName;

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  late VideoPlayerController _controller;
  bool isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    isLoading = true;
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoURL),
    );
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState((){
      isLoading = false;
    }));
    _controller.play();
    // isLoading = true;
    // isLoading = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play Video'),
      ),
      body: Center(
          child: Column(
            children: [
              isLoading ? CircularProgressIndicator():
              Expanded(
                flex: 4,
                child: AspectRatio(aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                  flex: 1 ,
                  child: Text(widget.videoName))
            ],
          ),
      ),
    );
  }
}
