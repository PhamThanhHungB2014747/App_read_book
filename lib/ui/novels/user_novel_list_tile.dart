import 'novel_manager.dart';
import 'edit_novel_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/novel.dart';

class UserNovelListTile extends StatelessWidget {
  final Novel novel;

  const UserNovelListTile(
    this.novel, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(novel.name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(novel.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            buildEditButton(context),
            buildDeleteButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditNovelScreen.routeName,
          arguments: novel.id,
        );
      },
      icon: const Icon(Icons.edit),
      color: Colors.blue,
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<NovelsManager>().deleteNovel(novel.id!);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'Novel deleted',
                textAlign: TextAlign.center,
              ),
            ),
          );
      },
      icon: const Icon(Icons.delete),
      color: Theme.of(context).colorScheme.error,
    );
  }
}
