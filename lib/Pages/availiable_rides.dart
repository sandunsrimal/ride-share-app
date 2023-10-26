import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rideshareapp/Pages/viewroute.dart';

import '../Service/Driver.dart';
import '../Service/Rides.dart';
import '../Service/riderequest.dart';
import '../Utils/next_screen.dart';
import '../Widget/splash_service.dart';
import 'empty.dart';


class AvailiableRides extends StatefulWidget {

  double? fromlatitude;
  double? fromlongitude;
  double? tolatitude;
  double? tolongitude;
  String? phonenumber;
  int? passengers;
  AvailiableRides({super.key, required this.fromlatitude, required this.fromlongitude, required this.tolatitude, required this.tolongitude, required this.phonenumber, required this.passengers});
 

  @override
  State<AvailiableRides> createState() => _AvailiableRidesState();
}

class _AvailiableRidesState extends State<AvailiableRides> {
  bool loading = false;
  ScrollController? controller;
   DocumentSnapshot? _lastVisible;
  bool? _isLoading;
  int i=1;
  String? result;
  List<DocumentSnapshot> _snap = [];
  List<Rides> _data = [];
  bool? _hasData;

    @override
  void initState() {
  
    controller = new ScrollController()..addListener(_scrollListener);
    super.initState();
    _isLoading = true;

    _getData();
  }

    void _scrollListener() {
    if (!_isLoading!) {
      if (controller!.position.pixels == controller!.position.maxScrollExtent) {
        setState(() => _isLoading = true);
        _getData();
      }
    }
  }
//do calculations here
 Future<Null> _getData() async {
    setState(() => _hasData = true);
    QuerySnapshot data;

    if (_lastVisible == null) {
      data = await firestore
          .collection('rides')
        //  .where('latitude', isGreaterThanOrEqualTo: null)

          //  .orderBy('latitude', descending: false)
         //    .limit(10)
          .get();
    } else {
      data = await firestore
          .collection('rides')
       //   .where('latitude', isGreaterThanOrEqualTo: null)

          // .orderBy('latitude', descending: false)
       //   .startAfter([_lastVisible!['latitude']])
            .limit(0)
          .get();
    }
// print(data.docs.length);

    if (data.docs.length > 0) {
      _lastVisible = data.docs[data.docs.length - 1];
      if (mounted) {
        setState(() {
          _isLoading = false;
          _snap.addAll(data.docs);
          _data = _snap.map((e) => Rides.fromFirestore(e)).toList();
        });
      }
    } else {
      if (_lastVisible == null) {
        setState(() {
          _isLoading = false;
          _hasData = false;
          print('no items');
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasData = true;
          print('no more items');
        });
      }
    }
    return null;
  }

