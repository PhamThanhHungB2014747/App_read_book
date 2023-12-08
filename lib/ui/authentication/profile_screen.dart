import 'package:ct484_project/ui/authentication/auth_manager.dart';
import 'package:ct484_project/ui/novels/user_novels_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Column(
        children: <Widget>[
          Container(height: 24),
          Container(
            height: 300.0,
            color: const Color(0XFFBBBBBB),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  width: 125.0,
                  height: 125.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40.0,
                  child: Text(
                    email,
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontFamily: 'Recoleta',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: const Icon(
              Icons.edit,
              size: 40.0,
              color: Colors.blue,
            ),
            title: const Text(
              'Manage Novels',
              style: TextStyle(
                color: Color(0xFF001524),
                fontSize: 25,
                fontFamily: 'Recoleta',
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserNovelsScreen()),
              );
            },
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 40.0,
              color: Colors.red,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Color(0xFF001524),
                fontSize: 25,
                fontFamily: 'Recoleta',
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ),
              );
              context.read<AuthManager>().logout();
            },
          ),
        ],
      ),
    );
  }
}
