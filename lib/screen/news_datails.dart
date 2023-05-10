import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';

class NewsDetails extends StatelessWidget {
 NewsDetails({Key? key, this.articles}) : super(key: key);
Articles? articles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

appBar: AppBar(title: Text("${articles!.source!.name}"),centerTitle: true,backgroundColor: Colors.brown,),
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

                imageUrl: "${articles!.urlToImage}",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Image.asset("images/no_image.jpg"),
                fit: BoxFit.cover,

              ),),
              SizedBox(height: 10,),
              Container(
                child: Column(
                  children: [
                    Text("${articles!.title}", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                    SizedBox(height:10),
                    Text("${articles!.description}",style: TextStyle(color: Colors.white70, fontSize:14),),
                    //Text("${articles!.content}",style: TextStyle(color: Colors.white60, fontSize:14),),
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