   onRefresh() {
    setState(() {
      _snap.clear();
      _data.clear();
      _isLoading = true;
      _lastVisible = null;
      i=1;
    });
    _getData();
  }
//calculate distance between two points
  double calculateDistance(lat1, lon1, lat2, lon2) {
    double p = 0.017453292519943295;
    double a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
// print(lat1);
// print(lat2);
// print(lon1);
// print(lon2);
    // print(lat1);
    // print(lat2);
    // print(lon1);
// print(lon2);
    return 12742 * asin(sqrt(a));
  }

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:  Column(
        children: [
           Container(
    alignment: Alignment.topCenter,
    child: Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red,
                      Colors.orange,
                    ],
                  ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50 ),bottomRight: Radius.circular(50)),
      ),
      child:    Stack(
        children: [
          Positioned(
            top: 30,
            left: 15,
            child: Container(
            margin: const EdgeInsets.only(top: 20,left: 10),
            child: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios , color: Colors.white,),
            iconSize: 20,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ),),
             Container(
                        margin: const EdgeInsets.only(bottom: 20),
          alignment: Alignment.bottomCenter,
                       child: const Text("Recommended Rides",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
      
        ])
      
 
    )
   ),
          Expanded(
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height * 0.85,
                    //     padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                 
                    child: RefreshIndicator(
                      child: CustomScrollView(
                        controller: controller,
                        slivers: <Widget>[
                          _hasData == false
                              ? SliverFillRemaining(
                                  child: Container(
                                  padding: const EdgeInsets.only(top: 25),
                                  decoration: const BoxDecoration(
                                      color: Color(0xffffffff),
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(40),
                                      )),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height *
                                            0.30,
                                      ),
                                      const EmptyPage(
                                          icon: Icons.hourglass_empty,
                                          message: 'no rides found',
                                          message1: ''),
                                    ],
                                  ),
                                ))
                              : SliverPadding(
                                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                                  sliver: SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        if (index < _data.length) {

                                    //      return Listitems();
                                          if (calculateDistance(
                                            
                                                  widget.fromlatitude,
                                                  widget.fromlongitude,
                                                  _data[index].from_latitude,
                                                  _data[index].from_longitude) <=
                                              5 &&  calculateDistance(
                                            
                                                  widget.tolatitude,
                                                  widget.tolongitude,
                                                  _data[index].to_latitude,
                                                  _data[index].to_longitude) <= 5) {
                                                i++;

                                                print(calculateDistance(
                                                  widget.fromlatitude,
                                                  widget.fromlongitude,
                                                  _data[index].from_latitude,
                                                  _data[index].from_longitude));

                                                return Listitems(rides: _data[index], afromlatitude: widget.fromlatitude,   afromlongitude: widget.fromlongitude, atolatitude: widget.tolatitude, atolongitude: widget.tolongitude, aphonenumber: widget.phonenumber, apassengers: widget.passengers,);
                                            // return _ListItem(
                                            //   d: _data[index],
                                            //   tag:
                                            //       '${_data[index].timestamp}$index',
                                            // );
                                          }
                                          
                                        } else {

                                            if(i==1){
                                              i++;
                                               return Container(
                                                padding: const EdgeInsets.only(top: 250),
                                                 child: const EmptyPage(
                                                                                         icon: Icons.nordic_walking_rounded,
                                                                                         message: 'No rides found',
                                                                                         message1: ''),
                                               );

                                            }

                                        }
                                        return Opacity(
                                          opacity: _isLoading! ? 1.0 : 0.0,
                                          child: _lastVisible == null
                                              ? Column(
                                                  children: const [
                                              
                                                  ],
                                                )
                                              : const Center(
                                            
                                                  ),
                                        );
                                      },
                                      childCount:
                                          _data.length == 0 ? 5 : _data.length + 1,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      onRefresh: () async => onRefresh(),
                    ),
                  ),
        ],
      ),
    );
  //   return Scaffold(
     
  //     body: Column(
  //       children: [
  //           Container(
  //   alignment: Alignment.topCenter,
  //   child: Container(
  //     height: 120,
  //     width: MediaQuery.of(context).size.width,
  //     decoration: const BoxDecoration(
  //       gradient: LinearGradient(
  //                   begin: Alignment.topRight,
  //                   end: Alignment.bottomLeft,
  //                   colors: [
  //                     Colors.red,
  //                     Colors.orange,
  //                   ],
  //                 ),
  //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50 ),bottomRight: Radius.circular(50)),
  //     ),
  //     child:    Stack(
  //       children: [
  //         Positioned(
  //           top: 30,
  //           left: 15,
  //           child: Container(
  //           margin: EdgeInsets.only(top: 20,left: 10),
  //           child: IconButton(
  //           color: Colors.black,
  //           icon: Icon(Icons.arrow_back_ios , color: Colors.white,),
  //           iconSize: 20,
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //         ),
  //         ),),
  //            Container(
  //                       margin: const EdgeInsets.only(bottom: 20),
  //         alignment: Alignment.bottomCenter,
  //                      child: Text("Recommended Rides",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
  //                     ),
      
  //       ])
      
 
  //   )
  //  ),
  //  Expanded(
    
  //    child: ListView.builder(
  //     shrinkWrap: true,
  //    itemCount: 4,
  //    itemBuilder: (context, index) {
  //     return Listitems();
  //    },
  //  ),
  //  ),
  //         // Container(
  //         // child:   ListView.builder(
  //         // itemCount: 3,
  //         // padding: EdgeInsets.zero,
  //         // itemBuilder: (context, index) {
  //         //   return  Listitems();
  //         // })
  //         // ),
           
  //       ],
  //     ),
  //   );
  }
}

class Listitems extends StatefulWidget {

  Rides rides;
   double? afromlatitude;
  double? afromlongitude;
  double? atolatitude;
  double? atolongitude;
  String? aphonenumber;
  int? apassengers;
   Listitems({super.key, required this.rides, required this.afromlatitude, required this.afromlongitude, required this.atolatitude, required this.atolongitude, required this.aphonenumber, required this.apassengers});

  @override
  State<Listitems> createState() => _ListitemsState();
}

