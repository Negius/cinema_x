import 'package:cinema_x/models/Movie.dart';
import 'package:cinema_x/screens/details/movie_detail_header.dart';
import 'package:cinema_x/screens/details/story_line.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:youtube_player/youtube_player.dart';

class MovieDetailsPage extends StatefulWidget {
  MovieDetailsPage({Key key, this.movie}) : super(key: key);
  final Movie movie;

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String videoUrl;
  VideoPlayerController _videoController;
  bool isMute = false;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    videoUrl = widget.movie.videoUrl
        .split("/")
        .last
        .split("watch?v=")
        .last
        .split("&")
        .first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MenuBar(),
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(39, 50, 56, 1),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                MovieDetailHeader(
                  movie: widget.movie,
                  expanded: () {
                    setState(() {
                      print(isExpanded);
                      isExpanded = !isExpanded;
                      print("parent");
                      print(isExpanded);
                    });
                  },
                ),
                isExpanded
                    ? Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          _trailer(context, videoUrl)
                        ],
                      )
                    : Container(),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Storyline(widget.movie.introduction),
                        SizedBox(height: 20.0),
                        Text(
                          """
Thể loại: ${widget.movie.categories.map((c) => ReCase(c).sentenceCase).join(", ")}

Đạo diễn: ${widget.movie.director}

Diễn viên: ${widget.movie.actorsName.join(", ")}
""",
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                        ),
                      ],
                    )),
                // PhotoScroller([movie.imageUrl]),
                // SizedBox(height: 20.0),
                // ActorScroller(movie.actorsName
                //     .map((name) => Actor(name: name, avatarUrl: ""))
                //     .toList()),
                // SizedBox(height: 30.0),
              ],
            ),
          ),
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _trailer(context, url) {
    return Column(
      children: <Widget>[
        YoutubePlayer(
          context: context,
          source: url,
          quality: YoutubeQuality.HIGH,
          aspectRatio: 16 / 9,
          autoPlay: false,
          loop: false,
          reactToOrientationChange: true,
          startFullScreen: false,
          controlsActiveBackgroundOverlay: true,
          controlsTimeOut: Duration(seconds: 4),
          playerMode: YoutubePlayerMode.DEFAULT,
          callbackController: (controller) {
            _videoController = controller;
          },
          onError: (error) {
            print(error);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                icon: _videoController != null
                    ? _videoController.value.isPlaying
                        ? Icon(Icons.pause)
                        : Icon(Icons.play_arrow)
                    : Icon(Icons.play_arrow),
                onPressed: () {
                  setState(() {
                    _videoController.value.isPlaying
                        ? _videoController.pause()
                        : _videoController.play();
                  });
                }),
            IconButton(
              icon: Icon(isMute ? Icons.volume_off : Icons.volume_up),
              onPressed: () {
                _videoController.setVolume(isMute ? 1 : 0);
                setState(
                  () {
                    isMute = !isMute;
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
