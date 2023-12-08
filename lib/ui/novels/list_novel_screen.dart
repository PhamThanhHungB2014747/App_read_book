import 'package:provider/provider.dart';
import './novel_creen.dart';
import 'package:flutter/material.dart';
import './novel_manager.dart';
import '../screens.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ListNovel extends StatefulWidget {
  const ListNovel({super.key});
  // static const routeName = '/list_novel';
  @override
  State<ListNovel> createState() => _ListNovel();
}

class _ListNovel extends State<ListNovel> {
  final List<String> imageUrls = [
    'https://english-e-reader.net/covers/Forrest_Gump-John_Escott.jpg',
    'https://english-e-reader.net/covers/Peter_Pan-J_M_Barrie.jpg',
    'https://english-e-reader.net/covers/Jaws-Peter_Benchley.jpg',
    // Thêm các URL hình ảnh khác vào đây
  ];
  late Future<void> _fetchNovels;
  @override
  void initState() {
    super.initState();
    _fetchNovels = context.read<NovelsManager>().fetchNovels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 30),
          child: SizedBox(
            height: 35,
            child: TextField(
              focusNode: FocusNode(),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFDCDCDC),
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                hintText: "Search name",
              ),
            ),
            // child: MySearchPage(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                height: 150, // Chiều cao của thanh trượt
                aspectRatio: 16 / 9,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: imageUrls.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: Image.network(imageUrl, fit: BoxFit.cover),
                    );
                  },
                );
              }).toList(),
            ),
            FutureBuilder(
              future: _fetchNovels,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 800,
                    child: Scaffold(),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () =>
                      context.read<NovelsManager>().fetchNovels(true),
                  child: buildNovelListView(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildNovelListView() {
  return Consumer<NovelsManager>(
    builder: (ctx, novelsManager, child) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: novelsManager.itemCount,
        itemBuilder: (BuildContext context, int index) {
          return NovelScreen(novelsManager.items[index]);
        },
      );
    },
  );
}
