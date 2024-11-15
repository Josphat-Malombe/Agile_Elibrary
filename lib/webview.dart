import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late InAppWebViewController webViewController;
  late double progress;

  @override
  void initState() {
    super.initState();
    progress = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView Example'),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(value: progress),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(widget.url),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webViewController = controller;
              },
              onLoadStart: (InAppWebViewController controller, WebUri? url) {
                print("Loading started: $url");
              },
              onLoadStop: (InAppWebViewController controller, WebUri? url) async {
                print("Loading stopped: $url");
                setState(() {
                  progress = 100;
                });
              },
              onProgressChanged: (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
