import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:transit_app/constants.dart';
import 'package:transit_app/screens/authScreens/loginScreen.dart';
import 'package:transit_app/screens/authScreens/signUpScreen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                verticalSpace(150),
                SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.height*0.15,
                    child: Image.asset("assets/images/logo.png")),
                const Text("Welcome",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50),),
                verticalSpace(25),
                const Text("Sign up for free \n or login",textAlign: TextAlign.center,),
                verticalSpace(25),
                kLandingButton(boxColor: kPrimaryColor, textColor: kWhiteColor, text: "Login", width: MediaQuery.of(context).size.width, onPressed: (){
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const LoginScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                }),
                verticalSpace(10),
                kLandingButton(boxColor: kWhiteColor, textColor: kPrimaryColor, text: "Sign Up", width: MediaQuery.of(context).size.width, onPressed: (){
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const SignUpScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                }),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
