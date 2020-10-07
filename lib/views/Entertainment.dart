import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_retic/Utilites/ApiKey.dart';

import '../Screens/Details.dart';

class Entertainment extends StatefulWidget {
  @override
  _EntertainmentState createState() => _EntertainmentState();
}

class _EntertainmentState extends State<Entertainment> {
  int index;
  var url = "https://newsapi.org/v2/top-headlines?country=in&pageSize=30&apiKey=$apikey";
  var data;

  Future<String> getJsonData(url) async {
    var responce = await http.get(
      Uri.encodeFull(url),
    );

    setState(() {
      var convertdata = json.decode(responce.body);
      data = convertdata['articles'];
    });
    debugPrint(responce.body);
  }

  @override
  void initState() {
    getJsonData(url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: (data == null)
              ? CircularProgressIndicator()
              : SafeArea(
                  child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Details(
                                                data,
                                                index,
                                              )));
                                },
                                child: Container(
                                    margin: EdgeInsets.only(bottom: 18.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        (data[index]['urlToImage'] == null)
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image(
                                                    image: NetworkImage(
                                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRpRknF9IAeIQ2QCUaQ9JdQWoJUVUMVhXetvA&usqp=CAU')),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image(
                                                  image: NetworkImage(
                                                      data[index]
                                                          ['urlToImage']),
                                                ),
                                              ),
                                        Text(
                                          data[index]['title'] == null
                                              ? 'Breaking News'
                                              : data[index]['title'],
                                          style: GoogleFonts.merriweather(
                                            textStyle: TextStyle(
                                                letterSpacing: .4,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Text(
                                          data[index]['description'] == null
                                              ? ''
                                              : data[index]['description'],
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
                                          children: <Widget>[
                                            Container(
                                                alignment: Alignment.centerLeft,
                                                child: (data[index]
                                                            ['publishedAt'] ==
                                                        null)
                                                    ? CircularProgressIndicator()
                                                    : Text(
                                                        "🕓 " +
                                                            data[index]
                                                                ['publishedAt'],
                                                        style: TextStyle(
                                                          fontSize: 13.5,
                                                        ),
                                                      )),
                                            (data[index]['source']['name'] ==
                                                    null)
                                                ? CircularProgressIndicator()
                                                : Text(
                                                    " " +
                                                        data[index]['source']
                                                            ['name'],
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13.5,
                                                    ),
                                                  )
                                          ],
                                        )
                                      ],
                                    )),
                              );
                            }),
                      ),
                    ],
                  ),
                ))),
    );
  }
}
