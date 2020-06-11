import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema_x/models/Movie.dart';
import 'package:cinema_x/screens/details/MovieDetails.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/config/AppSettings.dart';
import 'package:intl/intl.dart';

class Showing extends StatefulWidget {
  @override
  _ShowingState createState() => _ShowingState();
}

class _ShowingState extends State<Showing> {
  int _current = 0;
  Future<List<Movie>> _showingMovies;
  List imgList;
  List nameList;
  List dateList;
  List formattedDateList;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    _showingMovies = fetchShowingMovies();
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
            if (snapshot.data.length > 0) {
              imgList = snapshot.data.map((m) => m.imageUrl as String).toList();
              nameList = snapshot.data.map((m) => filmTitle(m.name)).toList();
              dateList = snapshot.data.map((m) => Text(
                'Khởi chiếu: '+ DateFormat('dd-MM-yyyy').format(DateTime.parse(m.premieredDay)),
                style: TextStyle(color: Colors.brown[200],)))
                .toList();
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
                               image: DecorationImage(
                                image: AssetImage("assets/images/background.jpg"),
                                fit: BoxFit.cover,
                              ),
                              // color: Colors.black,
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
                    height: 50.0,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 15.0, right: 15.0),
                        child: Column(
                          children: <Widget>[
                            nameList[_current],
                            dateList[_current]
                          ],)
                        // RichText(
                          // style: TextStyle(
                          //   fontSize: 16.0,
                          //   color: Colors.white,
                          //   fontWeight: FontWeight.bold,
                          // ),
                          // maxLines: 2,
                        // ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      CommonString.emptySchedules,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              );
            }
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        });
  }
}
