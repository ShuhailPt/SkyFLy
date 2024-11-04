import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sky_fly/Controller/main_provider.dart';
import 'package:sky_fly/View/home_screen.dart';

import '../Constants/MyColors.dart';
import 'bottom_navigation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: Consumer<MainProvider>(
          builder: (context, val, child) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                      height: height / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: clr1,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Login to go where you leave",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500, fontSize: 22),
                            ),
                          ),
                          Image.asset("assets/fly.png", scale: height / 70),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Welcome Back",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 22),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Enter details to setup your account back",
                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: val.usernameController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.mail_outlined, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: fieldClr,
                        hintText: "Email id",
                        hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: val.passwordController,
                      decoration: InputDecoration(
                        suffixIcon:
                        Icon(Icons.remove_red_eye_outlined, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: fieldClr,
                        hintText: "Password",
                        hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.poppins(fontSize: 16, color: mainClr2),
                      ),
                    ),
                    SizedBox(height: height / 15),
                    Consumer<MainProvider>(
                      builder: (context, val, child) {
                        return InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                await val.login();
                                if (val.isLoggedIn) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Login successful!")),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BottomNavigation(),
                                    ),
                                  );
                                }
                              } catch (e) {
                                // Show relevant error message
                                if (val.usernameController.text !=
                                    val.loginMap["UserName"]) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Invalid User Name")),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Invalid Password")),
                                  );
                                }
                              }
                            }
                          },
                          child: Container(
                            height: 43,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                colors: [mainClr, mainClr3],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Log in",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
