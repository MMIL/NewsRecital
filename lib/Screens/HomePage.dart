import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../views/Bussiness.dart';
import '../views/Entertainment.dart';
import '../views/Explore.dart';
import '../views/Health.dart';
import '../views/Science.dart';
import '../views/Sports.dart';
import '../views/Technology.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  int index;
  @override
  void initState() {
    controller = new TabController(length: 7, vsync: this);
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WidgetTitle(getStrToday()),
            ],
          ),
          elevation: 0.0,
          bottom: TabBar(
            controller: controller,
            isScrollable: true,
            indicatorColor: Colors.black54,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Tab(text: "Explore"),
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
            Explore(),
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'NewsRetical\n',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        letterSpacing: .5,
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                TextSpan(
                  text: strToday,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        letterSpacing: .5,
                        fontSize: 14.0,
                        color: Colors.black54,
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
