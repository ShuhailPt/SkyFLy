import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sky_fly/Constants/MyColors.dart';
import 'package:sky_fly/Controller/main_provider.dart';
import 'package:sky_fly/View/refactor_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import 'package:screenshot/screenshot.dart';

class BoardingPassScreen extends StatelessWidget {
  final String count;


  BoardingPassScreen({super.key, required this.count});



  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: clr1,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black, size: 14),
              onPressed: () => Navigator.pop(context),
            ),
            Text('Boarding Pass',
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(width: 30), // Placeholder for spacing
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
        child: Consumer<MainProvider>(
          builder: (context,val,child) {
            return SingleChildScrollView(
              child: Screenshot(
                controller: val.screenshotController,
                child: Consumer<MainProvider>(
                  builder: (context, val, child) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 25),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(val.fromIataCode,
                                            style: GoogleFonts.poppins(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600)),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(flex: 2, child: CustomDashedLine()),
                                        Column(
                                          children: [
                                            Container(
                                              height: 33,
                                              width: 33,
                                              decoration: BoxDecoration(
                                                color: mainClr6,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(Icons.flight,
                                                  size: 20, color: mainClr3),
                                            ),
                                          ],
                                        ),
                                        Expanded(flex: 2, child: CustomDashedLine()),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(val.toIataCode,
                                            style: GoogleFonts.poppins(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(val.fromCity,
                                            style:
                                            GoogleFonts.poppins(color: Colors.grey)),
                                        SizedBox(
                                          width: 90,
                                          child: Text("11h 50m",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.grey, fontSize: 12)),
                                        ),
                                        Text(val.toCity,
                                            style:
                                            GoogleFonts.poppins(color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              CustomDashedLine(),
                              SizedBox(height: 10),

                              // Flight Number and Price

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Text('RAJKUMAR SELVAM',
                                    style: GoogleFonts.poppins(
                                        fontSize: 18, fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 5, right: 35, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Flight',
                                            style:
                                            GoogleFonts.poppins(color: Colors.grey)),
                                        SizedBox(
                                          width: 80,
                                          child: Text('LY 2465',
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Terminal',
                                            style:
                                            GoogleFonts.poppins(color: Colors.grey)),
                                        SizedBox(
                                          width: 85,
                                          child: Text('3',
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 5, right: 35, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Gate',
                                            style:
                                            GoogleFonts.poppins(color: Colors.grey)),
                                        Text('LY 2465',
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                            )),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Class',
                                            style:
                                            GoogleFonts.poppins(color: Colors.grey)),
                                        Text('Business',
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 5, right: 35, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Depart',
                                            style:
                                            GoogleFonts.poppins(color: Colors.grey)),
                                        Text('14 Jan 13:20',
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                            )),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Passport ID',
                                            style:
                                            GoogleFonts.poppins(color: Colors.grey)),
                                        Text('PH552122',
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  TriangleDashedLine(
                                    isStart: true,
                                    clr: clr1,
                                  ),
                                  Expanded(flex: 3, child: CustomDashedLine()),
                                  TriangleDashedLine(
                                    isStart: false,
                                    clr: clr1,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                  child: Image(
                                    image: AssetImage("assets/barCode.png"),
                                    height: 80,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          }
        ),
      ),
      floatingActionButton: Consumer<MainProvider>(
        builder: (context,val,child) {
          return InkWell(
            onTap: () {
              val.downloadBoardingPass(context);
            },
            child: Container(
              width: width / 1.4,
              height: 50,
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
                  "Download Ticket",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
