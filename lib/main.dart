import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_1/category_db.dart';
import 'package:money_manager_1/home1.dart';
import 'package:money_manager_1/transactions_db.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:const SplashScreen(),
      color: Colors.black,theme:ThemeData(primaryColor: Colors.black));
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    splash(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: CircleAvatar(
        backgroundImage: AssetImage('lib\\asset\\image\\images1\\image_3.jpg'),
        radius: 150,
      )),
    );
  }
}

Future<void> splash(ctx) async {
  await Future.delayed(const Duration(seconds: 4));
  Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (ctx1) {
    return const HomeScreen();
  }));
}
