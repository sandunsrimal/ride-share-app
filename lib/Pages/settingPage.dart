import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){},),
        // ],
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){

        },),
        title: const Text("Account Settings",textAlign: TextAlign.center,),
        centerTitle: true,
        
      ),
      body: SafeArea(
        child: Container(color: Colors.white,
            
            child: Padding(
              padding:const EdgeInsets.all(15.0),
              child:Column(
                children: [

                  //Change Password

                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                                 color: Colors.black.withOpacity(.5),
                                 width: 2.0,
                                 
                                 ),
                          borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6.0,left: 6),
                        
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          
                          children: [
                            
                            Text('Edit Profile',style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 20),
                            ),
                            ), 
                             IconButton(onPressed: () {}, icon: Icon( Icons.arrow_forward_ios, size: 19,),)
                          ],
                        ),
                      ),
                    ),

                      //Change Language
                    const SizedBox(
                        height: 30, // <-- SEE HERE
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                                  
                                 color: Colors.black.withOpacity(.5),
                                 width: 2.0,
                                 ),
                          borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6.0,left: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            
                            Text('Change Language',style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 20)
                              ),),
                              IconButton(onPressed: () {}, icon: Icon( Icons.arrow_forward_ios, size: 19,),)
                          ],
                        ),
                      ),
                    ),

                      //Privecy and Policy

                    const SizedBox(
                        height: 30, // <-- SEE HERE
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                                  
                                 color: Colors.black.withOpacity(.5),
                                 width: 2.0,
                                 ),
                          borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6.0,left: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Privecy and Policy",style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 20),
                              ),
                              ),
                              //const Icon( Icons.arrow_forward_ios, size: 19,),
                              IconButton(onPressed: () {}, icon: Icon( Icons.arrow_forward_ios, size: 19,),)  
                        ],),
                      ),
                    ),

                    //Contact Us

                    const SizedBox(
                        height: 30, // <-- SEE HERE
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                                  
                                 color: Colors.black.withOpacity(.5),
                                 width: 2.0,
                                 ),
                          borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6.0,left: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Contact Us',style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 20),
                              ),),
                              IconButton(onPressed: () {}, icon: Icon( Icons.arrow_forward_ios, size: 19,),)
                          ],
                        ),
                      ),
                    ),

                      //Delete Account

                      const SizedBox(
                        height: 30, // <-- SEE HERE
                    ),

                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                                  
                                 color: Colors.black.withOpacity(.5),
                                 width: 2.0,
                                 ),
                          borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6.0,left: 6),
                        
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text('Delete Account',style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 20),
                              ),),
                              IconButton(onPressed: () {}, icon: Icon( Icons.arrow_forward_ios, size: 19,),)
                        ],)
                      ),
                    )
                ],
              ),
            ),
        )
      ),
    );
  }
}