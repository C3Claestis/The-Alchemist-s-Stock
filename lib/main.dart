import 'package:alchemiststock/page/RegisterLoginPage/splashscreen_page.dart';
import 'package:alchemiststock/services/_favourite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // Muat file .env
  await dotenv.load(fileName: "API_KEY.env"); 
  WidgetsFlutterBinding.ensureInitialized();
  await FavouriteService.loadFavourites();
  
  runApp(const MainApp()); // Ganti MyApp dengan widget root aplikasi Anda
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: SplashscreenPage(), backgroundColor: Colors.white),
    );
  }
}
