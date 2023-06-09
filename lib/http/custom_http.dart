import 'dart:convert';

import 'package:http/http.dart'as http;

import '../model/news_model.dart';


class CustomHttpRequest{


  static Future<NewsModel>fetchNewsData(int pageNo,String sortBy) async{
    NewsModel ? newsModel;
    try{

      String url= "https://newsapi.org/v2/everything?q=all&sortBy=$sortBy&page=$pageNo&apiKey=f81536b0452f4356a4a86fefb164b8f0";

      var response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body);

      print("The response is ${data}");

      newsModel = NewsModel.fromJson(data);
      return newsModel!;
    }catch(e){
      print("Something is wrong ${e}");

      return newsModel!;
    }


  }

  static Future<NewsModel>searchNewsData(String query) async{
    NewsModel ? newsModel;
    try{

      String url= "https://newsapi.org/v2/everything?q=$query&sortBy=publishedAt&apiKey=f81536b0452f4356a4a86fefb164b8f0";

      var response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body);

      print("The response is ${data}");

      newsModel = NewsModel.fromJson(data);
      return newsModel!;
    }catch(e){
      print("Something is wrong ${e}");

      return newsModel!;
    }


  }

}