import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/novel.dart';
import './detail_novel_screen.dart';
import './novel_manager.dart';

class NovelScreen extends StatelessWidget {
  const NovelScreen(this.novel, {super.key});

  final Novel novel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailNovelScreen(novel)),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8FF),
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              novel.imageUrl,
                            ),
                            fit: BoxFit.contain,
                            alignment: Alignment.topLeft,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                novel.name,
                                style: const TextStyle(
                                  color: Color(0xFF393939),
                                  fontSize: 20,
                                  fontFamily: 'Recoleta',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            novel.author,
                            style: const TextStyle(
                              color: Color(0xFF393939),
                              fontSize: 20,
                              fontFamily: 'Recoleta',
                            ),
                          ),
                          SizedBox(
                            width: 170,
                            child: Text(
                              novel.description,
                              style: const TextStyle(
                                color: Color(0xFF393939),
                                fontSize: 14,
                                fontFamily: 'Recoleta',
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: novel.inLibraryListenable,
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<NovelsManager>()
                                  .toggleLibraryStatus(novel);
                            },
                            child: Icon(
                              value ? Icons.bookmark : Icons.bookmark_border,
                              size: 30,
                              color: value ? Colors.green : Colors.grey,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
