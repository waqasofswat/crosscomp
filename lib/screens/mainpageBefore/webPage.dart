import 'package:cross_comp/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// import 'package:http/http.dart' as http;

class WebPage extends StatelessWidget {
  WebPage(this.url);
  final String url;
  // final String url = "https://www.crosscomps.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        title: Text(
          "CrossComps",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            color: Theme.of(context).primaryColor),
        margin: EdgeInsets.all(1),
        child: WebView(
          initialUrl: url,
        ),
      ),
    );
  }
}
