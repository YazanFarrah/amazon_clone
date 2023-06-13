import 'package:flutter/material.dart';

import 'features/auth/auth_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routName:
      return MaterialPageRoute(builder: (builder) => const AuthScreen());
    default:
      return MaterialPageRoute(
          builder: (builder) => const Scaffold(
                body: Center(
                  child: Text('Screen doesn\'t exist'),
                ),
              ));
  }
}
