import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleBooksApi {
  final String apiKey;

  GoogleBooksApi(this.apiKey);

  Future<List<Map<String, dynamic>>> searchBooks(String query) async {
    final url = Uri.parse(
      'https://www.googleapis.com/books/v1/volumes?q=$query&key=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API response data: $data');

      // Check if there are items
      if (data['items'] == null) {
        print("No books found.");
        return [];
      }

      final List<Map<String, dynamic>> books = [];

      for (var item in data['items']) {
        final bookInfo = item['volumeInfo'];
        final accessInfo = item['accessInfo'];
        final downloadLink = accessInfo['pdf']?['downloadLink'];
        final previewLink = bookInfo['previewLink'] ?? bookInfo['infoLink'];

        books.add({
          'title': bookInfo['title'],
          'author': (bookInfo['authors'] ?? ['Unknown']).join(', '),
          'thumbnail': bookInfo['imageLinks']?['thumbnail'],
          'downloadLink': downloadLink,
          'previewLink': previewLink,
          'description': bookInfo['description'] ?? 'No description available.', // Add description here
          'isFree': accessInfo['pdf']?['isAvailable'] == true && downloadLink != null,
        });
      }

      print('Parsed books: $books');
      return books;
    } else {
      print('Failed to load books. Status code: ${response.statusCode}');
      throw Exception('Failed to load books');
    }
  }
}
