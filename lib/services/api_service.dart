import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inter_movie/models/movie_detail.dart';
import 'package:inter_movie/models/movie_model.dart';

class ApiService {
  final String baseUrl =
      'https://api.themoviedb.org/3'; // Movie Database Api Key
  final String apiKey =
      'YOUR-API-KEY-HERE'; // Movie Database Base URL

  Future<String> loginResponse(String email, String password) async {
    try {
      http.Response response = await http.post(
          Uri.parse("https://reqres.in/api/login"),
          body: {"email": email, "password": password});

      var jsonResp = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return 'success';
      } else {
        return jsonResp['error'];
      }
    } catch (e) {
      debugPrint(e.toString());
      return 'error';
    }
  }

  Future<List<Movie>> getTrendingMovies() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/trending/movie/week?api_key=$apiKey'));

      var movies = await jsonDecode(response.body)['results'] as List;

      List<Movie> movielist = movies.map((e) => Movie.fromJson(e)).toList();

      return movielist;
    } catch (error, stack) {
      throw Exception('Exception occured: $error with stacktrace $stack');
    }
  }

  Future<MovieDetail> movieDetail(int movieId) async {
    try {
      
      final response =
          await http.get(Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey'));

     

      MovieDetail movieDetail = MovieDetail.fromJson(jsonDecode(response.body));
      movieDetail.castList = await getCasts(movieId);

      

      return movieDetail;
    } catch (error, stack) {
      throw Exception('Exception occured: $error with stacktrace: $stack');
    }
  }

  Future<List> getCasts(int id) async {
    try {
      List<String> finalCast = [];
      final response = await http
          .get(Uri.parse('$baseUrl/movie/$id/credits?api_key=$apiKey'));

      var casts = await jsonDecode(response.body)['cast'];

      casts.forEach((element) {
        finalCast.add(element['name']);
      });

      return finalCast;
    } catch (error, stack) {
      throw Exception('Exception occured: $error with stacktrace: $stack');
    }
  }
}
