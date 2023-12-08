import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import './ui/screens.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

// PageController controller = PageController(initialPage: 0);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthManager(),
        ),
        ChangeNotifierProxyProvider<AuthManager, NovelsManager>(
          create: (ctx) => NovelsManager(),
          update: (ctx, authManager, novelsManager) {
            novelsManager!.authToken = authManager.authToken;
            return novelsManager;
          },
        )
      ],
      child: Consumer<AuthManager>(
        builder: (ctx, authManager, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: authManager.isAuth
                ? HomeScreen(email: authManager.getmail ?? '')
                : FutureBuilder(
                    future: authManager.tryAutoLogin(),
                    builder: (ctx, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const LoadingSreen()
                          : const AuthScreen();
                    },
                  ),
            routes: {
              UserNovelsScreen.routeName: (ctx) => const UserNovelsScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == EditNovelScreen.routeName) {
                final novelId = settings.arguments as String?;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return EditNovelScreen(
                      novelId != null
                          ? ctx.read<NovelsManager>().findById(novelId)
                          : null,
                    );
                  },
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
