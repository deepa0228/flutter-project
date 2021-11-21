import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myproject1/Utils.dart';



class DetailView extends StatefulWidget {

final String url;
final String imageId;
DetailView({Key key,@required this.url,@required this.imageId}):super(key:key);
  
  @override
  State<StatefulWidget> createState() => ImageDetail();
}

class ImageDetail extends State<DetailView>{

static const _kApiKey = "c76e1e57adbc81d208d5bdb9f9ecf3c90f1fad4ecb32572fb7ac9e870adaddce";
final String unsplashUrl = "https://api.unsplash.com/photos/";
ImageExifDetails imageExifdata;
final Color color = HexColor.fromHex('#1F1C2C');
final Color color1 = HexColor.fromHex('#928DAB');
@override
void initState()
{
  //_getImageData(unsplashUrl,widget.imageId);

 super.initState(); 
}
  
  @override
  Widget build(BuildContext context) {

    Size size =MediaQuery.of(context).size;
   

    return FutureBuilder(     
      

              future: _getImageData(unsplashUrl, widget.imageId),
              
              
              builder: (BuildContext context,AsyncSnapshot snapshot){

                if (snapshot.data == null)
                {
                  

                  return Container(
                    color: Color.alphaBlend(color, color1),
                    child: Center(
                      
                      child: new CircularProgressIndicator(backgroundColor: Colors.blue)),
                  );
                }
                else{

                  return new Column( 
                  children:<Widget>[             

                SizedBox(

                height: size.height * 0.8,
                
                child: Row(
                    children: <Widget>[

                      Expanded(
                      
                        child: Padding(

                          padding: const EdgeInsets.symmetric(vertical : 40.0),

                          child: Column(

                            children: <Widget>[                                                 

                              Align(                              
                                  alignment: Alignment.topLeft,
                                   child: Padding(
                                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                     child: GestureDetector(

                                       onTap:(){
                                         goback();
                                       } ,                                       
                                        child: ImageIcon(  
                                         
                                        AssetImage("assets/images/backarrow.png"),
                                        color: Colors.white,
                                        ),
                                     ),
                                   ),
                                ),
                              
                              Spacer(),

                              ItemCard(icon: "assets/images/camera.png",picInfo: imageExifdata.make) , 
                               Spacer(),
                              ItemCard(icon: "assets/images/isoicon.png",picInfo: "ISO-"+imageExifdata.iso) ,  
                               Spacer(), 
                              ItemCard(icon: "assets/images/lens.png",picInfo: imageExifdata.focal_length) , 
                               Spacer(),  
                              ItemCard(icon: "assets/images/shutterspeed.png",picInfo: imageExifdata.exposure_time) ,   
                               Spacer(),
                              ItemCard(icon: "assets/images/aperture.png",picInfo: "f-"+imageExifdata.aperture) ,                            

                            ],

                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.75,
                        height: size.height * 0.7,
                        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(63),bottomLeft: Radius.circular(63)),
                          boxShadow: [BoxShadow(
                              blurRadius: 60,
                              offset: Offset(0, 10),
                              color: Colors.amber.withOpacity(0.29)
                          )],

                          image: DecorationImage(
                          image:NetworkImage(widget.url),fit: 
                          BoxFit.fill,
                          alignment: Alignment.centerLeft)),
                      )
                    ],

                ),
              )
            ]

                  );

                }

            
            });
  
                
  }

  void goback()
  {

    Navigator.pop(context);

  }

// Receive image data from a given [url] and return the JSON decoded the data.
Future<ImageExifDetails> _getImageData(String imageUrl,String id) async {
      // pass the client_id in the header
    var response = await http.get(

         Uri.encodeFull(imageUrl+id.toString()),
         headers: {"Accept": "application/json","Authorization" : "Client-ID $_kApiKey"}
       );
     
      var convertedData = json.decode(response.body) ;
      String camName = convertedData["exif"]["make"] ?? "--";
      String shutter = convertedData["exif"]["exposure_time"]?? "--";
      int iso = convertedData["exif"]["iso"]?? 0;
      String isoval = iso.toString() ;
      String apert = convertedData["exif"]["aperture"]?? "--";
      String focal = convertedData["exif"]["focal_length"]?? "--";
      //String camModel = convertedData["exif"]["model"];
      imageExifdata=ImageExifDetails(camName, apert, shutter, isoval, focal);
      return imageExifdata;
     
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key key, this.icon,this.picInfo
   
  }) : super(key: key);

  final String icon;
  final String picInfo;

  @override
  Widget build(BuildContext context) {
      Size size =MediaQuery.of(context).size;

    return Container(

      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: size.height*0.003),

        height: 72.0,
        width: 72.0,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),

          boxShadow: [BoxShadow(

            blurRadius: 22,
            color: Colors.deepOrange.withOpacity(0.55),
            offset: Offset(0, 10)

            ),
            BoxShadow(
              color: Colors.deepOrange.withOpacity(0.22),
              blurRadius: 20,
              offset: Offset(-15, -15)
            ) 
          ] 
        ),
        
        child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children : <Widget>[
                ImageIcon( 
            
                 
                AssetImage(icon),

                color: Colors.deepPurple,
                
                ),

                Spacer(),

                Flexible(

                  child: Center(child: new Text(picInfo,style: new TextStyle(fontSize: 13),)),
                )
            ]
        ), 


    );
  }
}

class ImageExifDetails{

 String make="test";
 String aperture="test";
 String exposure_time="test";
 String iso="test";
 String focal_length="test";

 ImageExifDetails(this.make,this.aperture,this.exposure_time,this.iso,this.focal_length);





}
