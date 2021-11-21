
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Collections.dart';

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(4, 1),
];

List<Widget> _tiles = const <Widget>[
  const _Example01Tile(Colors.green, Icons.widgets),
  const _Example01Tile(Colors.lightBlue, Icons.wifi),
  const _Example01Tile(Colors.amber, Icons.panorama_wide_angle),
  const _Example01Tile(Colors.brown, Icons.map),
  const _Example01Tile(Colors.deepOrange, Icons.send),
  const _Example01Tile(Colors.indigo, Icons.airline_seat_flat),
  const _Example01Tile(Colors.red, Icons.bluetooth),
  const _Example01Tile(Colors.pink, Icons.battery_alert),
  const _Example01Tile(Colors.purple, Icons.desktop_windows),
  const _Example01Tile(Colors.blue, Icons.radio),
];
class Categories extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {

    return new CategoryWidget ();
    
  }


}

  class CategoryWidget extends State<Categories>{

  static const _kApiKey = "c76e1e57adbc81d208d5bdb9f9ecf3c90f1fad4ecb32572fb7ac9e870adaddce";
  final String unsplashUrl = "https://api.unsplash.com/collections/";

  List<CollectionPhotos>collectionPhotos = new List<CollectionPhotos>();
    List<Users>usersList = new List<Users>();

     final List<int> numbers = [1, 2, 3, 5, 8, 13, 21, 34, 55];

    ScrollController _scrollController=new ScrollController();
      @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      print("scroll");
    });
  }

    void gotoCollectionsPage(String collectionId) {

     Navigator.push(context, MaterialPageRoute(builder: (context)=>Collections(collectionId: collectionId)));
  }
// Receive image data from a given [url] and return the JSON decoded the data.
Future<List<CollectionPhotos>> getCollections() async {

  if (collectionPhotos.length==0)
  {

  
      // pass the client_id in the header
    var response = await http.get(

         Uri.encodeFull(unsplashUrl.toString()),
         headers: {"Accept": "application/json","Authorization" : "Client-ID $_kApiKey"}
       );
     
      var convertedData = json.decode(response.body) as List;

      for(int i = 0;i<convertedData.length;i++)
      {
      String title = convertedData[i]["title"]?? "--";
      int totalPhotos = convertedData[i]["total_photos"]?? 0;
      String imageUrl = convertedData[i]["cover_photo"]["urls"]["small"]?? 0;
      int id = convertedData[i]["id"]?? 0;
      //String camModel = convertedData["exif"]["model"];
      CollectionPhotos collectionPhoto =CollectionPhotos(title, totalPhotos.toString(), imageUrl,id.toString());
      collectionPhotos.add(collectionPhoto);

      }

  }
      return collectionPhotos;
     
  }


