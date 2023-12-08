import 'package:flutter/material.dart';
import 'novels/novel_libery_list_screen.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.email, Key? key}) : super(key: key);
  final String? email;
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _tabs = [];

  @override
  void initState() {
    super.initState();
    _tabs = [
      const ListNovel(),
      const ListLibaryNovel(),
      Profile(
        email: widget.email ?? '',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _tabs,
        ),
        //   ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books, color: Colors.blue),
            label: 'Libary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blue),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
