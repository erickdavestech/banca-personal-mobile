part of 'tab_bloc.dart';

@immutable
sealed class TabState {}

final class TabInitial extends TabState {
  final int index;
  final Widget? screen;

  TabInitial({
    required this.index,
    this.screen,
  });
}
