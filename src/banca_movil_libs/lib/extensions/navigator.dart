import 'package:flutter/material.dart';

extension NavigatorExtension<T> on BuildContext {
  /// Push a named route onto the navigator.
  /// The route name will be passed to the [Navigator.onGenerateRoute] callback. The returned route will be pushed into the navigator.
  Future<T?> Function(String, {Object? arguments}) get pushNamed =>
      Navigator.of(this).pushNamed;

  /// Return to previous route with optoional result
  void Function([T? result]) get pop => Navigator.of(this).pop;

  /// Push the route with the given name onto the navigator, and then remove all the previous routes until the predicate returns true.
  Future<T?> pushNamedAndRemoveUntil(
    String newRouteName, {
    Object? arguments,
  }) =>
      Navigator.of(this).pushNamedAndRemoveUntil(
        newRouteName,
        arguments: arguments,
        (route) => false,
      );

  Future<T?> push(Widget child) => Navigator.of(this).push(
        MaterialPageRoute(builder: (_) => child),
      );
}
