import 'package:flutter/material.dart';
import 'package:quiz_app/welcom.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('lib/asset/video/HACA.mp4')
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        _controller.setLooping(true);
        _controller.play();
        _controller.addListener(_checkVideoPosition);
      });
  }

  @override
  void dispose() {
    _controller.removeListener(_checkVideoPosition);
    _controller.dispose();
    super.dispose();
  }

  void _checkVideoPosition() {
    if (_controller.value.position.inSeconds >= 10) {
      _navigateToNextScreen();
    }
  }

  void _navigateToNextScreen() {
    if (mounted) {
      _controller.pause();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black, // Set the background color
            child: Center(
              child: _isInitialized
                  ? Transform.scale(
                      scale: _controller.value.aspectRatio / deviceRatio,
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    )
                  : const CircularProgressIndicator(), // Show a loading indicator
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: _navigateToNextScreen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(185, 249, 249, 249),
                ),
                child: const SizedBox(
                  height: 30,
                  width: 150,
                  child: Center(
                    child: Text(
                      'Explore',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
