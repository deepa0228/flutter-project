
import 'package:flutter/material.dart';
import 'package:myproject1/Categories.dart';
import 'package:myproject1/SplashScreen.dart';
import 'package:myproject1/Utils.dart';
import 'Trending.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
void main() {
  runApp(HomePage());
  }


  
  class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomeStateWidget();

}
class HomeStateWidget extends State<HomePage>{

 int _page = 0;

  GlobalKey _bottomNavigationKey = GlobalKey();
    final List pages = [
   
        Trending() ,
        Categories() ,
        SplashScreen(),
    ];
      @override
      Widget build(BuildContext context) {
    
        return new MaterialApp(
          debugShowCheckedModeBanner: false,

         

           home: new Scaffold(
            
           backgroundColor: Color.alphaBlend(Utils.color, Utils.color1),

             bottomNavigationBar: CurvedNavigationBar(
               backgroundColor: Colors.black12 ,
               color: Colors.grey,
                key: _bottomNavigationKey,
               animationCurve: Curves.fastOutSlowIn,
                items: <Widget>[
                  Icon(Icons.add, size: 30),
                  Icon(Icons.list, size: 30),
                  Icon(Icons.compare_arrows, size: 30)
                 
                ],
                onTap: (index) {
                  setState(() {
                    _page = index;                    
                  });
                },
                  
              ),
              
              body: pages[_page],    

           )
          
        );
      }
}
        
    
