import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_retic/Screens/Details.dart';
import 'package:news_retic/helper/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

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

  ///<--To avoid overlapping in mobile version--->
  ///1.Change Grid View to List View
  ///2.Remove Expanded and Container widget from content,image

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Expanded(
            child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: responsiveNumGridTiles(mediaQuery)),
                itemCount: widget.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      mediaQuery.size.width > 700
                          ? _launchURL(widget.data[index]['url'])
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details(
                                        widget.data,
                                        index,
                                      )));
                    },
                    child: Container(
                        margin: EdgeInsets.only(bottom: 20, left: 4, right: 4),
                        child: Container(
                          height: responsiveImageHeight(mediaQuery),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              (widget.data[index]['urlToImage'] == null)
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image(
                                          image: NetworkImage(
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRpRknF9IAeIQ2QCUaQ9JdQWoJUVUMVhXetvA&usqp=CAU')),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image(
                                        image: NetworkImage(
                                            widget.data[index]['urlToImage']),
                                      ),
                                    ),
                              Expanded(
                                child: Container(
                                  height: responsiveTitleHeight(mediaQuery),
                                  child: Text(
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
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
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
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      child: (widget.data[index]
                                                  ['publishedAt'] ==
                                              null)
                                          ? CircularProgressIndicator()
                                          : Text(
                                              "🕓 " +
                                                  widget.data[index]
                                                      ['publishedAt'],
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            )),
                                  (widget.data[index]['source']['name'] == null)
                                      ? CircularProgressIndicator()
                                      : Text(
                                          " " +
                                              widget.data[index]['source']
                                                  ['name'],
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                          ),
                                        )
                                ],
                              )
                            ],
                          ),
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
