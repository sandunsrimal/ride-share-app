import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rideshareapp/Pages/startride.dart';
import 'package:rideshareapp/Service/Driver.dart';

import '../Service/Requests.dart';
import '../Service/User.dart';
import '../Utils/next_screen.dart';
import '../Widget/splash_service.dart';
import 'empty.dart';

class ongoingRides extends StatefulWidget {
  const ongoingRides({super.key});

  @override
  State<ongoingRides> createState() => _ongoingRidesState();
}

class _ongoingRidesState extends State<ongoingRides> {



    ScrollController? controller;
   DocumentSnapshot? _lastVisible;
  bool? _isLoading;
    bool? _hasData;
      String? result;
  List<DocumentSnapshot> _snap = [];
  List<Requests> _data = [];
  
  int i=1;


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



 Future<Null> _getData() async {
    setState(() => _hasData = true);
    QuerySnapshot data;

    if (_lastVisible == null) {
      data = await firestore
          .collection('requests')
        //  .where('latitude', isGreaterThanOrEqualTo: null)

          //  .orderBy('latitude', descending: false)
         //    .limit(10)
          .get();
    } else {
      data = await firestore
          .collection('requests')
          .where('status', isEqualTo: 'accept')

          // .orderBy('latitude', descending: false)
       //   .startAfter([_lastVisible!['latitude']])
            .limit(0)
          .get();
    }

    if (data.docs.length > 0) {
      _lastVisible = data.docs[data.docs.length - 1];
      if (mounted) {
        setState(() {
          _isLoading = false;
          _snap.addAll(data.docs);
          _data = _snap.map((e) => Requests.fromFirestore(e)).toList();
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
                       child: const Text("Ongoing Rides",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
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
                                          message: 'no accepted ride found',
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

                                          if(_data[index].status == 'accept'){
                                            
                                            return Listitems(req: _data[index],);
                                          }

                                        //  return Listitems(req: _data[index],);
                                          // if (_data[index].dpnumber == '${widget.phonenumber}' && _data[index].status == 'pending') {

                                          //       return Listitems(req: _data[index]);
                                          //   // return _ListItem(
                                          //   //   d: _data[index],
                                          //   //   tag:
                                          //   //       '${_data[index].timestamp}$index',
                                          //   // );
                                           
                                          // }
                                          
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
  }
}

class Listitems extends StatefulWidget {

  Requests req;
   double? afromlatitude;
  double? afromlongitude;
  double? atolatitude;
  double? atolongitude;
  String? aphonenumber;
  int? apassengers;
   Listitems({super.key, required this.req,});

  @override
  State<Listitems> createState() => _ListitemsState();
}

class _ListitemsState extends State<Listitems> {
  //String phonenumber ="${widget.rides.phone_number}}";
    bool loading = false;
     DocumentSnapshot? _lastVisible;
      DocumentSnapshot? _lastVisible1;
  bool? _isLoading;
  int i=1;
  List<DocumentSnapshot> _snap = [];
  List<User>? _data;
    List<DocumentSnapshot> _snap1 = [];
  List<Driver>? _data1;
  bool? _hasData;
  String buttontxt ='Accept Request';
    @override
  void initState() {

    super.initState();
    _isLoading = true;

    _getData();
    _getDriverData();
 
  
  }
Future<Null> _getData() async {
    setState(() => _hasData = true);
    QuerySnapshot data;

    if (_lastVisible == null) {
      data = await firestore
          .collection('users')
          .where('phone_number', isEqualTo: "${widget.req.ppnumber}")

          //  .orderBy('latitude', descending: false)
         //    .limit(10)
          .get();

       //   print("${widget.req.ppnumber}");

    } else {
      data = await firestore
          .collection('users')
       //   .where('latitude', isGreaterThanOrEqualTo: null)

          // .orderBy('latitude', descending: false)
       //   .startAfter([_lastVisible!['latitude']])
            .limit(0)
          .get();
    }

    if (data.docs.length > 0) {
  //    print(data.docs.length);
      _lastVisible = data.docs[data.docs.length - 1];
      if (mounted) {
        setState(() {
          _isLoading = false;
          _snap.addAll(data.docs);
          _data = _snap.map((e) => User.fromFirestore(e)).toList();
     //     print(_data![0].first_name);
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

Future<Null> _getDriverData() async {
    setState(() => _hasData = true);
    QuerySnapshot data;


    if (_lastVisible1 == null) {
      data = await firestore
          .collection('drivers')
          .where('phone_number', isEqualTo: "${widget.req.dpnumber}")

          //  .orderBy('latitude', descending: false)
         //    .limit(10)
          .get();

          print("${widget.req.dpnumber}");
       

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
      print("object");
print("object");
      print(data.docs.length);
      print("object");
print("object");
      _lastVisible1 = data.docs[data.docs.length - 1];
      if (mounted) {
        setState(() {
          _isLoading = false;
          _snap1.addAll(data.docs);
          _data1 = _snap1.map((e) => Driver.fromFirestore(e)).toList();
          
        });
        print(_data1![0].first_name);
        print(_data1![0].last_name);
      }
    } else {
      if (_lastVisible1 == null) {
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

   Future UpdateStatus(String? timestamp
     ) async {
    //admin icon url

    await firestore
        .collection('requests')
        .doc('$timestamp')
        .update({
      'status': "accept",
    });

    setState(() {
      loading = false;
      buttontxt='Accepted!';
    });
  }
 

double price =0;
 
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
                                const Text("Passenger Name : ",style: TextStyle(fontSize: 15,
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
                                const Text("Driver Name : ",style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.bold),),
                            //    Text("${_data1}")
                           _data1 == null ? const Text("Loading") :
                               Text("${_data1![0].first_name} ${_data1![0].last_name}",style: const TextStyle(fontSize: 15,),),
                              ],
                            ),
                          ),
                                 Container(
                            margin: const EdgeInsets.only(top: 10,left: 10),
                            child: Row(
                              children:  [
                                const Text("Vehicle No : ",style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.bold),),
                                _data1 == null ? const Text("Loading") :
                               Text("${_data1![0].vehicle_number}",style: const TextStyle(fontSize: 15,),),

                                
                              ],
                            ),
                          ),
//                            Container(
//                             margin: const EdgeInsets.only(top: 10,left: 10),
//                             child: Row(
//                               children:  [
//                                 const Text("Rating : ",style: TextStyle(fontSize: 15,
//                                 fontWeight: FontWeight.bold),),
//                         //        Text("${_data![0].vehicle_type}",style: const TextStyle(fontSize: 15,),),
// Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         RatingBarIndicator(
//                                     rating: 5,
//                                     itemBuilder: (context, index) => Icon(
//                                       Icons.star,
//                                       color: Colors.amber,
//                                     ),
//                                     itemSize: 25.0,
//                                     direction: Axis.horizontal,
//                                   ),
//                      //   Text("${_rating.toString()}  out of 5"),
//                       ],
//                     ),
                                
//                               ],
//                             ),
//                           ),
                           Container(
                            margin: const EdgeInsets.only(top: 10,left: 10),
                            child: Row(
                              children:  [
                                const Text("Price : ",style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.bold),),
                               Text("Rs. ${widget.req.price}",style: const TextStyle(fontSize: 15,),),

                                
                              ],
                            ),
                          ),
                            Container(
                            margin: const EdgeInsets.only(top: 10,left: 10),
                            child: Row(
                              children:  [
                                const Text("Passengers : ",style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.bold),),
                               Text("${widget.req.numofpassengers}",style: const TextStyle(fontSize: 15,),),

                                
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                       Column(
                         children: [
                           Container(
                            padding: const EdgeInsets.only(top: 10),
                             child:  CircleAvatar(
                                                 radius: 25,
                                                 backgroundImage: NetworkImage('${_data![0].dp_url}'),
                                                 
                                               ),
                           ),
                            Container(
                            padding: const EdgeInsets.only(top: 10),
                             child:_data1 == null ?   Container()
                              :  CircleAvatar(
                                                 radius: 25,
                                                 backgroundImage:  NetworkImage('${_data1![0].dp_url}'),
                                                 
                                               ),
                           ),
                         ],
                       ),
                    const Spacer(),
                      // const Spacer(),
                      // Container(
                      //   margin: const EdgeInsets.all(20),
                      //   child: Row(
                      //     children:  [
                      //        const Text("Rs.",style: TextStyle(fontSize: 17,
                      //                 fontWeight: FontWeight.bold),),
                      //      Text(price.toStringAsFixed(2),style: const TextStyle(fontSize: 20,
                      //                 fontWeight: FontWeight.bold),),         
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  //  Container(
                  //   margin: const EdgeInsets.only(left: 10),
                  //    child: Row(
                  //      children:  [
                  //        const Text("Date : ",style: TextStyle(fontSize: 15,
                  //                     fontWeight: FontWeight.bold),),
                  //                 //    Text("${widget.rides.date}",style: const TextStyle(fontSize: 15,),),
                  //                       const SizedBox(width: 30,),
                  //                      const Text("Time : ",style: TextStyle(fontSize: 15,
                  //                     fontWeight: FontWeight.bold),),
                  //              //       Text("${widget.rides.time}",style: const TextStyle(fontSize: 15,),),
                  //      ],
                  //    ),
                  //  ),
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
                          IconButton(onPressed: (){

                        }, 
                        icon: const Icon(Icons.message),
                        ),
                        IconButton(onPressed: (){

                          showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context),
            );

                        }, 
                        icon: const Icon(Icons.call),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: SizedBox(
                        width: 100,
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
                             
                               
                                  
                                  nextScreen(context, ViewRoute(startLat: widget.req.fromlatitude, startLng: widget.req.fromlongitude, endLat: widget.req.tolatitude, endLng: widget.req.tolongitude, pslat: widget.req.rfromlat, pslng: widget.req.rfromlng, ptlat: widget.req.rtolat, ptlng: widget.req.rtolng,));
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
                                        child: Text("Start", style: TextStyle(color: Colors.white),),
                                      ))
                                      ),
                  ),
                ),
//                         Container(
//                           margin: const EdgeInsets.all(10),
//                   alignment: Alignment.center,
//                   child: SizedBox(
//                         width: 150,
//                         height: 40,
//                         child: DecoratedBox(
//                             decoration: BoxDecoration(
//                                 gradient: const LinearGradient(colors: [
//                                   Colors.orange,
//                                   Colors.red,

//                                   //add more colors
//                                 ]),
//                                 borderRadius: BorderRadius.circular(25),
//                                 boxShadow: const <BoxShadow>[
//                                   BoxShadow(
//                                       color: Color.fromRGBO(
//                                           0, 0, 0, 0.57), //shadow for button
//                                       blurRadius: 5) //blur radius of shadow
//                                 ]),
//                             child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.transparent,
//                                   disabledForegroundColor:
//                                       Colors.transparent.withOpacity(0.38),
//                                   disabledBackgroundColor:
//                                       Colors.transparent.withOpacity(0.12),
//                                   shadowColor: Colors.transparent,
//                                   //make color or elevated button transparent
//                                 ),
//                                 onPressed: () async {
//                                   setState(() {
//                                     loading = true;
//                                   });

//                                   UpdateStatus('${widget.req.timestamp}');

// //  final result = await DatabaseServiceRequest().sendRequest(
// //                     dpnumber: _data![0].phone_number!,
// //                     ppnumber: widget.aphonenumber!,
// //                     fromlatitude: widget.afromlatitude!,
// //                     fromlongitude: widget.afromlongitude!,
// //                     tolatitude: widget.atolatitude!,
// //                     tolongitude: widget.atolongitude!,
// //                     numofpassengers: widget.apassengers!,
// //                     rfromlat: widget.rides.from_latitude!,
// //                     rfromlng: widget.rides.from_longitude!,
// //                     rtolat: widget.rides.to_latitude!,
// //                     rtolng: widget.rides.to_longitude!,
// //                     price: price.toStringAsFixed(2),
                    

                
                
                
// //                 );
// //                 if (result!.contains('success')) {
// //                   setState(() {
// //                     loading=false;
// //                     buttontxt='Request sent!';
// //                   }
// //                   );
      
// //          //    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(phonenumber: widget.phoneNo, usermode: false,)));
// //                 }

//                                   //  print(phoneNumberController.text);
//                                   // loading
//                                   //     ?  nextScreeniOS(context, AvailiableRides())
    
//                                   //     : Container(
//                                   //         alignment: Alignment.center,
//                                   //         child: const CircularProgressIndicator(
//                                   //           backgroundColor: Colors.orange,
//                                   //         ),
//                                   //       );
//                                   // if (!loading) {
//                                   //   setState(() {
//                                   //     index = false;
//                                   //   });
//                                   // }

//                                   // print(phoneNumberController);
//                                 },
//                                 child: loading
//                                     ? const CircularProgressIndicator()
//                                     :  Padding(
//                                         padding: const EdgeInsets.only(
//                                           top: 10,
//                                           bottom: 10,
//                                         ),
//                                         child: Text(buttontxt, style: const TextStyle(color: Colors.white),),
//                                       ))
//                                       ),
//                   ),
//                 ),
                      ],
                    ),
                ])
              );
  }
  Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('Phone Numbers'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            const Text("Passenger : ",style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.bold),),
            Text("${_data![0].phone_number}"),
          ],
        ),
          Row(
          children: [
            const Text("Driver : ",style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.bold),),
                                _data1 == null ? const Text("Loading") :
            Text("${_data1![0].phone_number}"),
          ],
        ),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
       // textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}
}