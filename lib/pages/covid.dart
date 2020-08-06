import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CovidStats extends StatefulWidget {
  const CovidStats({Key key}) : super(key: key);

  @override
  _CovidStatsState createState() => _CovidStatsState();
}

class _CovidStatsState extends State<CovidStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Covid Statistics",
          style: TextStyle(
            fontSize: 60.0,
            fontFamily: "SouthernAire",
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: _buildWebView(),
      ),
    );
  }

  Widget _buildWebView() {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: 'https://ncov2019.live/',
    );
  }
}