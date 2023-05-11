import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/screen/news_details.dart';
import 'package:news_app/screen/search_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageNo=1;

  String sortBy= "publishedAt";

  @override
  Widget build(BuildContext context) {

    var newsPorvider= Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.brown,
        title: Text("Daily News"),centerTitle: true,leading: Icon(Icons.newspaper_outlined),

        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, ModalBottomSheetRoute(builder: (context)=>SearchPage(), isScrollControlled: true));
          }, icon:Icon(Icons.search))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        width: double.infinity,

          child: ListView(

    children: [

      Container(
height: 50,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: (){
              setState(() {
                if(pageNo>1){
                  pageNo -=1;
                }
              });
            }, child: Text("Previous")),

            ListView.builder(
              shrinkWrap: true,
                itemCount: 5,
                 scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){

                  return InkWell(
                    onTap: (){
                      setState(() {
                        pageNo=index+1;
                      });
                    },
                    child: Container(

                      margin: EdgeInsets.symmetric(horizontal: 5),

                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: pageNo==index+1?Colors.orange:Colors.blue,borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Text("${index+1}",style: TextStyle(color: Colors.white),)),
                    ),
                  );

                }

            ),
            ElevatedButton(onPressed: (){
              setState(() {
                if(pageNo<5){
                  pageNo +=1;
                }
              });
            }, child: Text("Next")),


          ],
        ),
      ),

      Align(
        alignment: Alignment.centerRight,
        child: DropdownButton(

          dropdownColor: Colors.orange,
          iconEnabledColor: Colors.deepPurple,
          iconSize: 30,
          borderRadius: BorderRadius.circular(10),
          value:sortBy,

          items: [
            DropdownMenuItem(child: Text("PublishedAt",),value:"publishedAt"),
            DropdownMenuItem(child: Text("Relevancy"),value:"relevancy"),
            DropdownMenuItem(child: Text("Popularity"),value:"popularity"),
          ],
          onChanged: (value){

            setState(() {
              sortBy=value!;
            });
          },

        ),
      ),


      FutureBuilder<NewsModel>(
future: newsPorvider.getNewsData(pageNo,sortBy),
builder: (context, snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
  }
  else if(snapshot.hasError){
    return Text("Something wents wrong");
  }
  else if(snapshot.data==null){
    return Text(" Data are null");
  }

  return ListView.builder(
physics: BouncingScrollPhysics(),
    shrinkWrap: true,
      itemCount:snapshot.data!.articles!.length,
      itemBuilder: (context, index){
    return GestureDetector(
     onTap: (){
       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewsDetails(articles: snapshot.data!.articles![index],)));
     },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),

        height: 200,
        width: double.infinity,

        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.orange,style: BorderStyle.solid, width: 5)
        ),
child: Row(children: [

  Expanded(

      flex: 2,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
height: double.infinity,
child: CachedNetworkImage(

  imageUrl: "${snapshot.data!.articles![index].urlToImage}",
  progressIndicatorBuilder: (context, url, downloadProgress) =>
        Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
  errorWidget: (context, url, error) => Icon(Icons.image_not_supported),
fit: BoxFit.fill,

),
  decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10)
  ),

          ),
        )),
  Expanded(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("${snapshot.data!.articles![index].title}...\n", style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold),),
                  Text("Published: ${snapshot.data!.articles![index].publishedAt}",style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ),
        )),
],),

      ),
    );

  });

})

    ],

    ),
    ));
  }
}
