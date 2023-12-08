import 'package:ct484_project/ui/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_novel_list_tile.dart';

class UserNovelsScreen extends StatelessWidget {
  static const routeName = '/user-novels';
  const UserNovelsScreen({super.key});

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
        title: const Center(
            child: Text(
          'Your Novels',
          style: TextStyle(color: Color(0xFFF5F5F5)),
        )),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      // drawer: const HomeScreen(),
      body: FutureBuilder(
          future: context.read<NovelsManager>().fetchNovels(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return RefreshIndicator(
              onRefresh: () => context.read<NovelsManager>().fetchNovels(true),
              child: buildUserNovelListView(),
            );
          }),
    );
  }

  Widget buildUserNovelListView() {
    return Consumer<NovelsManager>(
      builder: (ctx, novelsManager, child) {
        return ListView.builder(
          itemCount: novelsManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserNovelListTile(
                novelsManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditNovelScreen.routeName,
        );
      },
      icon: const Icon(
        Icons.add,
        color: Color(0xFFF5F5F5),
      ),
    );
  }
}
