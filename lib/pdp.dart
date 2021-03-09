import 'package:ecom_test/Model.dart';
import 'package:ecom_test/plp.dart';
import 'package:flip_panel/flip_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_slider/page_slider.dart';

class PDPPage extends StatefulWidget {
  @override
  _PDPPageState createState() => _PDPPageState();
}

class _PDPPageState extends State<PDPPage> {
  Item item;
  GlobalKey<PageSliderState> _sliderKey = GlobalKey();
  List<Widget> pages = [];
  int currentIndex;
  DateTime today = DateTime.now();
  DateTime thatDay;
  Duration difference;
  List<UserRating> ratings = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      currentIndex = 0;
      item = Item(
        'assets/mtr dosa.png',
        'Dosa Batter',
        '39.00',
        4.5,
        DateTime.now().add(new Duration(days: 1)),
        3,
        30,
      );
      thatDay = item.packedTime;
      difference = today.isAfter(thatDay)
          ? today.difference(thatDay)
          : thatDay.difference(today);
      pages = [
        Image.asset(
          item.imageUrl,
          height: 190,
        ),
        Image.asset(
          item.imageUrl,
          height: 190,
        ),
        Image.asset(
          item.imageUrl,
          height: 190,
        ),
      ];
      ratings = [
        new UserRating(
          'Danny',
          4.5,
          new DateFormat('d/M/y').parse('04/02/2021'),
          'Filium morte multavit si sine causa, mox videro; interea hoc epicurus in volupate.',
        ),
        new UserRating(
          'Danny',
          4.5,
          new DateFormat('d/M/y').parse('04/02/2021'),
          'Filium morte multavit si sine causa, mox videro; interea hoc epicurus in volupate.',
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width,
                color: Color(0xfffbaf03),
                padding: EdgeInsets.only(top: 30),
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
                    Text(
                      'Selected Date : ' +
                          DateFormat('d MMMM').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                color: Color(0xfffbaf03),
                padding: EdgeInsets.only(bottom: 10),
                height: 270,
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: PageSlider(
                          key: _sliderKey,
                          pages: pages,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white54,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  _sliderKey.currentState.hasPrevious
                                      ? currentIndex -= 1
                                      : null;
                                });
                                _sliderKey.currentState.previous();
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white54,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  _sliderKey.currentState.hasNext
                                      ? currentIndex += 1
                                      : null;
                                });
                                _sliderKey.currentState.next();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          pages.length,
                          (index) {
                            return Container(
                              height: 10,
                              width: 10,
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index == currentIndex
                                    ? Colors.white30
                                    : Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 160,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        height: 80,
                        width: 90,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(-1, -1),
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(1, 1),
                              spreadRadius: 1,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 20,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.3),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Packed since',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    FlipPanel<int>.stream(
                                      itemStream: Stream.periodic(
                                          Duration(hours: 1),
                                          (count) => count % 24),
                                      itemBuilder: (context, value) =>
                                          Container(
                                        height: 27,
                                        width: 25,
                                        decoration: BoxDecoration(
                                          color: Color(0xff140d43),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Center(
                                          child: Text(
                                            '$value'.padLeft(2, '0'),
                                            style: GoogleFonts.benchNine(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      initValue: difference.inHours % 24,
                                    ),
                                    SizedBox(
                                      height: 4,
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
                                      itemStream: Stream.periodic(
                                          Duration(minutes: 1),
                                          (count) => count % 60),
                                      itemBuilder: (context, value) =>
                                          Container(
                                        height: 27,
                                        width: 25,
                                        decoration: BoxDecoration(
                                          color: Color(0xff140d43),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Center(
                                          child: Text(
                                            '$value'.padLeft(2, '0'),
                                            style: GoogleFonts.benchNine(
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      initValue: difference.inMinutes % 60,
                                    ),
                                    SizedBox(
                                      height: 4,
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
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          text: '\$ ' + item.price,
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10,
                ),
                child: Container(
                  child: Text(
                    'Sed ut summo bono, dolorem aspernari ut aut quid iudicat, quo aut contra Set ut summo bono, dolorem aspernari ut aut quid iudicat, em asparnar',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  left: 15.0,
                  top: 10,
                  right: 15,
                  bottom: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: width / 6,
                      height: 32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.lightGreen),
                      padding: EdgeInsets.all(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 19,
                          ),
                          Text(
                            ' ' + item.rating.toString() + " ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    new ItemCounter(),
                  ],
                ),
              ),
              Container(
                width: width * 0.9,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xfffbaf03),
                  borderRadius: BorderRadius.circular(width / 3),
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
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: 15,
                  top: 15,
                ),
                child: Text(
                  'Reviews',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ratings.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 10,
                      bottom: 5,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: CircleAvatar(
                                radius: 18.0,
                                // backgroundImage:
                                // NetworkImage('https://via.placeholder.com/150'),
                                backgroundColor: Colors.black,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 12,
                                    top: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Row(
                                          children: [
                                            Text(
                                              ratings[index].userName,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            RatingBar.builder(
                                              initialRating:
                                                  ratings[index].rating,
                                              minRating: ratings[index].rating,
                                              maxRating: ratings[index].rating,
                                              direction: Axis.horizontal,
                                              itemSize: 15,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 1.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.red,
                                                size: 1,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        DateFormat('d/M/y')
                                            .format(ratings[index].date),
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 45,
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    top: 10,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(
                                    ratings[index].description,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.clip,
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
