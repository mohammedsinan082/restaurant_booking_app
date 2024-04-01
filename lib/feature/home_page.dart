import 'package:flutter/material.dart';
import 'package:restaurant_booking_app/core/constants/color_constants.dart';
import 'package:restaurant_booking_app/core/constants/image_constants.dart';
import 'package:restaurant_booking_app/core/constants/sharedprefer_constants.dart';
import 'package:restaurant_booking_app/feature/login_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: h*0.25,
                      width: w*0.97,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(w*0.02),
                        image: DecorationImage(image: AssetImage(Pictures.Food1),fit: BoxFit.fill)
                      ),
                    //  child: Image.asset(Pictures.Food1,fit: BoxFit.fill),

                    ),
                    Container(
                      height: h*0.17,
                      width: w*0.95,
                      // color: Colors.grey,
                      padding: EdgeInsets.all(w*0.025),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: w*0.001,color: ColorTheme.Grey),left:BorderSide(width: w*0.001,color: ColorTheme.Grey),right: BorderSide(width: w*0.001,color: ColorTheme.Grey))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: w*0.95,
                         //   color:Colors.purple,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Mission Chinese Food",style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.05)),
                                Container(
                                  height: h*0.03,
                                  padding: EdgeInsets.all(w*0.01),
                                  //  width: w*0.15,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(w*0.03)),
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("3.7",style: TextStyle(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                   Icon(Icons.fastfood_outlined,size: w*0.06,color: Colors.grey.shade600),
                                    SizedBox(width: w*0.02,),
                                    Text("Asian",style: TextStyle(fontWeight: FontWeight.w400,fontSize: w*0.04),)

                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,size: w*0.06,color: Colors.grey.shade600),
                                    SizedBox(width: w*0.02,),
                                    Text("171 E BroadWay",style: TextStyle(fontWeight: FontWeight.w400,fontSize: w*0.04),)

                                  ],
                                ),
                              ],
                            ),
                          )


                        ],
                      ),
                    )

                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: h*0.02,);
              },

              itemCount: 2)
        ],
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
