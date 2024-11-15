import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BookDetailPage extends StatelessWidget {
  final Map<String, dynamic> book;

  const BookDetailPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String downloadLink = book['downloadLink'] ?? '';
    final String previewLink = book['previewLink'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(book['title'] ?? 'Book Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (book['thumbnail'] != null)
                Center(
                  child: Image.network(book['thumbnail']),
                ),
              const SizedBox(height: 16),
              Text(
                book['title'] ?? 'No Title',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Author: ${book['author'] ?? 'Unknown'}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                book['description'] ?? 'No description available.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              if (downloadLink.isNotEmpty)
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                  onPressed: () async {
                    final url = Uri.parse(downloadLink);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      // Handle error gracefully
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Could not launch $downloadLink")),
                      );
                    }
                  },
                  child: Text(
                    'Download Book',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              if (previewLink.isNotEmpty)
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewPage(url: previewLink), // Navigate to the WebViewPage
                      ),
                    );
                  },
                  child: const Text(
                    'Preview Book',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// WebViewPage as defined above
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
      //appBar: AppBar(
       // title: const Text('Happy Reading'),
      //),
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
