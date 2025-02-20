import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/config/app_colors.dart';
import 'package:todo/config/app_di.dart';
import 'package:todo/config/app_route.dart';
import 'package:todo/ui/detail/detail_page.dart';
import 'package:todo/ui/bloc/todo_bloc.dart';
import 'package:todo/ui/splash/splash_page.dart';

import 'config/flavors.dart';
import 'ui/home/home_page.dart';
import 'ui/splash/cubit/splash_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashCubit()..countDown()),
        BlocProvider(create: (_) => di<TodoBloc>()..add(GetTodoList())),
      ],
      child: MaterialApp(
        title: F.title,
        theme: _themeData(),
        onGenerateRoute: _onGenerateRoute,
        home: _flavorBanner(
          child: SplashPage(),
          show: kDebugMode,
        ),
      ),
    );
  }

  ThemeData _themeData() {
    return ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: Colors.blue,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.background),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splash:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(opacity: animation, child: SplashPage());
          },
          transitionDuration: Duration(seconds: 1),
        );
      case AppRoute.home:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(opacity: animation, child: HomePage());
          },
          transitionDuration: Duration(seconds: 1),
        );
      case AppRoute.detail:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final type = (settings.arguments as Map<String, dynamic>)['type'];
            return SlideTransition(
              position: animation.drive(tween),
              child: DetailPage(type: type),
            );
          },
          transitionDuration: Duration(milliseconds: 300),
        );
      default:
        return MaterialPageRoute(builder: (_) => SplashPage());
    }
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Banner(
              location: BannerLocation.topStart,
              message: F.name,
              color: Colors.green.withValues(alpha: 0.6),
              textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                letterSpacing: 1.0,
              ),
              textDirection: TextDirection.ltr,
              child: child,
            )
          : Container(child: child);
}
