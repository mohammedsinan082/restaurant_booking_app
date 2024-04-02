

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:restaurant_booking_app/core/constants/image_constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../core/constants/color_constants.dart';
import '../main.dart';
import '../model/restuarant_model.dart';

class DetailsPage extends StatefulWidget {
  final Restaurant restaurant;
  final double rating;
  final String images;
  const DetailsPage({super.key,required this.restaurant,required this.rating,required this.images});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {





  var dropdownvalue;
  List<String> drops = ["gggdgd"];
  bool expand=true;
  int selectedindex=0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:FloatingActionButton(
        onPressed: (){
         openMap(latitude: widget.restaurant.latlng.lat, longitude: widget.restaurant.latlng.lng);
        },
        backgroundColor: ColorTheme.Orange,
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: h*0.05,
              width: w*0.1,
            //  color: Colors.green,
              child: Column(
                children: [
                  Icon(Icons.directions),
                  Text("Go")
                ],
              ),
            )

          ],
        ),
      ),
        body: SingleChildScrollView(

          child: Column(
            children: [
              Container(
                height: h*0.30,
                width: w*1,
                decoration: BoxDecoration(
                //    color: Colors.green,
                  image: DecorationImage(image: AssetImage(widget.images),fit: BoxFit.cover)
                ),
                child: Stack(
                  children: [
                  Positioned(
                    top: w*0.12,
                      left: w*0.07,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                          child: Icon(Icons.arrow_back_ios,color: ColorTheme.black87,size: w*0.09,))),
                          Positioned(
                              bottom: w*0.02,
                              left: w*0.02,
                              child: Text(widget.restaurant.name,style: TextStyle(
                                fontSize: w*0.05,fontWeight: FontWeight.w400
                              ),))

                  ],
                ),
              ),
              Container(

                height: h*0.18,
                width: w*0.95,
                padding: EdgeInsets.all(w*0.010),
                // decoration: BoxDecoration(
                //  //   color: Colors.grey,
                //     border: Border(bottom: BorderSide(width: w*0.001,color: ColorTheme.Grey),left:BorderSide(width: w*0.001,color: ColorTheme.Grey),right: BorderSide(width: w*0.001,color: ColorTheme.Grey))
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.restaurant.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.05)),
                        Container(
                          height: h*0.03,
                          width: w*0.14,
                          padding: EdgeInsets.all(w*0.01),
                          //  width: w*0.15,
                          decoration: BoxDecoration(
                              color: ColorTheme.Green,
                              borderRadius: BorderRadius.circular(w*0.03)),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(widget.rating.toString(),style: TextStyle(
                                  fontWeight: FontWeight.w400,fontSize: w*0.040,color: ColorTheme.White
                              )),
                              Icon(Icons.star_rate_rounded,color: ColorTheme.White,size: w*0.044,)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(widget.restaurant.neighborhood.name,style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.04),),
                      ],
                    ),

                       Row(
                         children: [
                           Icon(Icons.fastfood_outlined,size: w*0.05,color: ColorTheme.Greydark),
                           SizedBox(width: w*0.02,),
                           Text(widget.restaurant.cuisineType,style: TextStyle(fontWeight: FontWeight.w400,fontSize: w*0.040),)

                         ],
                       ),
                       Row(
                         children: [
                           Icon(Icons.location_on,size: w*0.05,color:  ColorTheme.Greydark),
                           SizedBox(width: w*0.02,),
                           Text(widget.restaurant.address,style: TextStyle(fontWeight: FontWeight.w400,fontSize: w*0.04),)

                         ],
                       ),
                       Row(
                         children: [
                           Icon(Icons.access_time_filled_outlined,size: w*0.05,color:  ColorTheme.Greydark),
                           SizedBox(width: w*0.02,),
                           Container(
                             height: h*0.025,
                             width: w*0.7,
                            // color: Colors.green,
                             child:
                             DropdownButton(
                               underline: SizedBox(),
                               isExpanded: true,
                               hint: Text(widget.restaurant.operatingHours.monday,style: TextStyle(fontWeight: FontWeight.w400,fontSize: w*0.040,color:  ColorTheme.black87),),
                               icon: Icon(Icons.keyboard_arrow_down_outlined),
                               value: dropdownvalue,
                               items: drops.map((e) =>
                                   DropdownMenuItem(
                                       value: e,
                                       child:

                                       Text(e,style: TextStyle(
                                         color: ColorTheme.black87,
                                         fontSize: w*0.04,
                                         fontWeight: FontWeight.w500,
                                       ),
                                       ))
                               ).toList() ,
                               onChanged: (newValue) {
                                 setState(() {
                                   print(newValue);
                                   print("newValue");
                                   dropdownvalue=newValue!;
                                 });
                               },
                             ),
                           )
                        //   Text("Wednesday: 5:30 pm - 12:00 am",style: TextStyle(fontWeight: FontWeight.w400,fontSize: w*0.040),),


                         ],
                       ),


                  ],
                ),
              ),
              Container(
                height: h*0.06,
                width: w*0.95,
                //color: Colors.green,
                child: Row(

                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                        child: Text("Rating & Reviews",style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.05),)),
                  ],
                ),
              ),
              SizedBox(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                    itemBuilder: (context, index) {
                  return Container(
                    width: w*0.95,
                 //   color: Colors.amber,
                    child: Column(
                      children: [
                        Container(
                          height: h*0.045,
                          width: w*0.95,
                       //   color: Colors.red,
                          child: Row(
                            children: [
                              Container(
                                height: h*0.03,
                                width: w*0.14,
                                padding: EdgeInsets.all(w*0.01),
                                //  width: w*0.15,
                                decoration: BoxDecoration(
                                    color:  ColorTheme.Green,
                                    borderRadius: BorderRadius.circular(w*0.03)),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("4",style: TextStyle(
                                        fontWeight: FontWeight.w400,fontSize: w*0.040,color: ColorTheme.White
                                    )),
                                    Icon(Icons.star_rate_rounded,color: ColorTheme.White,size: w*0.044,)
                                  ],
                                ),
                              ),
                              SizedBox(width: w*0.03,),
                              Text(widget.restaurant.reviews[index].name,style: TextStyle(fontWeight: FontWeight.w400,fontSize: w*0.040),)
                            ],
                          ),

                        ),
                        selectedindex == index && expand ?
                        Container(
                          height:
                          h*0.057,
                        //  color: Colors.blue,
                          width: w*0.95,
                            child: Text(widget.restaurant.reviews[index].comments+"....",
                              style: TextStyle(fontSize: w*0.033,fontWeight: FontWeight.w400),)):
                        Container(
                          height:
                          h*0.12 ,
                          width: w*0.95,
                         //   color: Colors.green,
                            child: Text(widget.restaurant.reviews[index].comments,
                              style: TextStyle(fontSize: w*0.033,fontWeight: FontWeight.w400),)),
                        Container(
                          width: w*0.95,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                 setState(() {
                                   selectedindex=index;
                                   expand=!expand;
                                 });
                                },
                                child: Container(
                                //  color: Colors.green,
                                    child:
                                    Text("Read More", style: TextStyle(
                                      color: ColorTheme.Greylight,
                                      decoration: TextDecoration.underline,
                                      decorationColor: ColorTheme.Greylight,
                                      decorationThickness: 2,
                                    ),)),

                              )
                            ],
                          ),
                        ),
                        Container(
                          width: w*0.95,
                          child: Row(
                            children: [
                              Container(
                                //  color: Colors.green,
                                  child:
                                  Text(widget.restaurant.reviews[index].date.toString(), style: TextStyle(
                                    color:  ColorTheme.black87,

                                  ),)),
                            ],
                          ),
                        ),

                      ],
                    ),
                  );
                },
                    // separatorBuilder: (context, index) {
                    //   return Divider(
                    //     color: ColorTheme.Greylight,
                    //    // thickness: ,
                    //   );
                    // },
                    itemCount: 5),
              )
            ],
          ),
        ),
    );
  }

  Future<void> openMap({required double latitude, required double longitude}) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl);
    } else {
      throw 'Could not launch $googleUrl';
    }
  }
}
