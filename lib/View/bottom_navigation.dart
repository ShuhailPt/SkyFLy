import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_fly/Controller/main_provider.dart';
import 'package:sky_fly/View/home_screen.dart';

import '../Constants/MyColors.dart';
import 'flight_select_screen.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(),
    Center(child: Text('Search Page')),
    Center(child: Text('Messages Page')),
    Center(child: Text('Profile Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_pages[_selectedIndex],
      floatingActionButton:

      Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [mainClr, mainClr3],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          shape: BoxShape.circle,
        ),
        child:Consumer<MainProvider>(
          builder: (context, val, child) {
            return FloatingActionButton(
              onPressed: () async {
                if (val.fromCity.isEmpty || val.toCity.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select both From and To locations.")),
                  );
                } else {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)), // Limit to next year
                  );
                  if (selectedDate != null) {
                    DateTime nextDay = selectedDate.add(Duration(days: 1));
                    DateTime nextNextDay = selectedDate.add(Duration(days: 2));
                    val.setSelectedDate(selectedDate, nextDay, nextNextDay);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FlightBookingScreen()),
                    );
                  }
                }
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Icon(Icons.flight, size: 30, color: Colors.white),
            );
          },
        )


      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: clBg
            ),
            child: ClipRRect(

              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: BottomAppBar(
                notchMargin: 8,
                shape: AutomaticNotchedShape(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  CircleBorder(),
                ),
                color: clr1,
                child: Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.home_outlined),
                        color: _selectedIndex == 0 ? mainClr2: Colors.grey,
                        onPressed: () => _onItemTapped(0),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        color: _selectedIndex == 1 ? mainClr2: Colors.grey,
                        onPressed: () => _onItemTapped(1),
                      ),
                      SizedBox(width: 60), // Space for FAB
                      IconButton(
                        icon: Icon(Icons.chat_bubble_outline),
                        color: _selectedIndex == 2 ? mainClr2: Colors.grey,
                        onPressed: () => _onItemTapped(2),
                      ),
                      IconButton(
                        icon: Icon(Icons.person_outline),
                        color: _selectedIndex == 3 ? mainClr2: Colors.grey,
                        onPressed: () => _onItemTapped(3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Top Indicator
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 3,
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: _selectedIndex == 0 ? mainClr2: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 3,
                    decoration: BoxDecoration(
                      color: _selectedIndex == 1 ? mainClr2: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.15), // Space for FAB
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 3,
                    decoration: BoxDecoration(
                      color: _selectedIndex == 2 ? mainClr2: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 3,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: _selectedIndex == 3 ? mainClr2: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}