import 'package:bloc_test/bloc_test.dart';
import 'package:todo/ui/splash/cubit/splash_cubit.dart';

void main() {
  blocTest(
    'Should emits [SplashDone] after 2 seconds countdown has finished',
    build: () => SplashCubit(),
    act: (bloc) => bloc..countDown(),
    wait: Duration(seconds: 2),
    expect: () => [SplashDone()],
  );

  blocTest(
    'Should emits [nothing] before countdown finished',
    build: () => SplashCubit(),
    act: (bloc) => bloc..countDown(),
    wait: Duration(seconds: 1),
    expect: () => [],
  );
}
