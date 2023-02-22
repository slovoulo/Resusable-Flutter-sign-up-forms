import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:transit_app/screens/authScreens/landingScreen.dart';
import 'package:transit_app/screens/authScreens/signUpScreen.dart';

import '../../constants.dart';
import '../../services/authServices.dart';

class AccountRecoveryScreen extends StatefulWidget {
  const AccountRecoveryScreen({Key? key}) : super(key: key);

  @override
  State<AccountRecoveryScreen> createState() => _AccountRecoveryScreenState();
}

class _AccountRecoveryScreenState extends State<AccountRecoveryScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool isEmail(String input) => EmailValidator.validate(input);
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
                verticalSpace(MediaQuery.of(context).size.height * 0.1),
                const Text(
                  "Forgot password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const Text(
                    "Enter the email address you used to sign up. If an account exists with that email, you will receive a password reset link"),
                verticalSpace(50),
                //FirstName
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: const TextStyle(fontSize: 17),
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
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

                verticalSpace(10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Back to login")),
                ),
                verticalSpace(10),
                kTextButton(
                    text: "Send",
                    width: MediaQuery.of(context).size.width * 0.4,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await authServices
                            .resetPasswordWithEmail(
                          email: emailController.text,
                        )
                            .then((value) {
                          if (value == null) {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: const LandingScreen(),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          }
                        });
                      }
                    }),
                verticalSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dont have an account?"),
                    const SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {
                        //Navigate to a new screen and clear all previous screens
                        Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => const SignUpScreen(),
                          ),
                              (route) => false,//if you want to disable back feature set to false
                        );
                      },
                      child: const Text(
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
