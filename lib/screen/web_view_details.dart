
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:news_app/model/news_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
class NewsWebView extends StatefulWidget {
  NewsWebView({Key? key, this.articles}) : super(key: key);


  Articles?articles;
  @override
  State<NewsWebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {

  WebViewController ? controller;

  @override
  void initState() {
    // TODO: implement initState

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))

      ..loadRequest(Uri.parse('${widget.articles!.url}'));
    super.initState();
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: "${widget.articles!.source!.name}",
        text: "${widget.articles!.source!.name}",
        linkUrl: '${widget.articles!.url}',
        chooserTitle: 'Share'
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("${widget.articles!.source!.name}"),centerTitle: true,backgroundColor: Colors.brown,
     actions: [IconButton(onPressed: (){
       share();
     }, icon: Icon(Icons.share))],
      ),

      body: WebViewWidget(controller: controller!),
    );
  }
}
