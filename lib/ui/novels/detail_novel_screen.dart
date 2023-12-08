import 'package:ct484_project/ui/chapter/chapter_screen.dart';
import 'package:ct484_project/ui/screens.dart';
import 'package:provider/provider.dart';
import '../../models/novel.dart';
import './novel_manager.dart';
import 'package:flutter/material.dart';

class DetailNovelScreen extends StatefulWidget {
  static const routeName = '/novel-detail';
  const DetailNovelScreen(this.novel, {super.key});

  final Novel novel;

  @override
  _Mydetail createState() => _Mydetail(novel);
}

class _Mydetail extends State<DetailNovelScreen> {
  String selectedOption = 'About';

  _Mydetail(this.novel);

  final Novel novel;

  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFF5F5F5),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          novel.name,
          style: const TextStyle(
            color: Color(0xFFF5F5F5),
            fontSize: 20,
            decoration: TextDecoration.none,
            fontFamily: 'Recoleta',
          ),
        ),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return ValueListenableBuilder<bool>(
                valueListenable: novel.inLibraryListenable,
                builder: (BuildContext context, bool value, Widget? child) {
                  return IconButton(
                    icon: Icon(
                      value ? Icons.bookmark : Icons.bookmark_border,
                      size: 30,
                      color: value ? Colors.green : Colors.white,
                    ),
                    onPressed: () {
                      context.read<NovelsManager>().toggleLibraryStatus(novel);
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            // color: Colors.grey[200],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    novel.imageUrl,
                    height: 300,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    novel.name,
                    style: const TextStyle(
                      color: Color(0xFF393939),
                      fontSize: 25,
                      fontFamily: 'Recoleta',
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    novel.author,
                    style: const TextStyle(
                      color: Color(0xFF393939),
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      fontFamily: 'Recoleta',
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOption = 'About';
                          });
                        },
                        child: Text(
                          'About',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Recoleta',
                            decoration: TextDecoration.none,
                            fontWeight: selectedOption == 'About'
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: selectedOption == 'About'
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOption = 'Chapter';
                          });
                        },
                        child: Text(
                          'Chapter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Recoleta',
                            decoration: TextDecoration.none,
                            fontWeight: selectedOption == 'Chapter'
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: selectedOption == 'Chapter'
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              selectedOption == 'About'
                  ? buildAbout(novel.description)
                  : buildChapter(novel.countChapter),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAbout(String description) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text(
          description,
          style: const TextStyle(
            fontSize: 16.0,
            fontFamily: 'Recoleta',
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  Widget buildChapter(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10, top: 15),
      child: Column(
        children: List.generate(index, (int temp) {
          int chapterNumber = temp + 1;
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
                // style: style,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChapterScreen(chapterNumber, id: novel.id ?? '')),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0XFFBBBBBB)),
                  minimumSize: MaterialStateProperty.all<Size>(
                      const Size(double.infinity, 60.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Chapter ${temp + 1}',
                      style: const TextStyle(
                        color: Color(0xFF001524),
                        fontSize: 25,
                        fontFamily: 'Recoleta',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )),
          );
        }),
      ),
    );
  }
}
