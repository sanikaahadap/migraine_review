import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final videoUrls = [
  'https://www.youtube.com/watch?v=hYApsBuf7ec',
  'https://youtu.be/jryy3mlZtXk?si=lZ7FtWs6MzmdGWMp',
  'https://youtu.be/5SYUkCqfmc8?si=9WPKXgkn2dVvZQ_X',
  'https://www.youtube.com/watch?v=qEZf2q4W20g',
  'https://www.youtube.com/watch?v=jCbclWBV32o'
];

class Feed extends StatelessWidget {
  const Feed({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tips for Migraine Care',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF16666B),
      ),
      body: ListView.builder(
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          final videoID = YoutubePlayer.convertUrlToId(videoUrls[index]);

          return InkWell(
            onTap: () {
              if (videoID != null) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlayerScreen(videoId: videoID),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Invalid video URL'),
                ));
              }
            },
            child: Image.network(
              YoutubePlayer.getThumbnail(videoId: videoID ?? ''),
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 300,
                  height: 200,
                  color: Colors.grey, // Placeholder image
                  child: Center(
                    child: Icon(Icons.error),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key, required this.videoId}) : super(key: key);

  final String videoId;

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
        'Videos for reference',
        style: TextStyle(color: Colors.white),
      ),
        backgroundColor: const Color(0xFF16666B),),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: const ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
          onReady: () {
            _controller.addListener(() {
              // Listener logic if needed
            });
          },
        ),
        builder: (context, player) {
          return Column(
            children: [
              Expanded(child: player), // Player widget
               // Loading indicator
              // Widgets below the player
            ],
          );
        },
      ),
    );
  }

}
