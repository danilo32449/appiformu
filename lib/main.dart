import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/movie_list_screen.dart';
import 'services/movie_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MovieService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Movie CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MovieListScreen(),
    );
  }
}