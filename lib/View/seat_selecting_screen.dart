import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sky_fly/Controller/main_provider.dart';
import 'package:sky_fly/View/boarding_pass_Screen.dart';

import '../Constants/MyColors.dart';

class SeatSelectionPage extends StatelessWidget {
   String date,fromTime,toTime,price;

   SeatSelectionPage({super.key,
     required this.date,
     required this.fromTime,
     required this.toTime,
     required this.price,
   });



  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: clr1,
      appBar:AppBar(
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
              child:Text('Selecting Seat', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),

            ),
            SizedBox(),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share_outlined,color: mainClr3,),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<MainProvider>(
        builder: (context,val,child) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        '${val.fromIataCode} ➔ ${val.toIataCode}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      _buildSeatLegend(),
                      const SizedBox(height: 20),
                      ClipPath(
                        clipper: AirplaneClipper(),
                        child: Container(
                          height: height / 1.4,
                          width: width / 1.5,
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 50),
                                Column(
                                  children: [

                                    Icon(Icons.grid_view_rounded,color: Colors.orange[300],),
                                    const Text(
                                      'BHARATH',
                                      style: TextStyle(fontSize: 16, color: mainClr2,fontWeight: FontWeight.w600),
                                    ),
                                    const Text(
                                      'AIRWAYS',
                                      style: TextStyle(fontSize: 12, color: mainClr2,fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height/12,),
                                _buildSeatGrid(val.businessSeats, 'Business Class',height/5.4),
                                const SizedBox(height: 20),
                                _buildSeatGrid(val.economySeats, 'Economy Class',height/4.5),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 10),
                  ],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSummaryItem('Class', 'Business'),
                        _buildSummaryItem('Passengers', '${val.selectedSeats.length} Adults'),
                        _buildSummaryItem('Seats', val.selectedSeats.join(', ')),
                      ],
                    ),
                    const SizedBox(height: 16),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Price',
                              style:  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            const SizedBox(height: 4),

                            Text(
                              '₹ 7,858',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            if(val.selectedSeats.isNotEmpty){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> BoardingPassScreen(count: '',)));
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(" Plaese select seat")),

                              );
                            }


                          },
                          child: Container(
                            height: 45,
                            width: width/2.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: const LinearGradient(
                                colors: [mainClr, mainClr3],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child:  const Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Place Order',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }


  Widget _buildSeatLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(Colors.grey[400]!, 'Reserved'),
        _buildLegendItem(mainClr7!, 'Available'),
        _buildLegendItem(Colors.orange[300]!, 'Selected'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildSeatGrid(List<String> seats, String title,double height) {
    // var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: mainClr2),
        ),
        const SizedBox(height: 10),
        Container(
          height: height,
          width: 200,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 1.5,
            ),
            itemCount: seats.length,
            itemBuilder: (context, index) {
              String seat = seats[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: (index % 2 == 0) ? 0 : 12,
                  left: (index % 2 == 0) ? 12 : 0,
                ),
                child: _buildSeatItem(seat,context),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSeatItem(String seat,BuildContext context) {
    MainProvider mainProvider =Provider.of<MainProvider>((context),listen: false);
    final isReserved = mainProvider.isSeatReserved(seat);
    final isSelected = mainProvider.isSeatSelected(seat);



    Color seatColor;
    if (isReserved) {
      seatColor = Colors.grey[400]!;
    } else if (isSelected) {
      seatColor = Colors.orange[300]!;
    } else {
      seatColor = mainClr7!;
    }

    return GestureDetector(
      onTap: () {
        if (!isReserved) {
          mainProvider.seatSelection(seat);

        }
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            seat,
            style: TextStyle(
              color: isReserved ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class AirplaneClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(
      size.width * 0.5, -size.height * 0.4,
      size.width, size.height * 0.4,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}