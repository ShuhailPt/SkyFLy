import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import '../ModelClass/modelClass.dart';

class MainProvider extends ChangeNotifier{

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  final Map<String, String> loginMap = {
    "UserName": "Dev@gmail.com",
    "PassWord": "123456",
  };

  final List<AirportModel> airportList = [
    AirportModel(city: "New York", iataCode: "JFK"),
    AirportModel(city: "Los Angeles", iataCode: "LAX"),
    AirportModel(city: "Chicago", iataCode: "ORD"),
    AirportModel(city: "Houston", iataCode: "IAH"),
    AirportModel(city: "San Francisco", iataCode: "SFO"),
    AirportModel(city: "Miami", iataCode: "MIA"),
    AirportModel(city: "Dallas", iataCode: "DFW"),
    AirportModel(city: "Seattle", iataCode: "SEA"),
  ];

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  String fromIataCode = '';
  String fromCity = '';
  String toIataCode = '';
  String toCity = '';

  void fromSelect(String code,String city){
    fromIataCode=code;
    fromCity=city;
    notifyListeners();
}

void toSelect(String code,String city){
    toIataCode=code;
    toCity=city;
    notifyListeners();
}

  String selectedDate="";
  String nextDate="";
  String nextNextDate="";
  List<TabData> tabs = [];

  void setSelectedDate(DateTime date, DateTime next, DateTime nextNext) {
    selectedDate = DateFormat('EEE, dd MMM').format(date);
    nextDate = DateFormat('EEE, dd MMM').format(next);
    nextNextDate = DateFormat('EEE, dd MMM').format(nextNext);

    tabs = [
      TabData(title: selectedDate, price: '₹4,942'),
      TabData(title: nextDate, price: '₹7,142'),
      TabData(title: nextNextDate, price: '₹9,242'),
    ];

    notifyListeners();
  }



  Future<void> login() async {

    await Future.delayed(const Duration(seconds: 2));

    if (usernameController.text == loginMap["UserName"] && passwordController.text == loginMap["PassWord"]) {
      _isLoggedIn = true;
      notifyListeners();
    } else {
      throw Exception("Invalid credentials");
    }
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
  final List<String> businessSeats = [
    'A1', 'B1', 'C1', 'D1',
    'A2', 'B2', 'C2', 'D2',
    'A3', 'B3', 'C3', 'D3',
    'A4', 'B4', 'C4', 'D4',
  ];

  final List<String> economySeats = [
    'A5', 'B5', 'C5', 'D5',
    'A6', 'B6', 'C6', 'D6',
    'A7', 'B7', 'C7', 'D7',
    'A8', 'B8', 'C8', 'D8',
  ];

  Set<String> selectedSeats = {};
  Set<String> reservedSeats = {'C2', 'D2'};

  bool isSeatSelected(String seat) => selectedSeats.contains(seat);

  bool isSeatReserved(String seat) => reservedSeats.contains(seat);

  void seatSelection(String seat) {
    if (isSeatReserved(seat)) return;

    if (isSeatSelected(seat)) {
      selectedSeats.remove(seat);
    } else {
      selectedSeats.add(seat);
    }
    notifyListeners();
  }

  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> downloadBoardingPass(BuildContext context) async {
    final Uint8List? imageBytes = await screenshotController.capture();

    if (imageBytes != null) {
      final pdf = pw.Document();
      final image = pw.MemoryImage(imageBytes);

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(image),
            );
          },
        ),
      );

      final directory = await getApplicationDocumentsDirectory();
      final path = "${directory.path}/boarding_pass_1.pdf";
      final file = File(path);

      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Boarding Pass saved at $path')),
      );
    }
  }


}