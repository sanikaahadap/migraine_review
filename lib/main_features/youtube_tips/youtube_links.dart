import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final videoUrls = [
  'https://www.youtube.com/watch?v=INTm9FCDXug',
  'https://www.youtube.com/watch?v=nqLa3XoNCAc',
  'https://www.youtube.com/watch?v=Wrb1_O3R3F4',
  'https://www.youtube.com/watch?v=rRehOUhRvj4'
];

final videoTitles = [
  'Health Awareness on Headache (Telugu)',
  'Health Awareness on Cluster Headache (English)',
  'Health Awareness on Tension Type Headache (English)',
  'Health Awareness on Analgesic Abuse (English)',
];

class YoutubeTips extends StatelessWidget {
  const YoutubeTips({super.key});

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
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Invalid video URL'),
                ));
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  YoutubePlayer.getThumbnail(videoId: videoID ?? ''),
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 280,
                      height: 200,
                      color: Colors.grey, // Placeholder image
                      child: const Center(
                        child: Icon(Icons.error),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      videoTitles[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
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
  PlayerScreenState createState() => PlayerScreenState();
}

class PlayerScreenState extends State<PlayerScreen> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
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
      appBar: AppBar(
        title: const Text(
          'Videos for reference',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF16666B),
      ),
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
