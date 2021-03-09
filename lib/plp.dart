import 'dart:convert';

import 'package:date_util/date_util.dart';
import 'package:ecom_test/Model.dart';
import 'package:flip_panel/flip_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class PlpPage extends StatefulWidget {
  @override
  _PlpPageState createState() => _PlpPageState();
}

class _PlpPageState extends State<PlpPage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    final _selectedDay = DateTime.now();
    _events = {
      _selectedDay.subtract(Duration(days: 0)): [
        Item(
          'assets/mtr dosa.png',
          'Dosa Batter',
          '34.00',
          4.5,
          DateTime.now().subtract(new Duration(hours: 0, minutes: 10)),
          3,
          30,
        ),
        Item(
          'assets/mtr dosa.png',
          'Dosa Batter',
          '34.00',
          4.5,
          DateTime.now().subtract(new Duration(hours: 0, minutes: 10)),
          3,
          30,
        ),
        Item(
          'assets/mtr dosa.png',
          'Dosa Batter',
          '34.00',
          4.5,
          DateTime.now().subtract(new Duration(hours: 0, minutes: 10)),
          3,
          30,
        ),
        Item(
          'assets/mtr dosa.png',
          'Dosa Batter',
          '34.00',
          4.5,
          DateTime.now().subtract(new Duration(hours: 0, minutes: 10)),
          3,
          30,
        ),
        Item(
          'assets/mtr dosa.png',
          'Dosa Batter',
          '34.00',
          4.5,
          DateTime.now().subtract(new Duration(hours: 0, minutes: 10)),
          3,
          30,
        ),
      ],
      _selectedDay.add(Duration(days: 1)): [
        Item(
          'assets/mtr dosa.png',
          'Dosa Batter',
          '34.00',
          4.5,
          DateTime.now().add(new Duration(days: 1)),
          3,
          30,
        ),
        Item(
          'assets/mtr dosa.png',
          'Dosa Batter',
          '34.00',
          4.5,
          DateTime.now().add(new Duration(days: 1, hours: 1)),
          3,
          30,
        ),
      ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    print(_events.toString());
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });

    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  var dateUtility = DateUtil();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: width,
                    color: Color(0xfffbaf03),
                    padding: EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        Column(
                          children: [
                            Text(
                              'Popular this week - ' +
                                  DateFormat('MMMM').format(DateTime.now()),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '\nSelect day of the week to see the items',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xfffbaf03),
                    padding: EdgeInsets.only(top: 25, bottom: 0),
                    child: TableCalendar(
                      events: _events,
                      initialCalendarFormat: CalendarFormat.week,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(color: Colors.white),
                        weekendStyle: TextStyle(color: Colors.white),
                      ),
                      headerVisible: false,
                      calendarStyle: CalendarStyle(
                        markersColor: Colors.transparent,
                        canEventMarkersOverflow: true,
                        todayColor: Colors.white,
                        selectedColor: Colors.white10,
                        selectedStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        todayStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                        eventDayStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        weekdayStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        holidayStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                      // headerStyle: HeaderStyle(
                      //   centerHeaderTitle: true,
                      //   formatButtonDecoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(20.0),
                      //   ),
                      //   formatButtonTextStyle: TextStyle(
                      //     color: Color(0xfffbaf03),
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      //   formatButtonShowsNext: false,
                      // ),
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      onDaySelected: (date, events, holidays) {
                        setState(() {
                          _selectedEvents = events;
                        });
                      },
                      builders: CalendarBuilders(
                        selectedDayBuilder: (context, date, events) =>
                            Container(
                                margin: const EdgeInsets.all(0.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                        todayDayBuilder: (context, date, events) => Container(
                            margin: const EdgeInsets.all(0.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.4),
                            ),
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(
                                color: Colors.black.withOpacity(.7),
                              ),
                            )),
                      ),
                      calendarController: _controller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _selectedEvents.length,
                        itemBuilder: (BuildContext context, index) {
                          DateTime today = DateTime.now();
                          DateTime thatDay = _selectedEvents[index].packedTime;
                          Duration difference = today.isAfter(thatDay)
                              ? today.difference(thatDay)
                              : thatDay.difference(today);
                          return Card(
                            margin: EdgeInsets.only(
                                top: 15, right: 15, left: 15, bottom: 3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        _selectedEvents[index].imageUrl,
                                        width: width / 3.5,
                                      ),
                                      Stack(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _selectedEvents[index].name,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                      text: '\$ ' +
                                                          _selectedEvents[index]
                                                              .price,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: '/kg',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ]),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Packed Since:',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xfffbaf03),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Column(
                                                      children: [
                                                        FlipPanel<int>.stream(
                                                          itemStream:
                                                              Stream.periodic(
                                                                  Duration(
                                                                      hours: 1),
                                                                  (count) =>
                                                                      count %
                                                                      24),
                                                          itemBuilder: (context,
                                                                  value) =>
                                                              Container(
                                                            height: 27,
                                                            width: 25,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xff140d43),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4.0,
                                                                    vertical:
                                                                        2),
                                                            child: Center(
                                                              child: Text(
                                                                '$value'
                                                                    .padLeft(
                                                                        2, '0'),
                                                                style: GoogleFonts.benchNine(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        19.0,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          initValue: difference
                                                                  .inHours %
                                                              24,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'HOURS',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 7,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Column(
                                                      children: [
                                                        FlipPanel<int>.stream(
                                                          itemStream:
                                                              Stream.periodic(
                                                                  Duration(
                                                                      minutes:
                                                                          1),
                                                                  (count) =>
                                                                      count %
                                                                      60),
                                                          itemBuilder: (context,
                                                                  value) =>
                                                              Container(
                                                            height: 27,
                                                            width: 25,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xff140d43),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4.0,
                                                                    vertical:
                                                                        2),
                                                            child: Center(
                                                              child: Text(
                                                                '$value'
                                                                    .padLeft(
                                                                        2, '0'),
                                                                style: GoogleFonts.benchNine(
                                                                    fontSize:
                                                                        19.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          initValue: difference
                                                                  .inMinutes %
                                                              60,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'MINS',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 7,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: width - (width / 2.2),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                width: width / 6,
                                                height: 32,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.lightGreen),
                                                padding: EdgeInsets.all(0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.white,
                                                      size: 19,
                                                    ),
                                                    Text(
                                                      _selectedEvents[index]
                                                          .rating
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      new ItemCounter(),
                                      Container(
                                        width: width / 2,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Color(0xfffbaf03),
                                          borderRadius:
                                              BorderRadius.circular(width / 3),
                                        ),
                                        padding: EdgeInsets.all(0),
                                        child: Center(
                                          child: Text(
                                            'Add to Cart',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        _selectedEvents[index]
                                                .stockValue
                                                .toString() +
                                            ' kgs left of the day',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        '+' +
                                            _selectedEvents[index]
                                                .noOfOrders
                                                .toString() +
                                            ' people ordered today',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 20,
                left: 0,
                top: height - 180,
              ),
              child: Container(
                height: 70,
                width: width / 3.5,
                decoration: BoxDecoration(
                  color: Color(0xfffbaf03),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(-1, -1),
                      spreadRadius: 0.7,
                    ),
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(1, 1),
                      spreadRadius: 0.7,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(13),
                    bottomRight: Radius.circular(13),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'JUST NOW',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            padding: EdgeInsets.only(
                              left: 1,
                              top: 8,
                            ),
                            width: (width / 3.5) - 35,
                            child: Text(
                              'Philip Ordered Dosa batter',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ),
                              overflow: TextOverflow.clip,
                              softWrap: true,
                            ),
                          ),
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 25,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemCounter extends StatefulWidget {
  @override
  _ItemCounterState createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  int itemCount;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      itemCount = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.3,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xfffbaf03),
          width: 2,
        ),
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.width / 3.3),
      ),
      padding: EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.remove,
              color: Color(0xfffbaf03),
              size: 13,
            ),
            onPressed: () {
              setState(() {
                itemCount = itemCount > 1 ? itemCount - 1 : 1;
              });
            },
          ),
          Text(
            itemCount.toString(),
            style: TextStyle(
              color: Color(0xfffbaf03),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Color(0xfffbaf03),
              size: 13,
            ),
            onPressed: () {
              setState(() {
                itemCount = itemCount + 1;
              });
            },
          ),
        ],
      ),
    );
  }
}
