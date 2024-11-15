import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'googles_book_api.dart';
import 'downloads.dart';
import 'book_details.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _books = [];
  final String apiKey = 'AIzaSyA6OUDXK09khQB_Qcmo_l8g8oDYgdIEKHI';
  final Downloads _downloads = Downloads();

  void _searchBooks() async {
    final api = GoogleBooksApi(apiKey);
    final query = _controller.text.trim();
    if (query.isNotEmpty) {
      final results = await api.searchBooks(query);
      setState(() {
        _books = results;
      });
    } else {
      print("Empty query, no search triggered");
    }
  }


  void _showBookDetails(BuildContext context, Map<String, dynamic> book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookDetailPage(book: book)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search for books',
                filled: true,
                fillColor: Colors.grey[200],

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.orange, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.orange, width: 2),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.orange),
                  onPressed: _searchBooks,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _books.length,
                itemBuilder: (context, index) {
                  final book = _books[index];
                  final bookTitle = book['title'] ?? 'No Title';
                  final author = book['author'] ?? 'Unknown';
                  final thumbnail = book['thumbnail'];

                  return ListTile(
                    leading: thumbnail != null ? Image.network(thumbnail) : null,
                    title: Text(bookTitle),
                    subtitle: Text(author),
                    onTap: () {
                      _showBookDetails(context, book);
                    },
                    trailing: book['isFree']
                        ? IconButton(
                      icon: Icon(Icons.download),
                      onPressed: () {
                        _downloads.downloadBook(book['downloadLink'], bookTitle);
                      },
                    )
                        : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
