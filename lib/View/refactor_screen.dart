import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sky_fly/Controller/main_provider.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../Constants/MyColors.dart';
import '../ModelClass/modelClass.dart';

class FlightSelectionWidget extends StatelessWidget {
  Widget buildAutocomplete({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    required bool isFrom,
  }) {
    return Consumer<MainProvider>(
      builder: (context,val,child) {
        return Autocomplete<AirportModel>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            return val.airportList
                .where((element) => element.airportName
                .toUpperCase()
                .contains(textEditingValue.text.toUpperCase()))
                .toList();
          },
          displayStringForOption: (AirportModel item) => item.airportName,
          fieldViewBuilder: (BuildContext context,
              TextEditingController fieldTextEditingController,
              FocusNode fieldFocusNode,
              VoidCallback onFieldSubmitted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              fieldTextEditingController.text = controller.text;
            });

            return TextFormField(
              onTapOutside: (value) {
                fieldFocusNode.unfocus();
              },
              decoration: InputDecoration(
                labelText: label,
                border: InputBorder.none,
                labelStyle: TextStyle(color: Colors.grey),
              ),
              controller: fieldTextEditingController,
              focusNode: fieldFocusNode,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            );
          },
          onSelected: (AirportModel selection) {
            controller.text = selection.city;
            if(isFrom) {
              val.fromSelect(selection.iataCode,selection.city);
            }else{
              val.toSelect(selection.iataCode,selection.city);
            }
            FocusScope.of(context).unfocus();



          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<AirportModel> onSelected,
              Iterable<AirportModel> options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                child: Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.white,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      AirportModel option = options.elementAt(index);

                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                          // String as=onSelected(option.iataCode);
                        },
                        child: Container(
                          color: Colors.white,
                          height: 50,
                          width: double.infinity,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  option.airportName.toUpperCase(),
                                  style: GoogleFonts.karma(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10)
                              ]
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        width: width,
        height: height/4.5,
        decoration: BoxDecoration(
          color: clWhite,
          borderRadius: BorderRadius.circular(10),
        ),

        padding: EdgeInsets.symmetric( vertical: 12), // Adjust padding for less vertical space
        child: Consumer<MainProvider>(
          builder: (context,val,child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(Icons.flight_takeoff, color: black2),
                      SizedBox(width: 10),
                      Expanded(
                        child:      buildAutocomplete(
                          controller: val.fromController,
                          icon: Icons.flight_takeoff, label: 'From', isFrom: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    RoundedDashedLine(isStart: true, clr: clBg,),
                    Expanded(flex: 3, child: CustomDashedLine()),
                    Container(
                      height: 34, // Smaller icon button container
                      width: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.swap_vert, color: Colors.pink, size: 18),
                          onPressed: () {
                            // Swap action
                          },
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: CustomDashedLine()),
                    RoundedDashedLine(isStart: false, clr: clBg,),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(Icons.flight_land, color: black2),
                      SizedBox(width: 10),
                      Expanded(
                        child:   buildAutocomplete(
                          controller: val.toController,
                          icon: Icons.flight_land, label: 'To', isFrom: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}

class CustomDashedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        const dashSpace = 3.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();

        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
              ),
            );
          }),
        );
      },
    );
  }
}


class RoundedDashedLine extends StatelessWidget {
  final bool isStart;
  Color clr;

   RoundedDashedLine({super.key, required this.isStart,required this.clr});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: clr,
        borderRadius: isStart
            ? BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        )
            : BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
    );
  }
}

class TriangleDashedLine extends StatelessWidget {
  final bool isStart;
  final Color clr;

  TriangleDashedLine({super.key, required this.isStart, required this.clr});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(10, 10), // Size of the triangle
      painter: TrianglePainter(isStart: isStart, color: clr),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final bool isStart;
  final Color color;

  TrianglePainter({required this.isStart, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    if (isStart) {
      // Draw a triangle pointing right
      path.moveTo(0, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(0, size.height);
    } else {
      // Draw a triangle pointing left
      path.moveTo(size.width, 0);
      path.lineTo(0, size.height / 2);
      path.lineTo(size.width, size.height);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}