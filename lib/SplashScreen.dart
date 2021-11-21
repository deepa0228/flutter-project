import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:myproject1/Categories.dart';
import 'main.dart';


class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Splash();

}

class Splash extends State<SplashScreen> {

  @override
  void initState()
  {
    super.initState();

  }

  
 
  @override
  Widget build(BuildContext context) {

    Timer(
      Duration(seconds: 5),
          () =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => HomePage())
          )
          );


    return  MaterialApp(

          home: new Scaffold(
            appBar: AppBar(),
             
                  body: Container(
                          child: Center(
                              child: FadeAnimatedTextKit(
                               
                                  onTap: () {
                                      print("Tap Event");
                                    },
                                  text: [
                                    "do IT!",
                                    "do it RIGHT!!",
                                    "do it RIGHT NOW!!!"
                                  ],
                                  textStyle: TextStyle(
                                      fontSize: 32.0, 
                                      fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                  alignment: AlignmentDirectional.center // or Alignment.topLeft
                                ),
                              ),
                         
                
                  ), 
                      ),

            

      
        
          
    );
   
  }
  
}



 
  
