import 'package:chatios/states/HomePageState.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chatios/providers/LoginProvider.dart';
import 'package:chatios/widgets/Login.dart';
import 'package:chatios/providers/ProviderChat.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
        create: (_) => LoginProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 124, 107, 157)),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            '/chat': (context) => ChangeNotifierProvider<MainProvider>(
              create: (_) => MainProvider(),
              child: const MyHomePage(),
            )
          },
          home: const LoginWidget(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}
