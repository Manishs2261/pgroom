import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

class DetailsRoom extends StatefulWidget {
  const DetailsRoom({super.key});

  @override
  State<DetailsRoom> createState() => _DetailsRoomState();
}

class _DetailsRoomState extends State<DetailsRoom> {

  final List<String> roomImages = [
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
  ];
  final List<String> items = ["AC", "COOLER", "FAN", "TABLE", "BED", "CHAIR","FRIDGE","LIGHT","WASHING MACHINE","BED SHEET","GIGER","ALMARI","LOCKER"];

final List<String> billItem = ['ELECTRICITY BILL','WATER BILL'];

final List<String> rules =[ "Available for Students & Working Professionals",
  "Non veg food is allowed",
  "Smoking is allowed",
  "Drinking is allowed",
  "Guardian is allowed",
  "Visitors are allowed",
  "Guests of opposite gender are allowed"];

  final List<Map<String, dynamic>> roomData = [
    {'type': 'Private room', 'price': 5000},
    {'type': 'Single room', 'price': 1000},
    {'type': 'Double room', 'price': -500},
  ];

  int currentPage = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text('Room name',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,

        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.share,color: Colors.black,))
        ],
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
              boxShadow: [

                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: Offset(0,1),
                  blurRadius: 2,
                  spreadRadius: 1,

                )
              ]
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                width: AppHelperFunction.screenWidth() * 0.4,
                height: 40,
                 padding: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8),

                ),
                child: Text('Chat Now'),
              ),
              Container(
                alignment: Alignment.center,
                height: 40,
                width: AppHelperFunction.screenWidth() * 0.4,
                padding: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 204, 102, 1.0),
                    borderRadius: BorderRadius.circular(8),

                ),
                child: Text('Call Now',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,

      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 16,top: 16,left: 16,bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              Container(
                height: 200,
                width: 400,// Set a fixed height for the PageView
                child: Stack(
                  children: [
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: roomImages.length,
                      onPageChanged: (int page) {
                        setState(() {
                          currentPage = page;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              imageUrl: roomImages[index],
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 16,
                      right: 4,
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          '${currentPage + 1}/ ${roomImages.length}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: false ? Icon(Icons.favorite ,color: Colors.red,) :Icon(Icons.favorite_border_outlined,color: Colors.white,)
                      ),
                    ),
                  ],
                ),
              ),
        
        
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
               Text("₹ 15,000/-", maxLines: 1,
                 overflow: TextOverflow.ellipsis,
                 style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(4),
                   color: Colors.blueAccent,
                 ),
                 child: Text(
                   'BOYS',
                   style: TextStyle(color: Colors.white, fontSize: 12),
                 ),
               ),
             ],),
              Text("Name of Room",maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
              SizedBox(height: 16,),
        
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/map_icon.png'),
                          ),
                        ),
                      ),
                      SizedBox(width: 8), // Add some spacing between the icon and text
                      Expanded( // Allow the column to take up the remaining space
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                          children: [
                            Text(
                              'Gour colony yadunandan nager tifra, Bilaspur, Chhattisgarh ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
        
                            SizedBox(height: 4,),
                            Text(
                              'View On Map',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16,),
        
              Text(
                'Overview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
        
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all()
                ),
                child: Column(
                  children: [
                    Column(
                      children:  roomData.map((room){
                        return   Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(room['type'],style: TextStyle(fontWeight: FontWeight.w500),),
                                Text('₹${room['price']}/-',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
        
                              ],
                            ),
                            Divider(),
                          ],
                        );
                      }).toList(),
        
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("One Time Security Deposit",style: TextStyle(fontSize: 14,color: Colors.grey),),
                        Text('₹5000/-',style: TextStyle(color: Colors.grey),),
        
                      ],
                    ),
                  ],
                ),
              ),
        
              SizedBox(height: 16,),
        
              Text(
                'Room Offering',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
        
          Card(
            color: Colors.white,
            elevation: 1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child:  Wrap(
                spacing: 10, // space between containers
                runSpacing: 10, // space between lines
                children: items
                    .map((item) => Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 14),
                  ),
                )
                )
                    .toList(),
              )
            ),
          ),



              SizedBox(height: 16,),

              Text(
                'Other Bills',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16,),
              Wrap(
                spacing: 10, // space between containers
                runSpacing: 10, // space between lines
                children: billItem.map((bill){

                  return   Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      bill,
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 16,),

              Text(
                'House Rules',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 16,),
              Column(
                children: rules.map((rule){

                  return  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_forward_rounded,color: Colors.greenAccent,size: 18,),
                        SizedBox(width: 8,),
                        Text(rule)
                      ],
                    ),
                  );
                }).toList()
              )
            ],
          ),
        ),
      ),
    );
  }
}
