import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_animation_transition/animations/left_to_right_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:restaurant_booking_app/core/constants/color_constants.dart';
import 'package:restaurant_booking_app/core/constants/image_constants.dart';
import 'package:restaurant_booking_app/core/constants/sharedprefer_constants.dart';
import 'package:restaurant_booking_app/feature/controller/fetchdata_controller.dart';
import 'package:restaurant_booking_app/feature/details_page.dart';
import 'package:restaurant_booking_app/feature/login_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {




  List ratingsList = [
  "3.7",
  '4.3',
  '4.3',
  '4',
  '4',
  '4',
  '4.3',
  '4',
  '4',
  '4.3'];

  List hotels=[
    Pictures.hotel1,
    Pictures.hotel2,
    Pictures.hotel3,
    Pictures.hotel4,
    Pictures.hotel5,
    Pictures.hotel6,
    Pictures.hotel7,
    Pictures.hotel8,
    Pictures.hotel9,
    Pictures.hotel10,
  ];
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:ColorTheme.Orange,
          title: Text('RESTAURANTS'),
          actions: [
            InkWell(
              onTap: () {
                signOut();
              },
              child: Container(
                  width: w*0.3,
                //  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.login_outlined),
                      Text('Log out')
                    ],
                  )),
            ),
          ],
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
           Consumer(
               builder: (context, ref, child) {
                 return ref.watch(fetchDataStreamProvider).when(
                     data: (data) {
                       return  ListView.separated(
                           physics: BouncingScrollPhysics(),
                           shrinkWrap: true,
                           itemBuilder: (context, index) {
                             return InkWell(
                               onTap: () {
                                 Navigator.of(context).push(PageAnimationTransition(page: DetailsPage(restaurant: data.restaurants[index], rating: ratingsList[index], images: hotels[index],), pageAnimationType:LeftToRightFadedTransition()));
                               },
                               child: Column(
                                 children: [
                                   Container(
                                     height: h*0.24,
                                     width: w*0.97,
                                     decoration: BoxDecoration(
                                       // color: Colors,
                                         borderRadius: BorderRadius.circular(w*0.02),
                                         image: DecorationImage(image: AssetImage(hotels[index]),fit: BoxFit.fill)
                                     ),
                                     //  child: Image.asset(Pictures.Food1,fit: BoxFit.fill),

                                   ),
                                   Container(
                                     height: h*0.14,
                                     width: w*0.95,
                                     // color: Colors.grey,
                                     padding: EdgeInsets.all(w*0.025),
                                     decoration: BoxDecoration(
                                         border: Border(bottom: BorderSide(width: w*0.001,color: ColorTheme.Greylight),left:BorderSide(width: w*0.001,color: ColorTheme.Greylight),right: BorderSide(width: w*0.001,color: ColorTheme.Greylight))
                                     ),
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Container(
                                           width: w*0.95,
                                           //   color:Colors.purple,
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Text(data.restaurants[index].name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.05)),
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
                                                     Text(ratingsList[index],style: TextStyle(
                                                         fontWeight: FontWeight.w400,fontSize: w*0.040,color: ColorTheme.White
                                                     )),
                                                     Icon(Icons.star_rate_rounded,color: ColorTheme.White,size: w*0.044,)
                                                   ],
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                         Container(
                                           height: h*0.07,
                                           //  color: Colors.blueGrey,
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                                             children: [
                                               Row(
                                                 children: [
                                                   Icon(Icons.restaurant_menu,size: w*0.06,color: Colors.grey.shade600),
                                                   SizedBox(width: w*0.02,),
                                                   Text(data.restaurants[index].cuisineType,style: TextStyle(fontWeight: FontWeight.w400,fontSize: w*0.04),)

                                                 ],
                                               ),
                                               Row(
                                                 children: [
                                                   Icon(Icons.location_on,size: w*0.06,color: Colors.grey.shade600),
                                                   SizedBox(width: w*0.02,),
                                                   Text(data.restaurants[index].address,style: TextStyle(fontWeight: FontWeight.w400,fontSize: w*0.04),)

                                                 ],
                                               ),
                                             ],
                                           ),
                                         )


                                       ],
                                     ),
                                   )

                                 ],
                               ),
                             );
                           },
                           separatorBuilder: (context, index) {
                             return SizedBox(height: h*0.02,);
                           },

                           itemCount: data.restaurants.length
                       );
                     },
                 error: (error, stackTrace) => Text(error.toString()),
                      loading: () => Center(child: CircularProgressIndicator()),);
               },)
          ],
        ),
      ),
    );
  }
  signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(SharedPreferConstants.login);
    prefs.remove(SharedPreferConstants.email);
    prefs.remove(SharedPreferConstants.password);

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);

  }
}
