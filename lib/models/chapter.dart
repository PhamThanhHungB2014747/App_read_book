class Chapter {
  int chapterCount;
  List<String> chapterContent;

  Chapter({required this.chapterCount, required this.chapterContent});

  void displayChapter(int index) {
    if (index >= 0 && index < chapterCount) {
      print("Chapter ${index + 1}: ${chapterContent[index]}");
    }
  }

  void displayAllChapters() {
    for (int i = 0; i < chapterCount; i++) {
      print("Chapter ${i + 1}: ${chapterContent[i]}");
    }
  }

  void addChapterContent(String content) {
    chapterContent.add(content);
    chapterCount++;
  }
}
