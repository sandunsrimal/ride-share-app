import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Utils/next_screen.dart';
import 'balance.dart';
import 'ongoingrides.dart';

class CompleteRide extends StatefulWidget {

  int rideId;
  String price;
  String? dpNum;
   CompleteRide({super.key , required this.rideId, required this.price, required this.dpNum});

  @override
  State<CompleteRide> createState() => _CompleteRideState();
}

class _CompleteRideState extends State<CompleteRide> {

    double _rating = 0;
    bool loading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(

            top: 50,
            left: 20,
            
            child: IconButton(icon: Icon(Icons.close, color: Colors.black, size: 30,), 
          
          onPressed: (){
            Navigator.of(context).pop();
          },)),
          Column(
            children: [
              SizedBox(height: 100,),
              Image.asset("assets/images/check.png", scale: 3.5,),
              SizedBox(height: 20,),
                  Container(
          child: Center(child: Text('Ride Completed!', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
        ),
                  Container(
          child: Center(child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit,  ',)),
        ),
        SizedBox(height: 20,),
                Container(
          child: Center(child: Text('Rs. ${widget.price}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
        ),
        SizedBox(height: 20,),
        Container(
                        padding: const EdgeInsets.only(top: 15),
                         child:  CircleAvatar(
                                             radius: 40,
                                             backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/ride-share-app-fa1ab.appspot.com/o/man-2.png?alt=media&token=b14bd4ee-b3b4-4935-aeb5-c72ce654b410&_gl=1*1hgtj3f*_ga*Njg4MTQ5ODY0LjE2ODYxMzc3NTU.*_ga_CW55HF8NVT*MTY5NjE0MDMyMS40Mi4xLjE2OTYxNDEwNjcuMjYuMC4w'),
                                           ),

                       ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text("John Doe", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        ),

         Container(
            margin: EdgeInsets.all( 30),
           child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                _rating = rating;
                              });
                            },
                          ),
                          Text("${_rating.toString()}  out of 5"),
                        ],
                      ),

                      
         ),
       
         Container(
            margin: EdgeInsets.only( left: 30, right: 30),
           child: SizedBox(
           height: 150, //     <-- TextField expands to this height. 
           child: TextField(
             maxLines: null, // Set this 
             expands: true, // and this
             keyboardType: TextInputType.multiline,
           ),
         ),
         ),
           SizedBox(height: 20,),

  SizedBox(
                                      width: 150,
                                      height: 40,
                                      child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              gradient: const LinearGradient(colors: [
                                                Colors.orange,
                                                Colors.red,
                    
                                                //add more colors
                                              ]),
                                              borderRadius: BorderRadius.circular(25),
                                              boxShadow: const <BoxShadow>[
                                                BoxShadow(
                                                    color: Color.fromRGBO(0, 0, 0,
                                                        0.57), //shadow for button
                                                    blurRadius:
                                                        5) //blur radius of shadow
                                              ]),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.transparent,
                                              disabledForegroundColor:
                                                  Colors.transparent.withOpacity(0.38),
                                              disabledBackgroundColor:
                                                  Colors.transparent.withOpacity(0.12),
                                              shadowColor: Colors.transparent,
                                              //make color or elevated button transparent
                                            ),
                                            onPressed: () async {
                                              
                                               setState(() {
                              loading=true;
                            });
                                            },
                           
                                            child: loading ? const CircularProgressIndicator()
                                            : const Text(
                                              "Submit",
                                              style: TextStyle(fontSize: 15, color: Colors.white),
                                            ),
                                          )),
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(onPressed: () {

                                     nextScreen(context, BalanceScreen(widget.dpNum!));
                                        

                                    }, 
                                    child: Text("Go to Wallet", style: TextStyle(color: Colors.orange),)),
                                        TextButton(onPressed: () {

                                          Navigator.pop(context);
                                           Navigator.pop(context);
                                            Navigator.pop(context);
                                            

                                        }, 
                                        child: Text("Skip", style: TextStyle(color: Colors.orange),)),
                                      ],
                                    ),
 
            ],
          ),
      
        ],
       
      )
    );
  }
}