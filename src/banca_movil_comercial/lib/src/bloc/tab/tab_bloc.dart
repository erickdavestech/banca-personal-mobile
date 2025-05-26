import 'package:banca_movil_comercial/src/screens/main/tabs/main_screen.dart';
import 'package:banca_movil_comercial/src/screens/main/tabs/products_screen.dart';
import 'package:banca_movil_comercial/src/screens/main/tabs/request_screen.dart';
import 'package:banca_movil_comercial/src/screens/products/product_detail.dart';
import 'package:banca_movil_libs/models/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'tab_event.dart';
part 'tab_state.dart';

enum AppTab { home, products, authorize, options }

class TabBloc extends Bloc<TabEvent, TabState> {
  final Map<AppTab, GlobalKey<NavigatorState>> tabNavigatorKeys = {
    AppTab.home: GlobalKey<NavigatorState>(),
    AppTab.products: GlobalKey<NavigatorState>(),
    AppTab.authorize: GlobalKey<NavigatorState>(),
    AppTab.options: GlobalKey<NavigatorState>(),
  };

  TabBloc() : super(TabInitial(index: 0)) {
    on<TabReset>((event, emit) {
      emit(TabInitial(index: 0));
    });

    on<TabChangeIndex>((event, emit) {
      emit(TabInitial(index: event.index));
    });
  }

  /// Crea una lista de Navigators, uno por cada tab definido en [AppTab].
  ///
  /// Este método se usa dentro de un `IndexedStack` para mantener la navegación independiente en cada tab,
  /// permitiendo que cada uno conserve su historial (por ejemplo, ir a detalles y volver sin perder estado).
  ///
  /// Cada Navigator usa una `GlobalKey` única de `tabNavigatorKeys` para controlar su stack.
  ///
  /// Aquí deben añadirse las rutas(pantallas) hijas de cada Tab,
  ///
  /// ### Rutas por tab:
  /// - `home`: `MainScreen`
  /// - `products`:
  ///   - `/`: `ProductsScreen`
  ///   - `/product-details`: `ProductDetail`
  /// - `authorize`: `RequestScreen`
  ///
  /// Para navegar dentro de un tab:
  /// ```dart
  /// context.read<TabBloc>().tabNavigatorKeys[AppTab.products]
  ///     ?.currentState?.pushNamed('/product-details', arguments: product);
  /// ```
  List<Widget> indexedTabStackChildren() {
    return AppTab.values.map((key) {
      return Navigator(
        key: tabNavigatorKeys[key],
        onGenerateRoute: (settings) {
          switch (key) {
            case AppTab.home:
              return MaterialPageRoute(builder: (_) => MainScreen());
            case AppTab.products:
              switch (settings.name) {
                case ProductsScreen.routeName:
                  return MaterialPageRoute(builder: (_) => ProductsScreen());
                case ProductDetail.routeName:
                  final product = settings.arguments as Product;
                  return MaterialPageRoute(
                    builder: (_) => ProductDetail(product: product),
                  );
                default:
                  return MaterialPageRoute(builder: (_) => ProductsScreen());
              }
            case AppTab.authorize:
              return MaterialPageRoute(builder: (_) => RequestScreen());
            // ignore: unreachable_switch_default
            default:
              return MaterialPageRoute(builder: (_) => SizedBox());
          }
        },
      );
    }).toList();
  }
}
