import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/screen/web_view_details.dart';

class NewsDetails extends StatefulWidget {
 NewsDetails({Key? key, this.articles}) : super(key: key);
Articles? articles;

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

appBar: AppBar(title: Text("${widget.articles!.source!.name}"),centerTitle: true,backgroundColor: Colors.brown,),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
        color: Colors.teal,
            border: Border.all(color: Colors.yellow, width: 5)
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(children: [
              Container(child: CachedNetworkImage(

                imageUrl: "${widget.articles!.urlToImage}",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Image.asset("images/no_image.jpg"),
                fit: BoxFit.cover,

              ),),
              SizedBox(height: 10,),
              Container(
                child: Column(
                  children: [
                    Text("${widget.articles!.title}", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                    SizedBox(height:10),
                    Text("${widget.articles!.description}",style: TextStyle(color: Colors.white70, fontSize:14),),
                    //Text("${articles!.content}",style: TextStyle(color: Colors.white60, fontSize:14),),
                    
                    TextButton(onPressed: (){

                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewsWebView(articles: widget.articles,)));
                    }, child: Text("See more", style: TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.cyan)),)
                    ]
                ),
              )
            ],),
          ),
        ),

      ),
    );
  }
}