Future<List<Users>> getUserInfo() async {

  if (usersList.length==0)
  {

  
    // pass the client_id in the header
    var response = await http.get(

         Uri.encodeFull(unsplashUrl.toString()),
         headers: {"Accept": "application/json","Authorization" : "Client-ID $_kApiKey"}
       );
     
      var convertedData = json.decode(response.body) as List;

       for(int i = 0;i<convertedData.length;i++)
      {
    

      String name = convertedData[i]["user"]["first_name"]?? "--";
      String profileImageUrl = convertedData[i]["user"]["profile_image"]["medium"]?? "--";
      int totalCollections = convertedData[i]["user"]["total_collections"]?? 0;
      
      //String camModel = convertedData["exif"]["model"];
      Users user =Users(name, profileImageUrl, totalCollections.toString());
      usersList.add(user);
      }
  }

  return usersList;

}


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
       // backgroundColor: Colors.purpleAccent,
    body: Column(

      children: <Widget>[

       Container(
         margin: EdgeInsets.only(top:40),
                child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
                      child: Card(
              elevation: 10.0, 
                  child: TextField(
                
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueAccent,
                  ),
                  decoration: InputDecoration(
                    
                      contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0,20.0),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Sarch for photos and photographers",
                      // border: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.blueAccent, width: 16.0),
                      //     borderRadius: BorderRadius.circular(20.0)),
                      // focusedBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.white, width: 16.0),
                      //     borderRadius: BorderRadius.circular(20.0)))),
                    ),),
            ),
          ),
      ),
       ),

        Container(
       
          alignment: Alignment.topLeft,
          margin: new EdgeInsets.fromLTRB(10,10,10,10),
          child: new Text("Popular Photographers",style: TextStyle(fontSize: 20.0,fontWeight:  FontWeight.bold ))      ),

           FutureBuilder(

                  future: getUserInfo(),
              builder: ((BuildContext context,AsyncSnapshot snapshot){

                  if (snapshot.data==null)
                  {
                      return new Center(
                        
                           
                          child: new CircularProgressIndicator(),

                      );

                  }
                  else{

                        return new Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                            height: MediaQuery.of(context).size.height * 0.2, 
                            child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                              itemCount: usersList.length, itemBuilder: (context, index) {
                                return Column(

                                  children: <Widget> [

                                    Padding(
                                      padding: EdgeInsets.all(10),
                                    
                                      child: CircleAvatar(   
                                                                        
                                      radius: 35,
                                      backgroundImage: new NetworkImage(
                                       usersList[index].profileImgeUrl)
                            
         
                                      ),
                                  ),

                                  Container(child: new Text(usersList[index].name),)

                                  ],
                                                                   
                                ); 
                
                    }
                    ),
                  );

                  }

            }),
                         
              
            ),
         
            Container(

                  alignment: Alignment.topLeft,
                  margin: new EdgeInsets.all(10),
                  child: new Text("Collections",style: TextStyle(fontSize: 20.0,fontWeight:  FontWeight.bold ))      

            ),
           
            FutureBuilder(
                  future: getCollections(),
              builder: ((BuildContext context,AsyncSnapshot snapshot){

                  if (snapshot.data==null)
                  {
                      return new Center(


                         child: new CircularProgressIndicator(),

                      );

                  }
                  else{

                        return new   Expanded(
                      child:  sliverGridWidget(context),
                  );

                  }

            }),
                         
              
            )
            // Expanded(
            //           child:  sliverGridWidget(context),
            //       ),
            

          
        ],
      ),
        
        
      );
        
  }
    
    Widget sliverGridWidget(BuildContext context){
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: 4,
        itemCount: collectionPhotos.length, //staticData.length,
        itemBuilder: (context, index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
                child: Card(
              elevation: 16.0,
              shadowColor: Colors.black,
            
               child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: GestureDetector(

                              child: Image.network(
                       collectionPhotos[index].coverImageUrl,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,

                        
                   
                        fit: BoxFit.cover,
                      ),
                      onTap:(){ 
                        gotoCollectionsPage(collectionPhotos[index].collectionId);} 
                    ),
                    
                  ),
                       Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(20),
                      child: Text(
                        collectionPhotos[index].collectionTitle,
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0),
                      )),
                  Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.all(20),
                      child: Text(
                        collectionPhotos[index].totalPhots+" Photos",
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0),
                      )),
                ],
              ),
              // child:InkWell(
              //  child: Hero(
              //    tag: index,
              //    child: new FadeInImage(
              //      fadeInCurve: Curves.easeInSine,
              //      width: MediaQuery.of(context).size.width,
              //      image: NetworkImage(collectionPhotos[index].coverImageUrl), // NetworkImage(staticData[index].images),
              //      fit: BoxFit.cover,
              //      placeholder: AssetImage("assets/images/im1.jpg"),
              //    ),
              //  ),
              //  onTap: (){
              //    //
              //   }
              // )
            ),
          );
        },
         staggeredTileBuilder: (index) => StaggeredTile.count(2,index.isEven ? 2: 3),
         mainAxisSpacing: 8.0,
         crossAxisSpacing: 8.0,
      );
  }


    
  
  
}

class CollectionPhotos {

String collectionTitle;
 String totalPhots;
 String coverImageUrl;
 String collectionId;

 CollectionPhotos(this.collectionTitle,this.totalPhots,this.coverImageUrl,this.collectionId);

}

class Users {

 String name;
 String profileImgeUrl;
 String collectionsCount;

 Users(this.name,this.profileImgeUrl,this.collectionsCount);

}
class _Example01Tile extends StatelessWidget {
  const _Example01Tile(this.backgroundColor, this.iconData);

  final Color backgroundColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap: () {},
        child: new Center(
          child: new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Icon(
              iconData,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}




