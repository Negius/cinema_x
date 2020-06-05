import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema_x/models/Movie.dart';
import 'package:cinema_x/screens/details/MovieDetails.dart';
import 'package:flutter/material.dart';

class Comming extends StatefulWidget {
  @override
  _ShowingState createState() => _ShowingState();
}

class _ShowingState extends State<Comming> {
  int _current = 0;
  Future<List<Movie>> _showingMovies;
  List imgList;
  List nameList;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    _showingMovies = fetchComingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(top: 5),
      color: Color(0xFF222222),
      child: imgSlider(context),
    );
  }

  Widget imgSlider(BuildContext context) {
    return FutureBuilder(
        future: _showingMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            imgList = snapshot.data.map((m) => m.imageUrl as String).toList();
            nameList = snapshot.data.map((m) => m.name as String).toList();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CarouselSlider(
                  height: 405.0,
                  initialPage: 0,
                  enlargeCenterPage: true,
                  onPageChanged: (index) {
                    setState(() {
                      _current = index;
                    });
                  },
                  items: imgList.map((imgUrl) {
                    return Builder(builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailsPage(
                                movie: snapshot.data[_current],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Image.network(
                            imgUrl as String,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    });
                  }).toList(),
                ),
                SizedBox(
                  height: 40.0,
                  child: Center(
                    child: Text(
                      nameList[_current],
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          } else
            return Container();
        });
  }
}
