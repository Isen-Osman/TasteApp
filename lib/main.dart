import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab1/services/favorites_services.dart';
import 'package:lab1/services/notification_service.dart';
import 'package:provider/provider.dart';

import '../firebase_options.dart';
import '../screens/categories_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Lokalni notifikacii IOS
  await NotificationsService.init();
  await NotificationsService.scheduleDailyRecipe;

  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoritesService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Рецепти',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      home: CategoriesScreen(),
    );
  }
}
