import 'package:cine_log/data/movies.dart';
import 'package:cine_log/firebase_options.dart';
import 'package:cine_log/ui/add_movie.dart';
import 'package:cine_log/ui/app_controller.dart';
import 'package:cine_log/ui/auth/forgot_password.dart';
import 'package:cine_log/ui/home.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter<Movie>(MovieAdapter());
  await Hive.openBox<Movie>(movieBoxName);
  runApp(const CineLogApp());
}

class CineLogApp extends StatelessWidget {
  const CineLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AppController());
    return FeatureDiscovery(
      sharedPreferencesPrefix: 'cine_log_features',
      child: GetMaterialApp(
        title: 'Cine Log',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.deepOrange, useMaterial3: true),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const Home()),
          GetPage(name: '/forgot-password', page: () => const ForgotPassword()),
          GetPage(name: '/add', page: () => const AddMovie())
        ],
      ),
    );
  }
}
