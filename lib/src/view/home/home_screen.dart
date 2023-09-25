import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';
import 'package:pgroom/src/view/add_your_home/add_your_home.dart';
import 'package:pgroom/src/view/login_screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize:Size.fromHeight(100),
        child: AppBar(
          title: Text("Home"),
        ),

      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  boxShadow: [BoxShadow(
                     blurRadius: 3,
                    blurStyle: BlurStyle.outer,
                    offset: Offset.zero,

                  )]
                ),
                child: Container(
                  child: Row(
                    children: [
                      CircleAvatar(maxRadius: 30,child: Icon(Icons.person,size: 35,),),
                      SizedBox(width: 15,),
                      Flexible(
                        child: Text("Manish sahu ",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                            maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.login),
              trailing: Icon(Icons.arrow_forward_ios,size: 16,),
              title: const Text('Login'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                print("login");
                // Update the state of the app.
               // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Profile'),
              trailing: Icon(Icons.arrow_forward_ios,size: 16,),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text('Add Your Room'),
              trailing: Icon(Icons.arrow_forward_ios,size: 16,),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddYourHome()));
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),

      body: ListView.builder(
        
        padding: EdgeInsets.only(left: 5,right: 5),
        itemCount:12,
          itemBuilder: (context,index){
            return Stack(
              children: [
            Container(
            padding: EdgeInsets.all(3),
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
            color: Colors.blue.shade100,
            boxShadow: [
            BoxShadow(
            color: Colors.white,
            spreadRadius: 3,

            )
            ]
            ),
            child: Row(
            children: [

            //====== front image========
            Image(
            image: AssetImage(roomImage),
            height: 300,
            width: 150,
            fit: BoxFit.cover,),

            SizedBox(width: 10,),
            // =====Details ============

            Expanded(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Flexible(
            child: Text("House Name ",
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 1,
            style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
            ),
            ),
            SizedBox(height: 5,),
            Row(
            children: [
            Icon(Icons.star,color: Colors.yellow,size: 17,),
            Text("4.4"),
            Text(" (28 reviews)")
            ],
            ),
            SizedBox(height: 5,),
            RichText(
            text: TextSpan(
            text: 'Rent - ₹',
            style: DefaultTextStyle.of(context).style,
            children: const <TextSpan>[
            TextSpan(text: '2000', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' /- montly'),
            ],
            ),
            ),
            SizedBox(height: 5,),
            Flexible(
            child: Text("Gour colony yadunadan nager tifra, near popur popular shop , Bilaspur ",
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 2,

            ),
            ),
            SizedBox(height: 3,),
            Text("city - Bilaspur"),
            Text("Room Type - single and shareable")




            ],
            ),
            )

            ],
            ),
            ),
                
                Positioned(
                  top: 10,
                    left: 10,
                    child: Icon( CupertinoIcons.heart,color: Colors.white,))
              ],
            );
          }),
    );
  }
}
