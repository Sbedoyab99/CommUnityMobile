import 'package:community/models/User.dart';
import 'package:flutter/material.dart';

class UserProvider extends InheritedWidget {
  final User? user;

  const UserProvider({
    super.key,
    required this.user,
    required super.child,
  });

  static UserProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserProvider>();
  }

  @override
  bool updateShouldNotify(covariant UserProvider oldWidget) {
    return oldWidget.user != user;
  }
}
