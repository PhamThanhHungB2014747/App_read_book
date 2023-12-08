import 'package:flutter/material.dart';
import '../chapter/chapter_manager.dart';

class ChapterScreen extends StatefulWidget {
  final int chapterNumber;
  final String? id; // Thêm thuộc tính id từ lớp cha
  const ChapterScreen(this.chapterNumber, {required this.id, Key? key})
      : super(key: key);

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  ChaptersManager _chaptersManager = ChaptersManager();

  bool _shouldReload = false;
  int currentChapter = 0;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeChaptersManager();
    currentChapter = widget.chapterNumber - 1;
  }

  void _initializeChaptersManager() async {
    _chaptersManager = ChaptersManager();
    // print(widget.id);
    await _chaptersManager.fetchChapters(widget.id ?? "");
    setState(() {
      if (_chaptersManager.items.chapterCount > 0) {
        _shouldReload = true;
      }
    });
  }

  void _incrementChapter() {
    setState(() {
      if (_chaptersManager.items.chapterCount > currentChapter + 1) {
        currentChapter++;
        print(currentChapter);
      }
      _scrollToTop(); // Tăng giá trị widget.idChapter lên 1
    });
  }

  void _decrementChapter() {
    setState(() {
      if (currentChapter > 0) {
        currentChapter--;
        _scrollToTop(); // Giảm giá trị widget.idChapter đi 1
      }
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF5F5F5)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Chapter ${currentChapter + 1}',
          style: const TextStyle(
            color: Color(0xFFF5F5F5),
            fontSize: 20,
            decoration: TextDecoration.none,
            fontFamily: 'Recoleta',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_left, color: Color(0xFFF5F5F5)),
            onPressed: _decrementChapter,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_right, color: Color(0xFFF5F5F5)),
            onPressed: _incrementChapter,
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Text(
            _shouldReload == true
                // ? ''
                ? _chaptersManager.items.chapterContent[currentChapter]
                : '',
            style: const TextStyle(
              color: Color(0xFF393939),
              fontSize: 17,
              fontFamily: 'Recoleta',
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
