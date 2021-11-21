import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:myproject1/Utils.dart';


class Collections extends StatefulWidget {

final String collectionId;

Collections({Key key,@required this.collectionId}):super(key:key);
  
  @override
  State<StatefulWidget> createState() => CollectionPage();
  }
  
  class CollectionPage extends State<Collections> {

List<ImageCollection> imageList =new List<ImageCollection>();

  @override
  Widget build(BuildContext context) {

    return new Container(

        //color: Color.alphaBlend(Utils.color, Utils.color1),

        child: FutureBuilder( 
          
          future: getAllCollectionImages(widget.collectionId),

          builder: (BuildContext context ,AsyncSnapshot snapshot){
            if (snapshot.data == null)
                {
                  

                  return Container(
                    color: Color.alphaBlend(Utils.color, Utils.color1),
                    child: Center(
                      
                      child: new CircularProgressIndicator(backgroundColor: Colors.blue)),
                  );
                }
                else{

                    return new ListView.builder(

                      
                      itemCount: imageList == null ? 0 : imageList.length,
                      
                      itemBuilder:(BuildContext context ,  int itemCount)
                    {

                      return new Card(
                        
                        elevation: 10,
                        shadowColor: Colors.teal,
                        child: Image.network(imageList[itemCount].imageUrl),                      


                      );
                      



                    },
                    );

                }


          }

        ,),


    );



   
   
  }

// Receive image data from a given [url] and return the JSON decoded the data.
Future <List<ImageCollection>> getAllCollectionImages(String id) async {

      String key = Utils.kApiKey;
      ImageCollection imageData;
      
      // pass the client_id in the header
    var response = await http.get(

         Uri.encodeFull(Utils.collectionIdUrl+id+"/photos?"),
         
         headers: {"Accept": "application/json","Authorization" : "Client-ID $key"}
       );
     
      var convertedData = json.decode(response.body) as List;
      for(int i=0;i<convertedData.length;i++)
      {
      String id = convertedData[i]["id"]?? "--";
      String imagePath = convertedData[i]["urls"]["small"]?? "--";
      String profileImage = convertedData[i]["user"]["profile_image"]["small"]?? "--";
     
      //String camModel = convertedData["exif"]["model"];
      imageData=ImageCollection(id, imagePath, profileImage);
      imageList.add(imageData);
      }
  
      return imageList;
     
  }
    
}

class ImageCollection {

  String imageUrl;
  String userImageUrl;
  String imageId;

  ImageCollection(this.imageId,this.imageUrl,this.userImageUrl);


}