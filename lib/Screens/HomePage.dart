import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_retic/views/Bussiness.dart';
import 'package:news_retic/views/Entertainment.dart';
import 'package:news_retic/views/General.dart';
import 'package:news_retic/views/Health.dart';
import 'package:news_retic/views/India.dart';
import 'package:news_retic/views/Science.dart';
import 'package:news_retic/views/Sports.dart';
import 'package:news_retic/views/Technology.dart';
import 'package:news_retic/views/World.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  int index;
  @override
  void initState() {
    controller = new TabController(length: 9, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WidgetTitle(getStrToday()),
              IconButton(
                onPressed: () {
                  setState(() {
                    changeBrightness();
                  });
                },
                icon: Icon(
                  Icons.brightness_6_sharp,
                  size: 25,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ],
          ),
          elevation: 0.0,
          bottom: TabBar(
            controller: controller,
            isScrollable: true,
            indicatorColor: Colors.deepPurple,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            labelStyle: GoogleFonts.openSansCondensed(
              textStyle: TextStyle(
                letterSpacing: .4,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            tabs: <Widget>[
              Tab(text: "Explore"),
              Tab(text: "World"),
              Tab(text: "General"),
              Tab(text: "Business"),
              Tab(text: "Entertainment"),
              Tab(text: "Technology"),
              Tab(text: "Sports"),
              Tab(text: "Science"),
              Tab(text: "Health"),
            ],
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: <Widget>[
            India(),
            World(),
            General(),
            Bussiness(),
            Entertainment(),
            Technology(),
            Sports(),
            Science(),
            Health(),
          ],
        ));
  }
}

String getStrToday() {
  var today = DateFormat().add_yMMMMd().format(DateTime.now());
  var strDay = today.split(" ")[1].replaceFirst(',', '');
  if (strDay == '1') {
    strDay = strDay + "st";
  } else if (strDay == '2') {
    strDay = strDay + "nd";
  } else if (strDay == '3') {
    strDay = strDay + "rd";
  } else {
    strDay = strDay + "th";
  }
  var strMonth = today.split(" ")[0];
  var strYear = today.split(" ")[2];
  return "$strDay $strMonth $strYear";
}

class WidgetTitle extends StatelessWidget {
  final String strToday;

  WidgetTitle(this.strToday);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Container(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Today\'s News \n',
                  style: GoogleFonts.lobster(
                    textStyle: TextStyle(
                        fontSize: 24.0,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                TextSpan(
                  text: strToday,
                  style: GoogleFonts.lobster(
                    textStyle: TextStyle(
                        // letterSpacing: .3,
                        fontSize: 14.0,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black54
                            : Colors.white54,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
