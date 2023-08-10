// ignore_for_file: file_names

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/NY_times_model.dart';

class PostService {
  final Dio _dio;
  PostService() : _dio = Dio(BaseOptions(baseUrl: 'https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?api-key='));

  Future<List<Result>?> fetchPostItems() async {
    try {
      final response = await _dio.get('i5U0k05a2ZwXJKoID0P5zLeKxkEvkpBG');

      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data;

        if (datas.containsKey('results')) {
          final results = datas['results'];

          return (results as List<dynamic>).map((e) => Result.fromJson(e)).toList();
        }
      }
    } on DioException catch (exception) {
      _ShowDebug.showDioError(exception, this);
    }
    return null;
  }
}

class _ShowDebug {
  static void showDioError<T>(DioException error, T type) {
    if (kDebugMode) {
      print(error.message);
      print(type);
    }
  }
}
