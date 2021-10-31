import 'dart:async';

import 'package:dio/dio.dart';

class NewsAPI{

  static Dio? dio ;
  static Response? response;

  //News categories
  static String business = "business";
  static String entertainment = "entertainment";
  static String health = "health";
  static String science = "science";
  static String sports = "sports";
  static String technology = "technology";

  //Countries
  static String egypt = "EG";
  static String usa = "US";
  static String uk = "GB";
  //Url Top lines
  static String baseURL = 'https://newsapi.org/';
  static String method = 'v2/top-headlines';
  static String methodSearch = 'v2/everything';

  //Api Key
  static String apiKey = 'cb2cb53e668e43bfbb18ef869b3242d2';


  static initializeAPI()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        receiveDataWhenStatusError: true
      )
    );
    print('API Initialized');
  }
}