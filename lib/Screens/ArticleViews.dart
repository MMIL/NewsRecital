import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
}

class ArticleView extends StatefulWidget {
  final String postUrl;
  ArticleView({@required this.postUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  InAppWebViewController webView;
  String url = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "NewsRetical",
                style: GoogleFonts.merriweather(
                  textStyle: TextStyle(
                      letterSpacing: .5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    Share.share(widget.postUrl);
                  });
                },
                icon: Icon(
                  Icons.share,
                  size: 22,
                ),
              ),
            ],
          ),
          elevation: 0.0,
        ),
        body: Container(
            child: Column(children: <Widget>[
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: InAppWebView(
                initialUrl: widget.postUrl,
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                  debuggingEnabled: true,
                )),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                },
                onLoadStart: (InAppWebViewController controller, String url) {
                  setState(() {
                    this.url = url;
                  });
                },
                onLoadStop:
                    (InAppWebViewController controller, String url) async {
                  setState(() {
                    this.url = url;
                  });
                },
              ),
            ),
          ),
        ])),
      ),
    );
  }
}
