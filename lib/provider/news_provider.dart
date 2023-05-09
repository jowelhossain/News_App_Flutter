import 'package:flutter/cupertino.dart';
import 'package:news_app/http/custom_http.dart';
import 'package:news_app/model/news_model.dart';
import 'package:provider/provider.dart';

class NewsProvider with ChangeNotifier{
NewsModel? newsModel;
  Future<NewsModel>getNewsData(int pageNo) async{

newsModel = await CustomHttpRequest.fetchNewsData(pageNo);

return newsModel!;

}

}