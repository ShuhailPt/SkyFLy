import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sky_fly/Controller/main_provider.dart';
import 'package:sky_fly/View/refactor_screen.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../Constants/MyColors.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: clBg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: height/3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bgImage.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Container(
                  height: height/3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.only(top: height/15, left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your image asset
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hello !", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
                              Text("RajaKumar", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.notifications_none, color: Colors.white),
                    ],
                  ),
                ),

                Positioned(
                  bottom: 40,
                  left: 16,
                  child: SizedBox(
                    width: 170,
                    child: Text(
                      "Where are you flying to?",
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FlightSelectionWidget(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Suggested For You", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Text("View All", style: GoogleFonts.poppins(color: mainClr2)),
                          Icon(Icons.arrow_right_alt_outlined,color: mainClr2,)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 170,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        buildSuggestedCard("Paris,France", "\$320", 'assets/paris.jpg'),
                        buildSuggestedCard("Kenya,Kenya", "\$520", 'assets/city2.jpg'),
                        buildSuggestedCard("New York, USA", "\$430", 'assets/city3.jpg'),
                        buildSuggestedCard("New York, USA", "\$430", 'assets/city4.jpg'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Upcoming Trips", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Text("View All", style: GoogleFonts.poppins(color: mainClr2)),
                          Icon(Icons.arrow_right_alt_outlined,color: mainClr2,)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(0, 2),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Consumer<MainProvider>(
                      builder: (context,val,child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("24 Oct, 09:40", style: GoogleFonts.poppins(color: Colors.grey)),
                                val.fromIataCode==""?
                                Text("LAS", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)):
                                Text(val.fromIataCode, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                                val.fromCity==""?
                                Text("Los Angeles", style: GoogleFonts.poppins(color: Colors.grey)):
                                Text(val.fromCity, style: GoogleFonts.poppins(color: Colors.grey)),
                              ],
                            ),
                            ImageIcon(AssetImage("assets/flight.png"), size: 35, color: black2),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("11:10", style: GoogleFonts.poppins(color: Colors.grey)),
                                val.toIataCode==""?
                                Text("SFO", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)):
                                Text(val.toIataCode, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                                val.toCity==""?
                                Text("San Francisco", style: GoogleFonts.poppins(color: Colors.grey)):
                                Text(val.toCity, style: GoogleFonts.poppins(color: Colors.grey)),
                              ],
                            ),
                          ],
                        );
                      }
                    ),
                  ),

                ],
              ),

            ),
            SizedBox(height: 30,),
          ],
        ),
      ),

    );
  }

  Widget buildSuggestedCard(String location, String price, String imagePath) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 140,
      // height: 220,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(imagePath, height:110, width: double.infinity, fit: BoxFit.cover),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(location, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              Text(price, style: GoogleFonts.poppins(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}