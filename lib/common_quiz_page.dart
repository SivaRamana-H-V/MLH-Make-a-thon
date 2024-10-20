import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CommonQuizPage extends StatefulWidget {
  const CommonQuizPage({super.key});

  @override
  CommonQuizPageState createState() => CommonQuizPageState();
}

class CommonQuizPageState extends State<CommonQuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Common Quiz'),
        centerTitle: true,
        backgroundColor: Colors.tealAccent,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri('http://172.16.1.210:5502/index.html'),
        ),
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true, // Enable JavaScript
        ),
        onWebViewCreated: (controller) {},
        onReceivedError: (controller, request, error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to load page: ${error.description}')),
          );
        },
        onReceivedHttpError: (controller, request, response) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'HTTP Error: ${response.statusCode} - ${response.reasonPhrase}',
              ),
            ),
          );
        },
      ),
    );
  }
}
