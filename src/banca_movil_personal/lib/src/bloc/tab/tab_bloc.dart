import 'package:bloc/bloc.dart';
import 'package:ca_mobile/src/screens/main/tabs/main_screen.dart';
import 'package:ca_mobile/src/screens/main/tabs/products_screen.dart';
import 'package:ca_mobile/src/screens/main/tabs/request_screen.dart';
import 'package:flutter/material.dart';

part 'tab_event.dart';
part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabInitial(index: 0, screen: MainScreen())) {
    on<TabChangeIndex>(
      (event, emit) {
        emit(TabInitial(index: event.index));

        switch (event.index) {
          case 0:
            emit(TabInitial(index: event.index, screen: MainScreen()));
            break;
          case 1:
            emit(TabInitial(index: event.index, screen: ProductsScreen()));
            break;
          case 2:
            emit(TabInitial(index: event.index, screen: RequestScreen()));
            break;
          case 3:
            emit(TabInitial(index: event.index, screen: MainScreen()));
            break;
        }
      },
    );
  }
}
