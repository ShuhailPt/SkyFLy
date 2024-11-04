import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sky_fly/Constants/MyColors.dart';
import 'package:sky_fly/Controller/main_provider.dart';
import 'package:sky_fly/View/refactor_screen.dart';
import 'package:sky_fly/View/seat_selecting_screen.dart';

import '../ModelClass/modelClass.dart';

class FlightBookingScreen extends StatefulWidget {
  @override
  _FlightBookingScreenState createState() => _FlightBookingScreenState();
}

class _FlightBookingScreenState extends State<FlightBookingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<String>fromTime=[
    "08:05",
    "09:45",
    "12:35",
    "16:20",
    "20:30",
    "23:10",
  ];

  List<String>toTime=[
    "23:10",
    "20:30",
    "16:20",
    "12:35",
    "09:45",
    "08:05",
  ];

  List<String>price=[
    "₹ 6,741",
    "₹ 8,500",
    "₹ 7,300",
    "₹ 6,563",
    "₹ 6,401",
    "₹ 6,900",
  ];



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clBg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black, size: 14,),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            Center(
              child: Consumer<MainProvider>(
                builder: (context,val,child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(val.fromIataCode, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Icon(Icons.arrow_forward, size: 20),
                      ),
                      Text(val.toIataCode, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  );
                }
              ),
            ),
            SizedBox(),
          ],
        ),
        actions: [
          IconButton(
            icon: ImageIcon(AssetImage("assets/filter.png")),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Consumer<MainProvider>(
            builder: (context,val,child) {
              return TabBar(
                controller: _tabController,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                indicatorColor: Colors.transparent,
                tabs: List.generate(3, (index) {
                  return CustomTab(
                    data: val.tabs[index],
                    isSelected: _tabController.index == index,
                    onTap: () {
                      setState(() {
                        _tabController.animateTo(index);
                      });
                    },
                  );
                }),
              );
            }
          ),
        ),
      ),
      body: Consumer<MainProvider>(
        builder: (context,val,child) {
          return TabBarView(
            controller: _tabController,
            children: val.tabs.map((tab) => _buildFlightList()).toList(),
          );
        }
      ),
    );
  }

  Widget _buildFlightList() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Consumer<MainProvider>(
          builder: (context,val,child) {
            return Column(
              children: [
                ListView.builder(
                  itemCount: price.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext contex,int index){
                      return Consumer<MainProvider>(
                        builder: (context,val,child) {
                          return InkWell(
                            onTap: () {
                              String date = "";
                              if (_tabController.index == 0) {
                                date = val.selectedDate;
                              } else if (_tabController.index == 1) {
                                date = val.nextDate;
                              } else {
                                date = val.nextNextDate;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SeatSelectionPage(date: date, fromTime: fromTime[index], toTime:toTime[index], price: price[index],),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [mainClr5, clWhite],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          color: Color(0xFFFCE4EC),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(12)),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.restaurant_menu, size: 16, color: mainClr2),
                                            SizedBox(width: 4),
                                            RichText(text: TextSpan(
                                                text: "From ",
                                                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: "Meal",
                                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: mainClr2)
                                                  )
                                                ]
                                            ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),

                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(fromTime[index],
                                                style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                                            SizedBox(width: 15,),
                                            Expanded(flex: 2, child: CustomDashedLine()),
                                            Container(
                                              height: 33,
                                              width: 33,
                                              decoration: BoxDecoration(
                                                color: mainClr6,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(Icons.flight, size: 20, color: mainClr3),
                                            ),
                                            Expanded(flex: 2, child: CustomDashedLine()),
                                            SizedBox(width: 15,),
                                            Text(toTime[index],
                                                style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),

                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(val.fromIataCode, style: GoogleFonts.poppins(color: Colors.grey)),
                                            RichText(text: TextSpan(
                                                text: "11h 50m ",
                                                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: " • Non-Stop",
                                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black)
                                                  )
                                                ]
                                            )),
                                            Text(val.toIataCode, style: GoogleFonts.poppins(color: Colors.grey)),

                                          ],
                                        ),
                                      ),


                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  CustomDashedLine(),
                                  SizedBox(height: 5),

                                  // Flight Number and Price
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('LY 2465', style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold)),
                                        Text(price[index],
                                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      );

                })
              ],
            );
          }
        ),
      ),
    );
  }



}

class CustomTab extends StatelessWidget {
  final TabData data;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTab({
    Key? key,
    required this.data,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? mainClr2 : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Column(
          children: [
            Text(
              data.title,
              style: GoogleFonts.poppins(
                color: isSelected ? Colors.black : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            SizedBox(height: 4),
            Text(
              data.price,
              style: GoogleFonts.poppins(
                color: isSelected ? Colors.black : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
