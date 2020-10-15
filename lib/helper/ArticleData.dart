import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_retic/Screens/Details.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ArticleData extends StatefulWidget {
  var data;

  ArticleData(this.data);

  @override
  _ArticleDataState createState() => _ArticleDataState();
}

class _ArticleDataState extends State<ArticleData> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final formatter = DateFormat('hh:mm a  •  dd MMM yyyy');
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Details(
                    widget.data,
                    index,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  (widget.data[index]['urlToImage'] == null)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                              image: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2017/05/13/17/03/the-gap-message-2310064_1280.jpg')),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            image:
                                NetworkImage(widget.data[index]['urlToImage']),
                          ),
                        ),
                  Text(
                    widget.data[index]['title'] == null
                        ? 'Breaking News'
                        : widget.data[index]['title'],
                    style: GoogleFonts.merriweather(
                      textStyle: TextStyle(
                          letterSpacing: .4,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.data[index]['description'] == null
                        ? ''
                        : widget.data[index]['description'],
                    style: GoogleFonts.merriweather(
                      textStyle: TextStyle(
                          letterSpacing: .2,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.centerLeft,
                          child: (widget.data[index]['publishedAt'] == null)
                              ? CircularProgressIndicator()
                              : Text(
                                  "🕓 " +
                                      formatter.format(DateTime.parse(
                                          widget.data[index]['publishedAt'])),
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                )),
                      (widget.data[index]['source']['name'] == null)
                          ? CircularProgressIndicator()
                          : Text(
                              " " + widget.data[index]['source']['name'],
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black54
                                    : Colors.white54,
                                fontSize: 14,
                              ),
                            )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
