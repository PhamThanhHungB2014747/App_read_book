import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'novel_creen.dart';
import '../../models/novel.dart';
import 'novel_manager.dart';

class NovelGrid extends StatelessWidget {
  final bool showLibrary;
  const NovelGrid(this.showLibrary, {super.key});
  @override
  Widget build(BuildContext context) {
    final novels = context.select<NovelsManager, List<Novel>>((novelsManager) =>
        showLibrary ? novelsManager.libraryItems : novelsManager.items);
    return ListView.builder(
      padding: const EdgeInsets.all(0.0),
      itemCount: novels.length,
      itemBuilder: (ctx, i) => NovelScreen(novels[i]),
    );
  }
}
