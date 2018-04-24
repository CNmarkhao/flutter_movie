import 'dart:convert';

import 'package:meta/meta.dart';

class Movie {
  final String title;
  final String average; //这里解析 double 是报错的，不应该啊？！
  final int collectCount;
  final String smallImage;
  final String director;
  final String cast;
  final String movieId;

  @override
  String toString() {
    return 'Movie{title: $title, average: $average, collectCount: $collectCount, smallImage: $smallImage, director: $director, cast: $cast, movieId: $movieId}';
  } //构造函数

  Movie({
    @required this.title,
    @required this.average,
    @required this.collectCount,
    @required this.smallImage,
    @required this.director,
    @required this.cast,
    @required this.movieId,
  });

  static List<Movie> allFromResponse(String mjson) {
    List<Movie> result = [];
    List<dynamic> array = json.decode(mjson)['subjects'];
    for (Map item in array) {
      result.add(Movie.fromMap(item));
    }
    print(result.length);
    return result;
  }

  static Movie fromMap(Map map) {
    List directors = map['directors'];
    List casts = map['casts'];
    var d = '';
    for (int i = 0; i < directors.length; i++) {
      if (i == 0) {
        d = d + directors[i]['name'];
      } else {
        d = d + '/' + directors[i]['name'];
      }
    }
    var c = '';
    for (int i = 0; i < casts.length; i++) {
      if (i == 0) {
        c = c + casts[i]['name'];
      } else {
        c = c + '/' + casts[i]['name'];
      }
    }
    return new Movie(
      title: map['title'],
      average: map['rating']['average'].toString(),
      collectCount: map['collect_count'],
      smallImage: map['images']['small'],
      director: d,
      cast: c,
      movieId: map['id'],
    );
  }
}
