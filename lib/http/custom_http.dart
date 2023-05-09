import 'dart:convert';

import 'package:http/http.dart'as http;

import '../model/news_model.dart';


class CustomHttpRequest{


  static Future<NewsModel>fetchNewsData(int pageNo) async{
    NewsModel ? newsModel;
    String url= "https://newsapi.org/v2/everything?q=all&sortBy=publishedAt&page=$pageNo&apiKey=f81536b0452f4356a4a86fefb164b8f0";

    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);

    print("The response is ${data}");

    newsModel = NewsModel.fromJson(data);
    return newsModel!;


  }

}