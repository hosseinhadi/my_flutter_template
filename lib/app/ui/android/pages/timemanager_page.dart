import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_template/app/ui/android/widgets/circlepainter_widget.dart';

import 'package:scroll_snap_list/scroll_snap_list.dart';

class TimeManagerPage extends StatefulWidget {
  @override
  _TimeManagerPageState createState() => _TimeManagerPageState();
}

class _TimeManagerPageState extends State<TimeManagerPage> {
  double heightFactorOfTopSection = 0.55;
  double r1 = 0.06;
  double r2 = 0.11;
  double r3 = 0.11;
  double h1 = 50;
  final double paddingOfCalenderTable = 5;

  List<String> monthList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  int monthIndex = 1;

  Widget _createCalenderDaysItem({
    @required int number,
    double progress = 0,
    List<Color> colors = null,
    bool active = true,
    bool holiday = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingOfCalenderTable),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 1.3,
              value: progress,
              valueColor: AlwaysStoppedAnimation<Color>(
                active
                    ? Colors.purple
                    : Color.lerp(Colors.purple, Colors.white, 0.8),
              ),
            ),
            Positioned(
              // alignment: Alignment.bottomCenter,
              bottom: 6,
              width: 20,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = Random().nextInt(6); i > 0; i--)
                    Circle(
                      center: Offset(0, 0),
                      radius: 1.5,
                      color: Color(Random().nextInt(0xffffffff)),
                      strokeWidth: 1,
                    ),
                ],
              ),
            ),
            Text(
              '$number',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: active
                      ? (holiday ? Colors.red : Colors.black)
                      : Colors.black26),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _createCalenderDaysRow(
      {int startInt = 28,
      int previousMonthDaysCount = 29,
      int thisMonthDaysCount = 30,
      @required int rowIndex}) {
    bool thisMonthReached = false;
    bool nextMonthReached = false;
    if (startInt == 1) thisMonthReached = true;
    int daysCounted = 0;
    List<Widget> daysWidget = [];
    for (int i = startInt;; i++) {
      daysCounted++;
      if (daysCounted > 5 * 7) break;
      if (i > previousMonthDaysCount && thisMonthReached == false) {
        i = 1;
        thisMonthReached = true;
      }
      if (i > thisMonthDaysCount && nextMonthReached == false) {
        i = 1;
        nextMonthReached = true;
      }

      daysWidget.add(
        _createCalenderDaysItem(
          number: i,
          active: thisMonthReached && (!nextMonthReached),
          progress: Random().nextDouble(),
          colors: null,
          holiday: (daysCounted % 7 == 0) ? true : false,
        ),
      );
    }
    return TableRow(
      children:
          daysWidget.getRange(7 * (rowIndex), 7 * (rowIndex) + 7).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF39005F),
              ),
            ),
            FractionallySizedBox(
              heightFactor: 1 -
                  heightFactorOfTopSection +
                  r3 * Get.context.width / Get.context.height,
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    // color: Color(0x00000000),
                    ),
                child: Placeholder(),
              ),
            ),
            FractionallySizedBox(
              heightFactor: heightFactorOfTopSection,
              alignment: Alignment.topCenter,
              widthFactor: 1,
              child: ClipPath(
                clipBehavior: Clip.antiAlias,
                clipper: MyTopSectionClipper(
                  r1: r1,
                  r2: r2,
                  r3: r3,
                  h1: h1,
                ),
                child: SingleChildScrollView(
                  // clipBehavior: ,

                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    padding: EdgeInsets.fromLTRB(r1 * Get.context.width, 16,
                        r1 * Get.context.width + 10, r3 * Get.context.width),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 50,
                          child: Expanded(
                            child: ScrollSnapList(
                              dynamicItemSize: true,
                              itemSize: 100,
                              dynamicItemOpacity: 0.3,
                              onItemFocus: (index) {
                                print('Focused on item $index');
                              },
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        height: 30,
                                        width: 100,
                                        // color: Colors.lightBlueAccent,
                                        child: Center(
                                          child: Text("${monthList[index]}"),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: monthList.length,
                              reverse: false,
                            ),
                          ),
                        ),
                        Table(
                          // border: TableBorder.all(),
                          children: [
                            TableRow(
                              children: [
                                for (String s in [
                                  'S',
                                  'S',
                                  'M',
                                  'T',
                                  'W',
                                  'T',
                                  'F'
                                ])
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: paddingOfCalenderTable),
                                    child: Text(
                                      '$s',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                              ],
                            ),
                            _createCalenderDaysRow(
                              rowIndex: 0,
                              previousMonthDaysCount: 29,
                              startInt: 27,
                              thisMonthDaysCount: 30,
                            ),
                            _createCalenderDaysRow(
                              rowIndex: 1,
                              previousMonthDaysCount: 29,
                              startInt: 27,
                              thisMonthDaysCount: 30,
                            ),
                            _createCalenderDaysRow(
                              rowIndex: 2,
                              previousMonthDaysCount: 29,
                              startInt: 27,
                              thisMonthDaysCount: 30,
                            ),
                            _createCalenderDaysRow(
                              rowIndex: 3,
                              previousMonthDaysCount: 29,
                              startInt: 27,
                              thisMonthDaysCount: 30,
                            ),
                            _createCalenderDaysRow(
                              rowIndex: 4,
                              previousMonthDaysCount: 29,
                              startInt: 27,
                              thisMonthDaysCount: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              // width: double.infinity,
              // height: double.infinity,
              // left: 0,

              child: Container(
                color: Colors.white,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: null,
                ),
                // child: Placeholder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTopSectionClipper extends CustomClipper<Path> {
  /// reverse the wave direction in vertical axis
  // bool reverse;
  final double r3;
  final double r2;
  final double r1;
  final double h1;

  /// flip the wave direction horizontal axis
  // bool flip;

  MyTopSectionClipper(
      {this.r1 = 0.15, this.r2 = 0.13, this.r3 = 0.07, this.h1 = 50});

  @override
  Path getClip(Size size) {
    // Offset firstEndPoint = Offset(size.width * .53, size.height - 20);
    // Offset firstControlPoint = Offset(size.width * .21, size.height - 30);
    // Offset secondEndPoint = Offset(size.width, size.height - 50);
    // Offset secondControlPoint = Offset(size.width * .75, size.height - 10);

    // var r1;
    final path = Path()
      ..lineTo(0.0, size.height)
      ..relativeArcToPoint(
        Offset(
          r3 * size.width,
          -r3 * size.width,
        ),
        clockwise: true,
        largeArc: false,
        radius: Radius.circular(r3 * size.width),
      )
      ..lineTo(
        size.width - (r1 + r2) * size.width,
        size.height - (r3) * size.width,
      )
      ..relativeArcToPoint(
        Offset(
          r2 * size.width,
          -r2 * size.width,
        ),
        clockwise: false,
        largeArc: false,
        radius: Radius.circular(r2 * size.width),
      )
      ..lineTo((1 - r1) * size.width, h1 + r1 * size.width)
      ..arcToPoint(
        Offset(
          size.width,
          h1,
        ),
        clockwise: true,
        largeArc: false,
        radius: Radius.circular(r1 * size.width),
      )
      ..lineTo(size.width, 0)
      ..close();
    return path;
    // if (!reverse) {
    //   return path;
    // }
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
