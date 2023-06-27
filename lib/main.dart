import 'package:blog_rest_api_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_provider/provider/get_all_posts/get_all_provider.dart';
import 'package:blog_rest_api_provider/provider/get_complet_post/get_complete_post_notifier.dart';
import 'package:blog_rest_api_provider/ui/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetAllPostNotifier()),
        ChangeNotifierProvider(create: (_) => GetCompletePostNotifier()),
      ],
      child: const MaterialApp(
        home: Home(),
      ),
    );
  }
}

