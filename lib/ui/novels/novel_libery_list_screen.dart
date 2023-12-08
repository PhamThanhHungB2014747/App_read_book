import 'package:ct484_project/ui/novels/novel_grid.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './novel_manager.dart';
import '../../models/novel.dart';

enum FilterOptions { library }

class ListLibaryNovel extends StatefulWidget {
  const ListLibaryNovel({super.key});
  static const routeName = '/list_novel';
  @override
  State<ListLibaryNovel> createState() => _ListLibaryNovel();
}

class _ListLibaryNovel extends State<ListLibaryNovel> {
  final _showInLibrary = ValueNotifier<bool>(true);
  late final Novel novel;
  late Future<void> _fetchNovels;

  @override
  void initState() {
    super.initState();
    _fetchNovels = context.read<NovelsManager>().fetchNovels();
  }

  Future<void> _refreshNovels() async {
    setState(() {
      _showInLibrary.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Libary',
            style: TextStyle(
              color: Color(0xFF393939),
              fontSize: 35,
              fontFamily: 'Recoleta',
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNovels,
        child: FutureBuilder(
          future: _fetchNovels,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return NovelGrid(_showInLibrary.value);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
