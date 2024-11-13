import 'package:community/layout/common_layout.dart';
import 'package:community/models/User.dart';
import 'package:community/providers/user_provider.dart';
import 'package:flutter/material.dart';

class ApartmentScreen extends StatefulWidget {
  const ApartmentScreen({super.key});

  @override
  State<ApartmentScreen> createState() => _ApartmentScreenState();
}

class _ApartmentScreenState extends State<ApartmentScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final user = UserProvider.of(context)?.user;

    return Center(
      child: Text(
        user != null ? 'Hola usuario: ${user.email}' : 'No se encontro usuario',
      ),
    );
  }
}
