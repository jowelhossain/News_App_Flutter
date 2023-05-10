
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news_app/http/custom_http.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/screen/news_datails.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  NewsModel?newsModel;
  TextEditingController searchController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(

          child: Container(
            padding: EdgeInsets.all(20),
            child:Column(
              children: [
                Align(alignment:Alignment.centerLeft ,child: IconButton(onPressed:(){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.blue,))),
                SizedBox(height: 5,),
                TextField(
                  keyboardType: TextInputType.text,
                  onEditingComplete:()async{
                    newsModel = await CustomHttpRequest.searchNewsData(searchController.text);
                    setState(() {

                    });
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(onPressed: (){
                      searchController.clear();
                      newsModel!.articles!.clear();
                      setState(() {

                      });
                    }, icon: Icon(Icons.cancel_outlined),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue)
                    ),

                )
                ),
            SizedBox(height: 20,),

            MasonryGridView.count(

              shrinkWrap: true,
              itemCount: searchKeyword.length,
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(5),
                  child: Center(child: Text("${searchKeyword[index]}")),
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green)
                  ),
                );
              },
            ),
                SizedBox(height: 20,),

               newsModel?.articles==null?SizedBox():ListView.builder(
                   physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true, itemCount: newsModel!.articles!.length,
                itemBuilder: (context,index){

      return GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewsDetails(articles: newsModel!.articles![index],)));
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

                        imageUrl: "${newsModel!.articles![index].urlToImage}",
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
                            Text("${newsModel!.articles![index].title}...\n", style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold),),
                            Text("Published: ${newsModel!.articles![index].publishedAt}",style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                    ),
                  )),
            ],),

          ),
      );
    }

)

              ],
            ) ,
          ),
        ),
      ),
    );
  }
}

List<String>searchKeyword=[
  "International","Politics","Sports","Entertainment", "Football", "Cricket", "Bitcoin"

];
