import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';  

void main() {
  runApp(const LibraryApp());
}

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  final Map<String, List<Map<String, String>>> categories = const {


    'Self Help Books': [
      {
        'title': 'Atomic Habits',
        'image': 'assets/images/atomic_habits.jpg',
        'pdfPath': 'assets/pdfs/atomic_habits.pdf',
      },
      {
        'title': 'Rich Dad Poor Dad',
        'image': 'assets/images/richdadpoordad.jpeg',
        'pdfPath': 'assets/pdfs/richdadpoordad.pdf',
      },
      {
        'title': 'Limitless',
        'image': 'assets/images/limitless.jpeg',
        'pdfPath': 'assets/pdfs/limitless.pdf',
      },
      {
        'title': 'Magic of Thinking Big',
        'image': 'assets/images/magicofthinkingbig.jpeg',
        'pdfPath': 'assets/pdfs/magicofthinkingbig.pdf',
      },
      {
        'title': 'Psychology of Money',
        'image': 'assets/images/physiologyofmoney.jpeg',
        'pdfPath': 'assets/pdfs/physiologyofmoney.pdf',
      },
    ],


    'Fiction': [
      {
        'title': 'Hacking',
        'image': 'assets/images/hacking.jpeg',
        'pdfPath': 'assets/pdfs/hacking.pdf',
      },
      {
        'title': 'Limitless',
        'image': 'assets/images/limitless.jpeg',
        'pdfPath': 'assets/pdfs/limitless.pdf',
      },
      {
        'title': 'Magic of Thinking Big',
        'image': 'assets/images/magicofthinkingbig.jpeg',
        'pdfPath': 'assets/pdfs/magicofthinkingbig.pdf',
      },
      {
        'title': 'Physiology of Money',
        'image': 'assets/images/physiologyofmoney.jpeg',
        'pdfPath': 'assets/pdfs/physiologyofmoney.pdf',
      },
      {
        'title': 'The Last Question',
        'image': 'assets/images/lastQ.jpeg',
        'pdfPath': 'assets/pdfs/lastQ.pdf',
      },

    ],


    
    'Science': [

      {
        'title': 'Engineering Mathematics',
        'image': 'assets/images/engineeringmathematics.jpeg',
        'pdfPath': 'assets/pdfs/atomic_habits.pdf',
      },
      {
        'title': 'The Last Question',
        'image': 'assets/images/lastQ.jpeg',
        'pdfPath': 'assets/pdfs/lastQ.pdf',
      },

      {
        'title': 'Limitless',
        'image': 'assets/images/limitless.jpeg',
        'pdfPath': 'assets/pdfs/limitless.pdf',
      },
      {
        'title': 'Magic of Thinking Big',
        'image': 'assets/images/magicofthinkingbig.jpeg',
        'pdfPath': 'assets/pdfs/magicofthinkingbig.pdf',
      },
      {
        'title': 'Physiology of Money',
        'image': 'assets/images/physiologyofmoney.jpeg',
        'pdfPath': 'assets/pdfs/physiologyofmoney.pdf',
      },

    ],



    'Business': [
      {
        'title': 'Physiology of Money',
        'image': 'assets/images/physiologyofmoney.jpeg',
        'pdfPath': 'assets/pdfs/physiologyofmoney.pdf',
      },
      {
        'title': 'Rich Dad Poor Dad',
        'image': 'assets/images/richdadpoordad.jpeg',
        'pdfPath': 'assets/pdfs/richdadpoordad.pdf',
      },
      {
        'title': 'Limitless',
        'image': 'assets/images/limitless.jpeg',
        'pdfPath': 'assets/pdfs/limitless.pdf',
      },
      {
        'title': 'Magic of Thinking Big',
        'image': 'assets/images/magicofthinkingbig.jpeg',
        'pdfPath': 'assets/pdfs/magicofthinkingbig.pdf',
      },
      {
        'title': 'Physiology of Money',
        'image': 'assets/images/physiologyofmoney.jpeg',
        'pdfPath': 'assets/pdfs/physiologyofmoney.pdf',
      },

    ],



    'Technology': [
      {
        'title': 'Hacking',
        'image': 'assets/images/hacking.jpeg',
        'pdfPath': 'assets/pdfs/hacking.pdf',
      },
      {
        'title': 'Data Structures',
        'image': 'assets/images/dsa.jpeg',
        'pdfPath': 'assets/pdfs/dsa.pdf',
      },
      {
        'title': 'Machine Learning',
        'image': 'assets/images/ml.jpeg',
        'pdfPath': 'assets/pdfs/mlpdf',
      },
      {
        'title': 'Python',
        'image': 'assets/images/python.jpeg',
        'pdfPath': 'assets/pdfs/python.pdf',
      },
      {
        'title': 'C# Programming',
        'image': 'assets/images/c.jpeg',
        'pdfPath': 'assets/pdfs/c.pdf',
      },

    ],


    'Religion': [
      {
        'title': 'Hacking',
        'image': 'assets/images/hacking.jpeg',
        'pdfPath': 'assets/pdfs/hacking.pdf',
      },
      {
        'title': 'Limitless',
        'image': 'assets/images/limitless.jpeg',
        'pdfPath': 'assets/pdfs/limitless.pdf',
      },
      {
        'title': 'Magic of Thinking Big',
        'image': 'assets/images/magicofthinkingbig.jpeg',
        'pdfPath': 'assets/pdfs/magicofthinkingbig.pdf',
      },
      {
        'title': 'Physiology of Money',
        'image': 'assets/images/physiologyofmoney.jpeg',
        'pdfPath': 'assets/pdfs/physiologyofmoney.pdf',
      },
      {
        'title': 'The Last Question',
        'image': 'assets/images/lastQ.jpeg',
        'pdfPath': 'assets/pdfs/lastQ.pdf',
      },

    ],


    'Agriculture': [
      {
        'title': 'Hacking',
        'image': 'assets/images/hacking.jpeg',
        'pdfPath': 'assets/pdfs/hacking.pdf',
      },
      {
        'title': 'The Last Question',
        'image': 'assets/images/lastQ.jpeg',
        'pdfPath': 'assets/pdfs/lastQ.pdf',
      },
      {
        'title': 'Limitless',
        'image': 'assets/images/limitless.jpeg',
        'pdfPath': 'assets/pdfs/limitless.pdf',
      },
      {
        'title': 'Magic of Thinking Big',
        'image': 'assets/images/magicofthinkingbig.jpeg',
        'pdfPath': 'assets/pdfs/magicofthinkingbig.pdf',
      },
      {
        'title': 'Physiology of Money',
        'image': 'assets/images/physiologyofmoney.jpeg',
        'pdfPath': 'assets/pdfs/physiologyofmoney.pdf',
      },

    ],


    'History': [
      {
        'title': 'Hacking',
        'image': 'assets/images/hacking.jpeg',
        'pdfPath': 'assets/pdfs/hacking.pdf',
      },
      {
        'title': 'The Last Question',
        'image': 'assets/images/lastQ.jpeg',
        'pdfPath': 'assets/pdfs/lastQ.pdf',
      },
      {
        'title': 'Limitless',
        'image': 'assets/images/limitless.jpeg',
        'pdfPath': 'assets/pdfs/limitless.pdf',
      },
      {
        'title': 'Magic of Thinking Big',
        'image': 'assets/images/magicofthinkingbig.jpeg',
        'pdfPath': 'assets/pdfs/magicofthinkingbig.pdf',
      },
      {
        'title': 'Physiology of Money',
        'image': 'assets/images/physiologyofmoney.jpeg',
        'pdfPath': 'assets/pdfs/physiologyofmoney.pdf',
      },

    ],


    'Artificial Intelligence': [
      {
        'title': 'Machine Learning',
        'image': 'assets/images/ml.jpeg',
        'pdfPath': 'assets/pdfs/ml.pdf',
      },
      {
        'title': 'The Last Question',
        'image': 'assets/images/lastQ.jpeg',
        'pdfPath': 'assets/pdfs/lastQ.pdf',
      },
      {
        'title': 'Elements of Robots',
        'image': 'assets/images/robots.jpeg',
        'pdfPath': 'assets/pdfs/robots.pdf',
      },
      {
        'title': 'Magic of Thinking Big',
        'image': 'assets/images/magicofthinkingbig.jpeg',
        'pdfPath': 'assets/pdfs/magicofthinkingbig.pdf',
      },
      {
        'title': 'Physiology of Money',
        'image': 'assets/images/physiologyofmoney.jpeg',
        'pdfPath': 'assets/pdfs/physiologyofmoney.pdf',
      },

    ],


  };

  @override
  Widget build(BuildContext context) {
    const title = 'Category Collections';
    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          String category = categories.keys.elementAt(index);
          List<Map<String, String>> books = categories[category]!;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    category,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 200,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: books.length,
                    itemBuilder: (context, bookIndex) {
                      final book = books[bookIndex];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            // Open the PDF faster using Syncfusion PDF Viewer
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFViewerPage(pdfPath: book['pdfPath']!),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                book['image']!,
                                height: 140,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                book['title']!,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


class PDFViewerPage extends StatelessWidget {
  final String pdfPath;

  const PDFViewerPage({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("Happy Reading")),
      body: SfPdfViewer.asset(pdfPath),
    );
  }
}


