import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:transit_app/screens/authScreens/signUpScreen.dart';

import '../../constants.dart';
import '../../services/authServices.dart';
import '../home.dart';
import '../main_navigation.dart';
import 'accountRecoveryScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEmail(String input) => EmailValidator.validate(input);
  bool _passwordVisible = false;
  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                verticalSpace(MediaQuery.of(context).size.height*0.1),
                Container(
                    height: 40,
                    width: MediaQuery.of(context).size.height*0.15,
                    child: Image.asset("assets/images/logo.png")),
                Text("Welcome",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50),),
                verticalSpace(50),
                //FirstName
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: TextStyle(fontSize: 17),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    //contentPadding: EdgeInsets.all(20),
                  ),

                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!isEmail(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                verticalSpace(25),
                TextFormField(
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    hoverColor: kPrimaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        // Update the state i.e. toggle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty || value==null) {
                      return "This field is required";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                verticalSpace(10),
                 Align(alignment: Alignment.bottomRight,child: GestureDetector(onTap:(){
                   PersistentNavBarNavigator.pushNewScreen(
                     context,
                     screen: const AccountRecoveryScreen(),
                     withNavBar: false,
                     pageTransitionAnimation: PageTransitionAnimation.cupertino,
                   );
                 },
                     child: Text("Forgot password")),),
                verticalSpace(10),
                kTextButton(text: "Login", width: MediaQuery.of(context).size.width*0.4, onPressed: ()async{
                  if (_formKey.currentState!.validate()) {
                     await authServices.loginUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value){
                      if(value==null){
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const HomeScreen(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      }
                     });



                    // If the form is valid, navigate to home page



                  }
                }),
                verticalSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont have an account?"),
                    SizedBox(width: 5.0),

                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const SignUpScreen(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
