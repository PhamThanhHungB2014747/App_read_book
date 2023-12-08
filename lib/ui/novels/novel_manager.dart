import '../../models/novel.dart';
import 'package:flutter/foundation.dart';
import '../../models/auth_token.dart';
import '../../services/novel_service.dart';
import 'package:flutter/material.dart';

class NovelsManager with ChangeNotifier {
  // List<Novel> _items = [
  //   Novel(
  //     id: '1',
  //     name: "Forrest Gump",
  //     author: 'John Escott',
  //     description:
  //         'It would be a very case to at least one person on Earth, who did not know the famous "Forrest Gump" with Tom Hanks. Certainly, everybody knows and loves this movie. But have you ever read the book on which this film is based? There is a very common situation, when the book is better than the movie. Is this the same case? Let us revise our memories and read a short plot of this story. "This is a true, wonderful and funny story about Forrest Gump. Forrest is a young kind-hearted man from Alabama in the USA. He has won a medal for gallantry in the Vietnam war. The President Of the United States awarded the hero. Forrest was a footballer, a businessman and a film star. He also went in space. His best friend was an ape called Sue."',
  //     countChapter: 10,
  //     imageUrl:
  //         'https://english-e-reader.net/covers/Forrest_Gump-John_Escott.jpg',
  //   ),
  //   Novel(
  //     id: '2',
  //     name: 'Peter Pan',
  //     author: 'J. M. Barrie',
  //     description:
  //         "Peter Pan is one of the most popular child literature characters of the twentieth century. This is a simple and a magical story about a fairy boy, who didnt want to grow up. Peter has run away from home, and became forever young. He lived with the company of little boys, who had lost in the forest. Once Peter Pan has flown into the nursery, where were the girl Wendy and her two younger brothers and he has changed the lives of these children forever. They went with Peter to the far miracle island called Neverland. There they've met with mermaids, brave Indians, playful fairy and even pirates with their evil master captain Hook. The captain Hook's fate would depend from the hands of Peter Pan, his main enemy. Exciting, romantic and dangerous adventures waiting for the heroes.",
  //     countChapter: 15,
  //     imageUrl: 'https://english-e-reader.net/covers/Peter_Pan-J_M_Barrie.jpg',
  //   ),
  //   Novel(
  //     id: '3',
  //     name: 'Jaws',
  //     author: 'Peter Benchley',
  //     description:
  //         'The guy is looking at the dark water with horror. The shark is somewhere there. It is swimming out of sight, planning to attack. It is invisible and this scares even more. But the story began even earlier. Amity is a small and very quiet town in the vicinity of New York. Nothing ever happens here. One warm night, a young woman decides to swim in the sea. She does not return home. Soon, the police finds her dead. One of the local police officers decides that a shark appeared near the city. This is a great white shark, which is called the man-eater. Unfortunately, closing the beaches does not work. Local people start rebelling, because the danger always seems distant. And swimming in the sea is too pleasant on a hot day. No one wants to think about any sharks.',
  //     countChapter: 20,
  //     imageUrl: 'https://english-e-reader.net/covers/Jaws-Peter_Benchley.jpg',
  //   ),
  // ];
  List<Novel> _items = [];

  final NovelsService _novelsService;

  NovelsManager([AuthToken? authToken])
      : _novelsService = NovelsService(authToken);

  set authToken(AuthToken? authToken) {
    _novelsService.authToken = authToken;
  }

  Future<void> fetchNovels([bool filterByUser = false]) async {
    _items = await _novelsService.fetchNovels(filterByUser);
    notifyListeners();
  }

  Future<void> addNovel(Novel novel) async {
    final newNovel = await _novelsService.addNovel(novel);
    if (newNovel != null) {
      _items.add(newNovel);
      notifyListeners();
    }
  }

  Future<void> updateNovel(Novel novel) async {
    final index = _items.indexWhere((element) => element.id == novel.id);
    if (index >= 0) {
      if (await _novelsService.updateNovel(novel)) {
        _items[index] = novel;
        notifyListeners();
      }
    }
  }

  Future<void> deleteNovel(String id) async {
    final index = _items.indexWhere((element) => element.id == id);
    Novel? existingNovel = _items[index];
    _items.removeAt(index);

    if (!await _novelsService.deleteNovel(id)) {
      _items.insert(index, existingNovel);
      notifyListeners();
    }
  }

  Novel? findById(String id) {
    try {
      return _items.firstWhere((element) => element.id == id);
    } catch (error) {
      return null;
    }
  }

  void toggleLibraryStatus(Novel novel) async {
    final savedStatus = novel.inLibrary;
    novel.inLibrary = !savedStatus;

    if (!await _novelsService.saveLibraryStatus(novel)) {
      novel.inLibrary = savedStatus;
    }
  }

  int get itemCount {
    return _items.length;
  }

  List<Novel> get items {
    return [..._items];
  }

  List<Novel> get libraryItems {
    return _items.where((element) => element.inLibrary).toList();
  }
}
