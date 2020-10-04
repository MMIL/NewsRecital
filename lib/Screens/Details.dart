import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ArticleViews.dart';

class Details extends StatefulWidget {
  var description, data, index;
  Details(this.data, this.index);

  @override
  _DetailsState createState() => _DetailsState(this.data, this.index);
}

class _DetailsState extends State<Details> {
  var dataPage, indexPage;
  _DetailsState(this.dataPage, this.indexPage);

  _launchURL() async {
    if (await canLaunch(dataPage[indexPage]['url'])) {
      await launch(dataPage[indexPage]['url']);
    } else {
      throw 'Could not launch ${dataPage[indexPage]['url']}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (dataPage == null)
          ? CircularProgressIndicator()
          : ListView(
              children: <Widget>[
                Column(children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.38,
                        width: double.infinity,
                        child: (dataPage[indexPage]['urlToImage'] == null)
                            ? Image(
                                image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRpRknF9IAeIQ2QCUaQ9JdQWoJUVUMVhXetvA&usqp=CAU'))
                            : Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    dataPage[indexPage]['urlToImage']),
                              ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon:
                                    Icon(Icons.arrow_back, color: Colors.white),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    Share.share(dataPage[indexPage]['url']);
                                  });
                                },
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 30,
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
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dataPage[indexPage]['source']['name'],
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      letterSpacing: .5,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Icon(
                                Icons.play_circle_fill_outlined,
                                size: 35,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: (dataPage[indexPage]['title'] == null)
                            ? Text("Breking News")
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  child: Text(
                                    dataPage[indexPage]['title'],
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          letterSpacing: .5,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: (dataPage[indexPage]['content'] == null)
                          ? Text("NewsRetical")
                          : Text(
                              dataPage[indexPage]['content'],
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                    ),
                  ),
                  MaterialButton(
                    height: MediaQuery.of(context).size.height * 0.05,
                    minWidth: MediaQuery.of(context).size.width * 0.80,
                    color: Colors.blueAccent,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticleView(
                                    postUrl: dataPage[indexPage]['url'],
                                  )));
                    },
                    shape: StadiumBorder(),
                    child: Text(
                      "Read Full News",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ]),
              ],
            ),
    );
  }
}
