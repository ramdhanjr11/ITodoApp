part of 'splash_cubit.dart';

sealed class SplashState extends Equatable {}

final class SplashInitial extends SplashState {
  @override
  List<Object?> get props => [];
}

final class SplashDone extends SplashState {
  @override
  List<Object?> get props => [];
}
