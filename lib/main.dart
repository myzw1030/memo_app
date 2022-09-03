import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memo_app/view/memo_input_page.dart';
import 'package:memo_app/view/home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Murecho',
      ),
      home: const HomePage(),
      routes: {
        MemoInputPage.id: (context) => const MemoInputPage(),
      },
    );
  }
}
