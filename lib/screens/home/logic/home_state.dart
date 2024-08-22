part of 'home_cubit.dart';

abstract class HomeState{}

final class HomeInitial extends HomeState{}
final class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

final class HomeSuccess extends HomeState{}
final class HomeLoading extends HomeState{}