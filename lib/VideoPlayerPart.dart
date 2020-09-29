part of "main.dart";

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  int startTime = 0;

  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/video4k.mp4');

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);
    _controller.play();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Video Test'), backgroundColor: Colors.blue),
        body: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GestureDetector(
                onTap: () {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                },
                child: Stack(
                  children: [
                    VideoPlayer(_controller),
                    Center(
                        child: Text(
                      "It took " +
                          (DateTime.now().millisecondsSinceEpoch - startTime)
                              .toString() +
                          " milliseconds",
                      style: TextStyle(fontSize: 30, color: Colors.red),
                      key: Key("VideoPlayerText"),
                    ))
                  ],
                ),
              );
            } else {
              startTime = DateTime.now().millisecondsSinceEpoch;
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
