import 'dart:developer';

import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/auth/auth_screen.dart';
import 'package:amazone_clone/providers/products_provider.dart';
import 'package:amazone_clone/providers/user_provider.dart';
import 'package:amazone_clone/router.dart';
import 'package:amazone_clone/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'common/widgets/bottom_bar.dart';
import 'features/admin/screens/admin_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => ProductProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthServices authService = AuthServices();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      await authService.getUserData(context);
    } catch (e) {
      log(e.toString());
      // showSnackBar(context, e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        // useMaterial3: true, // can remove this line
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: isLoading
          ? Scaffold(
              body: Center(
                child: Lottie.asset('assets/animations/circular_loading.json'),
              ),
            )
          : Provider.of<UserProvider>(context).user.token.isNotEmpty
              ? Provider.of<UserProvider>(context).user.role == 'user'
                  ? const BottomBar()
                  : const AdminScreen()
              : const AuthScreen(),
    );
  }
}
