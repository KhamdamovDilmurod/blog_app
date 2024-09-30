
import 'package:flutter/material.dart';

import '../screens/main_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    final Object? key = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MainScreen(),
        );
      // case '/first':
      //   return LeftToRightRoute(
      //     page: FirstScreen(),
      //   );
      // case '/connectivity':
      //   return LeftToRightRoute(
      //     page: ConnectivityScreen(),
      //   );
      default:
        return _errorRoute();
    }
  }

  Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error: Page not found!'),
        ),
      );
    });
  }
}

/// how to use
/**
 * final AppRouter _appRouter = AppRouter(); -> in myApp
 *  onGenerateRoute: _appRouter.onGenerateRoute, -> in MaterialApp
 * Navigator.of(context).pushNamed(
    '/connectivity',);
 */
