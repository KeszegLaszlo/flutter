import 'package:flutter/material.dart';
import 'package:mentoring/AlbumList/repository/album_repository.dart';
import 'package:mentoring/AlbumList/viewmodel/album_viewmodel.dart';
import 'package:mentoring/Home/widget/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AlbumViewModel(AlbumRepositoryImpl()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
