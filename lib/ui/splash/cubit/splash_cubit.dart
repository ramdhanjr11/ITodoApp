import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void countDown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == 2) {
        timer.cancel();
        emit(SplashDone());
      }
    });
  }
}
