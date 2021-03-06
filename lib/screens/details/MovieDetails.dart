import 'package:cinema_x/config/AppSettings.dart';
import 'package:cinema_x/models/Movie.dart';
import 'package:cinema_x/models/actor.dart';
import 'package:cinema_x/models/watchedFilm.dart';
import 'package:cinema_x/screens/details/movie_detail_header.dart';
import 'package:cinema_x/screens/details/photo_scroller.dart';
import 'package:cinema_x/screens/details/story_line.dart';
import 'package:cinema_x/utils/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
// import 'package:youtube_player/youtube_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'actor_scroller.dart';


class MovieDetailsPage extends StatefulWidget {
  MovieDetailsPage({Key key, this.movie}) : super(key: key);
  final Movie movie;
  // final Watched watch;

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String videoUrl;
  // VideoPlayerController _videoController; 
  YoutubePlayerController _videoController;
  bool isMute = false;
  bool isExpanded = false;
  String movieInfo;

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

    movieInfo = CommonString.movieInfo
        .replaceFirst(
            "_value0_",
            widget.movie.categories
                .map((c) => ReCase(c).sentenceCase)
                .join(", "))
        .replaceFirst("_value1_", widget.movie.director)
        .replaceFirst("_value2_", widget.movie.actorsName.join(", "));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MenuBar(),
      key: _scaffoldKey,
      // backgroundColor: Color.fromRGBO(39, 50, 56, 1),
      backgroundColor: Color(0xFF222222),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                MovieDetailHeader(
                  movie:  widget.movie,
                  expanded: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
                isExpanded
                    ? Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          _trailer(videoUrl)
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
                          movieInfo,
                          style: Theme.of(context).textTheme.body1.copyWith(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                        ),
                      ],
                    )),
                // PhotoScroller([widget.movie.imageUrl]),
                // SizedBox(height: 20.0),
                // ActorScroller(widget.movie.actorsName
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
              elevation: 0.0,
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

  // Widget _trailer(context, url) {
  //   return Column(
  //     children: <Widget>[
  //       YoutubePlayer(
  //         context: context,
  //         source: url,
  //         quality: YoutubeQuality.HIGH,
  //         aspectRatio: 16 / 9,
  //         autoPlay: false,
  //         loop: false,
  //         reactToOrientationChange: true,
  //         startFullScreen: false,
  //         controlsActiveBackgroundOverlay: true,
  //         controlsTimeOut: Duration(seconds: 4),
  //         playerMode: YoutubePlayerMode.DEFAULT,
  //         callbackController: (controller) {
  //           _videoController = controller;
  //         },
  //         onError: (error) {
  //           print(error);
  //         },
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           IconButton(
  //               icon: _videoController != null
  //                   ? _videoController.value.isPlaying
  //                       ? Icon(Icons.pause)
  //                       : Icon(Icons.play_arrow)
  //                   : Icon(Icons.play_arrow),
  //               onPressed: () {
  //                 setState(() {
  //                   _videoController.value.isPlaying
  //                       ? _videoController.pause()
  //                       : _videoController.play();
  //                 });
  //               }),
  //           IconButton(
  //             icon: Icon(isMute ? Icons.volume_off : Icons.volume_up),
  //             onPressed: () {
  //               _videoController.setVolume(isMute ? 1 : 0);
  //               setState(
  //                 () {
  //                   isMute = !isMute;
  //                 },
  //               );
  //             },
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget _trailer (url){
    String videoId;
    videoId = YoutubePlayer.convertUrlToId(url);
    return Column(
      children: <Widget>[
        YoutubePlayer(
          controller : YoutubePlayerController(
            initialVideoId: videoId,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
              disableDragSeek: false,
              loop: true,
              forceHD: true,
              enableCaption: false,
            ))
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: <Widget>[
        //     IconButton(
        //         icon: _videoController != null
        //             ? _videoController.value.isPlaying
        //                 ? Icon(Icons.pause)
        //                 : Icon(Icons.play_arrow)
        //             : Icon(Icons.play_arrow),
        //         onPressed: () {
        //           setState(() {
        //             _videoController.value.isPlaying
        //                 ? _videoController.pause()
        //                 : _videoController.play();
        //           });
        //         }),
        //     IconButton(
        //       icon: Icon(isMute ? Icons.volume_off : Icons.volume_up),
        //       onPressed: () {
        //         _videoController.setVolume(isMute ? 1 : 0);
        //         setState(
        //           () {
        //             isMute = !isMute;
        //           },
        //         );
        //       },
        //     ),
        //   ],
        // ),
      ],
    );
  }
}