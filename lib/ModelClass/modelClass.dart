class AirportModel {
  final String city;
  final String iataCode;
  String get airportName => "$city ($iataCode)";

  AirportModel({required this.city, required this.iataCode});
}


class TabData {
  final String title;
  final String price;

  TabData({required this.title, required this.price});
}