class _ListitemsState extends State<Listitems> {
  //String phonenumber ="${widget.rides.phone_number}}";
    bool loading = false;
     DocumentSnapshot? _lastVisible;
  bool? _isLoading;
  int i=1;
  List<DocumentSnapshot> _snap = [];
  List<Driver>? _data;
  bool? _hasData;
  String buttontxt ='Send a Request';
    @override
  void initState() {

    super.initState();
    _isLoading = true;

    _getData();
    pricecalcualate();
  }
Future<Null> _getData() async {
    setState(() => _hasData = true);
    QuerySnapshot data;

    if (_lastVisible == null) {
      data = await firestore
          .collection('drivers')
          .where('phone_number', isEqualTo: "${widget.rides.phone_number}")

          //  .orderBy('latitude', descending: false)
         //    .limit(10)
          .get();

          print("${widget.rides.phone_number}");

    } else {
      data = await firestore
          .collection('drivers')
       //   .where('latitude', isGreaterThanOrEqualTo: null)

          // .orderBy('latitude', descending: false)
       //   .startAfter([_lastVisible!['latitude']])
            .limit(0)
          .get();
    }

    if (data.docs.length > 0) {
      print(data.docs.length);
      _lastVisible = data.docs[data.docs.length - 1];
      if (mounted) {
        setState(() {
          _isLoading = false;
          _snap.addAll(data.docs);
          _data = _snap.map((e) => Driver.fromFirestore(e)).toList();
          print(_data![0].first_name);
        });
      }
    } else {
      if (_lastVisible == null) {
        setState(() {
          _isLoading = false;
          _hasData = false;
          print('no items');
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasData = true;
          print('no more items');
        });
      }
    }
    return null;
  }
  double calculateDistance(lat1, lon1, lat2, lon2) {
    double p = 0.017453292519943295;
    double a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;

    return 12742 * asin(sqrt(a));
  }

double price =0;
  void pricecalcualate(){
   double distance = calculateDistance(widget.rides.from_latitude, widget.rides.from_longitude, widget.rides.to_latitude, widget.rides.to_longitude);

   if(distance<10){
    price = distance*30;
   }
   if(distance>10 && distance<20){
    price = distance*25;
   }
    if(distance>20 && distance<30){
      price = distance*20;
    }
    if(distance>30 && distance<40){
      price = distance*17;
    }
    if(distance>40 && distance<50){
      price = distance*14;
    }
    if(distance>50){
      price = distance*10;
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return 
          _isLoading ?? true ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Container(
                margin: const EdgeInsets.only( bottom: 20,left: 20,right: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange,
                  width: 3),
                  borderRadius: BorderRadius.circular(20),
                color: Colors.white),
                
                child: Column(
                  children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start ,

                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10,left: 10),
                            child: Row(
                              children:  [
                                const Text("Driver Name : ",style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.bold),),
                             //   Text("${_data.length}")
                           
                                Text("${_data![0].first_name} ${_data![0].last_name}",style: const TextStyle(fontSize: 15,),),
                              ],
                            ),
                          ),
                           Container(
                            margin: const EdgeInsets.only(top: 10,left: 10),
                            child: Row(
                              children:  [
                                const Text("Vehicle Type : ",style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.bold),),
                                Text("${_data![0].vehicle_type}",style: const TextStyle(fontSize: 15,),),

                                
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Row(
                          children:  [
                             const Text("Rs.",style: TextStyle(fontSize: 17,
                                      fontWeight: FontWeight.bold),),
                           Text(price.toStringAsFixed(2),style: const TextStyle(fontSize: 20,
                                      fontWeight: FontWeight.bold),),         
                          ],
                        ),
                      ),
                    ],
                  ),
                   Container(
                    margin: const EdgeInsets.only(left: 10),
                     child: Row(
                       children:  [
                         const Text("Date : ",style: TextStyle(fontSize: 15,
                                      fontWeight: FontWeight.bold),),
                                      Text("${widget.rides.date}",style: const TextStyle(fontSize: 15,),),
                                        const SizedBox(width: 30,),
                                       const Text("Time : ",style: TextStyle(fontSize: 15,
                                      fontWeight: FontWeight.bold),),
                                      Text("${widget.rides.time}",style: const TextStyle(fontSize: 15,),),
                       ],
                     ),
                   ),
                //     Row(
                //       children: [
                //         Column(
                //   children: [
                //         Container(
                //           margin: EdgeInsets.only(left: 20,top: 15),
                //           height: 10,
                //           width: 10,
                //           decoration: const BoxDecoration(
                //             color: Colors.black,
                //             shape: BoxShape.circle,
                            
                //           )),
            
             
                //         Container(margin: const EdgeInsets.only(left: 20,),
                //         height: 25,
                //         width: 2,
                //         color: Colors.black,
                //         ),
                //         Container(
                //           margin: const EdgeInsets.only(left: 20),
                //           height: 10,
                //           width: 10,
                //           decoration: const BoxDecoration(
                //             color: Colors.black,
                //             shape: BoxShape.circle,
                            
                //           )),
                //   ],
                // ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Container(
                //       margin: const EdgeInsets.only(left: 20,top: 10),
                //       child: const Text("From Address" ,style: TextStyle(fontSize: 15,
                //       ),),
                //     ),
                //     const SizedBox(height: 5,),
                //     Container(
                //       margin: const EdgeInsets.only(left: 20,top: 10),
                //       child: const Text("To Address" ,style: TextStyle(fontSize: 15,))
                //     ),
                  
                  
                   
                //   ],
                // )
                //       ],
                //     ),
                    Row(
                      
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: SizedBox(
                        width: 120,
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
                                      color: Color.fromRGBO(
                                          0, 0, 0, 0.57), //shadow for button
                                      blurRadius: 5) //blur radius of shadow
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
                                 
                                  nextScreen(context, ViewRoute(startLat: widget.rides.from_latitude, startLng: widget.rides.from_longitude, endLat: widget.rides.to_latitude, endLng: widget.rides.to_longitude, pslat: widget.afromlatitude, pslng: widget.afromlongitude, ptlat: widget.atolatitude, ptlng: widget.atolongitude,));
                                  //  print(phoneNumberController.text);
                                  // loading
                                  //     ?  nextScreeniOS(context, AvailiableRides())
    
                                  //     : Container(
                                  //         alignment: Alignment.center,
                                  //         child: const CircularProgressIndicator(
                                  //           backgroundColor: Colors.orange,
                                  //         ),
                                  //       );
                                  // if (!loading) {
                                  //   setState(() {
                                  //     index = false;
                                  //   });
                                  // }

                                  // print(phoneNumberController);
                                },
                                child:const Padding(
                                        padding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                        ),
                                        child: Text("View Route", style: TextStyle(color: Colors.white),),
                                      ))
                                      ),
                  ),
                ),
                        Container(
                          margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: SizedBox(
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
                                      color: Color.fromRGBO(
                                          0, 0, 0, 0.57), //shadow for button
                                      blurRadius: 5) //blur radius of shadow
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
                                    loading = true;
                                  });

 final result = await DatabaseServiceRequest().sendRequest(
                    dpnumber: _data![0].phone_number!,
                    ppnumber: widget.aphonenumber!,
                    fromlatitude: widget.afromlatitude!,
                    fromlongitude: widget.afromlongitude!,
                    tolatitude: widget.atolatitude!,
                    tolongitude: widget.atolongitude!,
                    numofpassengers: widget.apassengers!,
                    rfromlat: widget.rides.from_latitude!,
                    rfromlng: widget.rides.from_longitude!,
                    rtolat: widget.rides.to_latitude!,
                    rtolng: widget.rides.to_longitude!,
                    price: price.toStringAsFixed(2),
                    status: 'pending',
                    

                
                
                
                );
                if (result!.contains('success')) {
                  setState(() {
                    loading=false;
                    buttontxt='Request sent!';
                  });
      
         //    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(phonenumber: widget.phoneNo, usermode: false,)));
                }

                                  //  print(phoneNumberController.text);
                                  // loading
                                  //     ?  nextScreeniOS(context, AvailiableRides())
    
                                  //     : Container(
                                  //         alignment: Alignment.center,
                                  //         child: const CircularProgressIndicator(
                                  //           backgroundColor: Colors.orange,
                                  //         ),
                                  //       );
                                  // if (!loading) {
                                  //   setState(() {
                                  //     index = false;
                                  //   });
                                  // }

                                  // print(phoneNumberController);
                                },
                                child: loading
                                    ? const CircularProgressIndicator()
                                    :  Padding(
                                        padding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                        ),
                                        child: Text(buttontxt, style: TextStyle(color: Colors.white),),
                                      ))
                                      ),
                  ),
                ),
                      ],
                    ),
                ])
              );
  }
}