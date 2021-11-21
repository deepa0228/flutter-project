import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:myproject1/Utils.dart';
import 'Categories.dart';
import 'DetailView.dart';
  
 
  class Trending extends StatefulWidget{

 

  @override
  State<StatefulWidget> createState() {
   
    return new TrendingStateWidget();
    
  }


}
class TrendingStateWidget extends State<Trending> with AutomaticKeepAliveClientMixin<Trending>{

 int page = 1;
  ScrollController _sc = new ScrollController();
static const _kApiKey = "c76e1e57adbc81d208d5bdb9f9ecf3c90f1fad4ecb32572fb7ac9e870adaddce";
final String unsplashUrl = "https://api.unsplash.com/photos?page=";
 Map<String, dynamic> source;
 List images = new List();
 List<dynamic> data ;
 List<String>imageUrls = List<String>();

 List<ModelImage>imageModelList = new List<ModelImage>();

 bool isLoading = false;

///final Color color = HexColor.fromHex('#333333');
//final Color color1 = HexColor.fromHex('#dd1818');


  @override void initState() {

    this.getLatestImages(page);
    super.initState();    
    print(page);
    _sc.addListener(() {
      if (_sc.position.pixels ==
          _sc.position.maxScrollExtent) {
            print(page);
        getLatestImages(page);
      }
    });
    }

  
@override void dispose() {
    _sc.dispose();
    super.dispose();
  }

  void gotoDetailPage(String imagePath,String id)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailView(url:imagePath,imageId: id)));
  }

  void getLatestImages(int pageNumber) async {

            // if (!isLoading) {
            //       setState(() {
            //         isLoading = true;
            //       });
       var response = await http.get(

         Uri.encodeFull(unsplashUrl+pageNumber.toString()),
         headers: {"Accept": "application/json","Authorization" : "Client-ID $_kApiKey"}

       );
         //print(response.body);
         setState(() {
           var convertedData = json.decode(response.body) as List;
           data = convertedData ;
           for (var i = 0; i < data.length;i++) {
            // print(data[i]["urls"]);
               imageUrls.add(data[i]["urls"]["small"]); 
               ModelImage modelImage = new ModelImage(data[i]["id"]);
               imageModelList.add(modelImage);
             

           }
          page++;
         
         });

         //return "Success";

      }
      @override
      Widget build(BuildContext context) {
        super.build(context);
    
        return new MaterialApp(
        
          debugShowCheckedModeBanner: false,
          home: new Scaffold(
           
            //backgroundColor: Colors.deepPurple.withOpacity(0.7),
            backgroundColor: Color.alphaBlend(Utils.color, Utils.color1),
    
            appBar: new AppBar(
    
            
             elevation: 0,
             backgroundColor: Colors.transparent,
              actions: <Widget>[

                Container(
                  margin: EdgeInsets.only(top:20,left:40),
                  child: FloatingActionButton(
                    

                    backgroundColor:Colors.white,

                    child: IconButton(
                      icon: Icon(
                        Icons.filter_list  ,
                        color: Colors.black,
                        ),
                    
                    onPressed: null )
                    ,
                    
      onPressed: () {
        // do something
      },
    ),
                )
  ],
            
            ),
extendBodyBehindAppBar: true,
           body: new ListView.builder(            
             
            itemCount: imageUrls == null ? 0 : imageUrls.length+1,

             itemBuilder: (BuildContext buildContext , int itemCount)
             {              
                 if (itemCount == imageUrls.length) 
                 {
                 return _buildProgressIndicator();
              }  
              else
              {        
                return new Container(    
                              decoration: BoxDecoration(
                  //gradient: LinearGradient(
                  // colors: [color, color1])
                ),         
              
          child: new Stack(            
            //alignment:new Alignment(x, y)
            children: <Widget>[

                  new Center(

                  child: new Column(
                    crossAxisAlignment : CrossAxisAlignment.stretch,
                    children: <Widget>[  

                    

                       ClipPath(                       
                               child: new Container(                                   
                                decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(55.0),
                                boxShadow: [
                                  new BoxShadow(
                                    blurRadius: 5.0,
                                    
                                    color: Colors.transparent
                                  )
                                ]
                              ),
                          
                                child: new Container( 

                                  //decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50))),
                                   
                                  child:GestureDetector( 

                                    child: new Image.network(imageUrls[itemCount], fit: BoxFit.fitWidth , loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                    
                                    
                                    if (loadingProgress == null) return child;
                                      return Center(
                                        
                                        child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null ? 
                                              loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                              : null,
                                        ),
                                       
                                      );
                                    
                                      
                                    },
                                    
                                  
                                    ),
                                      onTap:()
                                    {
                                        gotoDetailPage(imageUrls[itemCount],imageModelList[itemCount].id); 
                                        
                                    }                               

                                  )  
                                ),   
                                                        
                              // child: new Text("Hello World"),
                               padding: const EdgeInsets.all(20.0),
                               
                             ),

                       ),
                     
                    ]
    
                    
                    
                  ) ,
    
    
    
                 )


            ]
              
          ),
           
          );
          }
          } ,
           controller: _sc,
           )
    
          ),
        
        );
    
      }
    
     Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  
  bool get wantKeepAlive => true;


  

}


  


class ModelImage {

String id ;

ModelImage(this.id);

  
}


