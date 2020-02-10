import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/models/Movie.dart';
import 'package:cinema_x/screens/booking/booking.dart';
import 'package:cinema_x/screens/details/arc_banner_image.dart';
import 'package:cinema_x/screens/details/poster.dart';
import 'package:cinema_x/screens/account/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieDetailHeader extends StatefulWidget {
  MovieDetailHeader({Key key, this.movie, this.expanded}) : super(key: key);
  final Movie movie;
  final Function() expanded;

  @override
  _MovieDetailHeaderState createState() => _MovieDetailHeaderState();
}

class _MovieDetailHeaderState extends State<MovieDetailHeader> {
  bool isMute = false;
  bool isExpanded = false;
  bool isLoggedIn = false;
  Widget _buildCategoryChips(TextTheme textTheme) {
    // return movie.categories.map((category) {
    SharedPreferences.getInstance()
        .then((result) => isLoggedIn = result.getBool("isLoggedIn") ?? false);

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text("Thời lượng: ${widget.movie.duration} phút"),
        labelStyle: textTheme.caption.copyWith(
          color: Color.fromRGBO(39, 50, 56, 1),
          fontSize: 15,
        ),
        backgroundColor: Colors.black12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;

    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.movie.name,
          style: textTheme.headline6,
        ),
        SizedBox(height: 8.0),
        Row(children: [_buildCategoryChips(textTheme)]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: RaisedButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => isLoggedIn
                          ? BookingPage(movie: widget.movie)
                          : LoginPage(),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                child: AutoSizeText(
                  "ĐẶT VÉ",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: RaisedButton(
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    widget.expanded();
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                child: AutoSizeText(
                  "Trailer",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 140.0),
          // child: ArcBannerImage(movie.bannerUrl),
          child: ArcBannerImage(widget.movie.imageUrl),
        ),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Poster(
              //   movie.posterUrl,
              //   height: 180.0,
              // ),
              Poster(
                widget.movie.imageUrl,
                height: 180.0,
              ),
              SizedBox(width: 16.0),
              Expanded(child: movieInformation),
            ],
          ),
        ),
      ],
    );
  }
}
