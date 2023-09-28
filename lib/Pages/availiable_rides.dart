import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../Utils/next_screen.dart';

class AvailiableRides extends StatefulWidget {
  const AvailiableRides({super.key});

  @override
  State<AvailiableRides> createState() => _AvailiableRidesState();
}

class _AvailiableRidesState extends State<AvailiableRides> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
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
            margin: EdgeInsets.only(top: 20,left: 10),
            child: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ),),
             Container(
                        margin: const EdgeInsets.only(bottom: 20),
          alignment: Alignment.bottomCenter,
                       child: Text("Recommended Rides",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
      
        ])
      
 
    )
   ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all( 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange,
                  width: 3),
                  borderRadius: BorderRadius.circular(20),
                color: Colors.white),
                
                child: Column(children: [
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
                              children: const [
                                Text("Driver Name : ",style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.bold),),
                                Text("Sandun Srimal",style: TextStyle(fontSize: 15,),),
                              ],
                            ),
                          ),
                           Container(
                            margin: const EdgeInsets.only(top: 10,left: 10),
                            child: Row(
                              children: const [
                                Text("Vehicle Type : ",style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.bold),),
                                Text("Car",style: TextStyle(fontSize: 15,),),

                                
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Row(
                          children: const [
                             Text("Rs. ",style: TextStyle(fontSize: 20,
                                      fontWeight: FontWeight.bold),),
                           Text("1000",style: TextStyle(fontSize: 25,
                                      fontWeight: FontWeight.bold),),         
                          ],
                        ),
                      ),
                    ],
                  ),
                   Container(
                    margin: const EdgeInsets.only(left: 10),
                     child: Row(
                       children: const [
                         Text("Date : ",style: TextStyle(fontSize: 15,
                                      fontWeight: FontWeight.bold),),
                                      Text("26/09/2023",style: TextStyle(fontSize: 15,),),
                                        SizedBox(width: 30,),
                                       Text("Time : ",style: TextStyle(fontSize: 15,
                                      fontWeight: FontWeight.bold),),
                                      Text("8.00 AM",style: TextStyle(fontSize: 15,),),
                       ],
                     ),
                   ),
                    Row(
                      children: [
                        Column(
                  children: [
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 15),
                          height: 10,
                          width: 10,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            
                          )),
            
             
                        Container(margin: const EdgeInsets.only(left: 20,),
                        height: 25,
                        width: 2,
                        color: Colors.black,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: 10,
                          width: 10,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            
                          )),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20,top: 10),
                      child: const Text("From Address" ,style: TextStyle(fontSize: 15,
                      ),),
                    ),
                    const SizedBox(height: 5,),
                    Container(
                      margin: const EdgeInsets.only(left: 20,top: 10),
                      child: const Text("To Address" ,style: TextStyle(fontSize: 15,))
                    ),
                  
                  
                   
                  ],
                )
                      ],
                    ),
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
                                  setState(() {
                                    loading = true;
                                  });
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
                                    : const Padding(
                                        padding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                        ),
                                        child: Text("View Route"),
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
                                    : const Padding(
                                        padding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                        ),
                                        child: Text("Send a Request"),
                                      ))
                                      ),
                  ),
                ),
                      ],
                    ),
                ])
              ),
             
            ],
          ),
           
        ],
      ),
    );
  }
}