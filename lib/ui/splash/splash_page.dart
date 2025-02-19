import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/config/app_route.dart';
import 'package:todo/ui/splash/cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashDone) {
          Navigator.pushReplacementNamed(context, AppRoute.home);
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/images/todo_icon.png',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
