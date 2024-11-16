import 'package:community/dto/user_edit_dto.dart';
import 'package:community/models/User.dart';
import 'package:community/services/auth_service.dart';
import 'package:flutter/material.dart';

class UserProvider extends InheritedWidget {
  final User? user;
  final AuthService _authService = AuthService();

  UserProvider({
    super.key,
    required this.user,
    required super.child,
  });

  static UserProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserProvider>();
  }

  set user(User? newUser) => newUser;

  @override
  bool updateShouldNotify(covariant UserProvider oldWidget) {
    return oldWidget.user != user;
  }

  Future<void> editUser(UserEditDTO userDTO, String? token) async {
    User? editedUser = user;
    editedUser!.firstName = userDTO.firstName;
    editedUser.lastName = userDTO.lastName;
    editedUser.phoneNumber = userDTO.phoneNumber;
    user = editedUser;
    await _authService.editUser(user, token!);
  }
}
