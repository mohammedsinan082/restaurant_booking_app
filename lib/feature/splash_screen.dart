import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_booking_app/core/constants/image_constants.dart';
import 'package:restaurant_booking_app/core/constants/sharedprefer_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'home_page.dart';
import 'login_Page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  loggedInCheck()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    loggedIn=prefs.getBool('login')??false;
    currentUserEmail=prefs.getString(SharedPreferConstants.email)??"no email given";
    currentUserPassword=prefs.getString(SharedPreferConstants.password)??"no password given";

    Future.delayed(Duration(seconds: 2)).then((value) => {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loggedIn==false? LoginPage():HomePage(),))
    });
  }

  @override
  void initState() {
    loggedInCheck();
    // TODO: implement initState
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Center(
             child: Container(
               height: h*0.09,
               width: w*1,
               color: Colors.transparent,
               child: Image(image: AssetImage(Pictures.SpashScreen))
               // Column(
               //   children: [
               //    Row(
               //      mainAxisAlignment: MainAxisAlignment.spaceAround,
               //      children: [
               //        Container(
               //          height:h*0.08,
               //          width:w*0.15,
               //            color: Colors.red,
               //            child: Icon(Icons.shopping_cart_outlined,color: Colors.blue.shade900,size: w*0.12,)),
               //        Container(
               //          height: h*0.08,
               //          width: w*0.42,
               //          color: Colors.blue,
               //          child: Column(
               //            children: [
               //              Text("The",style: GoogleFonts.adventPro(),)
               //            ],
               //          ),
               //        )
               //      ],
               //    )
               //   ],
               // ),
             ),
           )
          ],
        ),
      ),
    );
  }
}
