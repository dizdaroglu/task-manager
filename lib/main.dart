import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/taskData.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TaskData())],
      child: MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: "Cairo", scaffoldBackgroundColor: Color(0XFFEFEEF2)),
          home: HomeScreen()),
    );
  }
}
