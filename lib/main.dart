import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OFF PHARMA',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WebViewApp(),
    );
  }
}

class WebViewApp extends StatefulWidget {
  @override
  _WebViewAppState createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  final _key = UniqueKey();
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('OFF PHARMA',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        body: Stack(
          children: [
            WebView(
              key: _key,
              initialUrl: 'https://pos.offpharma.com/login', // Replace with your desired URL
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (_) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm'),
        content: Text('Are you sure you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
