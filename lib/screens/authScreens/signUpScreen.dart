import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:transit_app/constants.dart';
import '../../services/authServices.dart';
import '../main_navigation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isEmail(String input) => EmailValidator.validate(input);
  bool _passwordVisible = false;
  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: SingleChildScrollView(
            child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          verticalSpace(
                              MediaQuery.of(context).size.height * 0.1),
                          SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.height * 0.15,
                              child: Image.asset("assets/images/logo.png")),
                          const Text(
                            "Welcome",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 50),
                          ),

                          //FirstName
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintStyle: const TextStyle(fontSize: 17),
                              hintText: 'First name',
                              prefixIcon: const Icon(Icons.person),
                              //contentPadding: EdgeInsets.all(20),
                            ),
                            controller: firstnameController,

                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'First name is required';
                              }
                              return null;
                            },
                          ),
                          verticalSpace(10),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),

                              hintStyle: const TextStyle(fontSize: 17),
                              hintText: 'Last name',
                              prefixIcon: const Icon(Icons.person),

                            ),
                            controller: lastnameController,

                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Last name is required';
                              }
                              return null;
                            },
                          ),
                          //LastName
                          verticalSpace(10),
                          //Email
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintStyle: const TextStyle(fontSize: 17),
                              hintText: 'Email',
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
                          verticalSpace(10),
                          TextFormField(
                            controller: passwordController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
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
                              if (value!.isEmpty) {
                                return "This field is required";
                              }
                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          verticalSpace(10),
                          TextFormField(
                            controller: confirmPasswordController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Confirm Password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
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
                              if (value!.isEmpty) {
                                return "This field is required";
                              }
                              if (value != passwordController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                          ),
                          verticalSpace(10),

                          //Password

                          kTextButton(
                              text: "Sign Up",
                              width: MediaQuery.of(context).size.width * 0.4,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, create a new user

                                  await authServices
                                      .createUserWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          firstName: firstnameController.text,
                                          lastName: lastnameController.text,
                                          pushNewScreen: () {
                                            //Navigate to a new screen and clear all previous screens
                                            Navigator.pushAndRemoveUntil<
                                                dynamic>(
                                              context,
                                              MaterialPageRoute<dynamic>(
                                                builder:
                                                    (BuildContext context) =>
                                                        const MainNavigationPage(),
                                              ),
                                              (route) =>
                                                  false, //if you want to disable back feature set to false
                                            );
                                          });


                                }
                              })
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(30)
                ]),
          ),
        ),
      ),
    );
  }
}
