import '../../models/chapter.dart';
import 'package:flutter/foundation.dart';
import '../../models/auth_token.dart';
import '../../services/chapter_service.dart';
import 'package:flutter/material.dart';

class ChaptersManager with ChangeNotifier {
  Chapter items = Chapter(chapterCount: 0, chapterContent: []);

  final ChaptersService _ChaptersService;

  ChaptersManager([AuthToken? authToken])
      : _ChaptersService = ChaptersService(authToken);

  set authToken(AuthToken? authToken) {
    _ChaptersService.authToken = authToken;
  }

  fetchChapters(String novelId) async {
    items = (await _ChaptersService.fetchChapters(novelId));
  }

  int get itemCount {
    return items.chapterCount;
  }
}
