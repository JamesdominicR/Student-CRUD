import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'assets/data_model.dart';
import 'screen/home.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ListItemAdapter());
  await Hive.openBox<ListItem>('listitems');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ScreenHome(),
    );
  }
}
