part of 'tab_bloc.dart';

@immutable
sealed class TabEvent {}

final class TabChangeIndex extends TabEvent {
  final int index;

  TabChangeIndex(this.index);
}
