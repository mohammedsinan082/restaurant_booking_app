import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_booking_app/core/constants/color_constants.dart';
import 'package:restaurant_booking_app/core/constants/image_constants.dart';
import 'package:restaurant_booking_app/feature/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {



  TextEditingController user_controller=TextEditingController();
  TextEditingController password_controller=TextEditingController();

  RegExp user_validation = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{3,4}$");
  RegExp password_validation = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  FocusNode focusnode1 =FocusNode();
  FocusNode focusnode2 =FocusNode();

  bool tap=false;
  bool check=false;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: ColorTheme.White,
        appBar: AppBar(
          backgroundColor: ColorTheme.White,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Animate(
          effects: [FadeEffect(duration: 1100.ms),SlideEffect()],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: h*0.3,
                width: w*8,
             //   color: Colors.red,
                child: Image(image: AssetImage(Pictures.LoginImage)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    height: h*0.40,
                    width: w*1,
                   // color: Colors.orange,
                    padding: EdgeInsets.all(w*0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: h*0.1,
                              width: w*0.5,
                            //  color: Colors.green,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                              Text("Log in",style:GoogleFonts.roboto(fontSize: w*0.07,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("your account",style:GoogleFonts.roboto(fontSize: w*0.07,fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: user_controller,
                          inputFormatters: [
                            //     FilteringTextInputFormatter.allow(RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{3,4}$"))
                          ],
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if(!user_validation.hasMatch(value!)){
                              return "enter valid email";
                            }else{
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Enter your Email",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: ColorTheme.Orange),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: ColorTheme.Orange),
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                        ),
                        TextFormField(
                          controller: password_controller,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText:tap,
                          autofocus: false,
                          focusNode: focusnode1,
                          inputFormatters: [
                            //   FilteringTextInputFormatter.allow(password_validation)
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if(!password_validation.hasMatch(value!)){
                              return "Enter valid Password";
                            }else{
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    tap=!tap;
                                  });
                                 // ref.read(tapProvider.notifier).update((state) => !tap);
                                },
                                child: tap==false?Icon(Icons.visibility):Icon(Icons.visibility_off) ),
                            disabledBorder: OutlineInputBorder(),
                            hintText: "Enter your Password",

                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorTheme.Orange),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorTheme.Orange),
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ),
                        Container(
                          width: w*1,
                          height: h*0.05,
                         // color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: w*0.40,
                             //   color: Colors.blue,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: w*0.02,
                                      child: Checkbox(
                                        value: check,
                                        onChanged: (box) {
                                          setState(() {
                                            check=box!;
                                          });

                                        },),
                                    ),
                                    Text("Remember me",style: TextStyle(fontSize: w*0.040,),)
                                  ],
                                ),
                              ),
                              Container(
                                width: w*0.37,
                              //  color: Colors.grey,
                                child: Text("Forgot Password?",style: TextStyle(fontSize: w*0.045,fontWeight: FontWeight.w600,color: ColorTheme.DarkBlue),),
                              ),


                            ],
                          ),
                        )




                      ],
                    ),

                  ),


                ],
              ),
              InkWell(
                onTap: () {
                  if(user_controller.text.isNotEmpty&&
                      password_controller.text.isNotEmpty
                  ){
                   loginData();
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
                  }
                },
                child: Container(
                  height: h*0.060,
                  width: w*0.9,
                  decoration: BoxDecoration(
                      color: ColorTheme.Orange,
                      borderRadius: BorderRadius.circular(w*0.01)
                  ),
                  child: Center(child: Text("Login",style: TextStyle(color: ColorTheme.White,fontWeight: FontWeight.bold,fontSize: w*0.055))),

                ),
              )
            ],
          )),
        ),
      ),
    );
  }
  loginData()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setBool('login', true);
    prefs.setString('email', user_controller.toString());
    prefs.setString('password', password_controller.toString());
  }
}

