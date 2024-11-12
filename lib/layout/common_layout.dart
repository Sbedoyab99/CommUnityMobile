import 'package:community/models/User.dart';
import 'package:community/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonLayout extends StatefulWidget {
  const CommonLayout({super.key, required this.body});

  final Widget body;

  @override
  State<CommonLayout> createState() => _CommonLayoutState();
}

class _CommonLayoutState extends State<CommonLayout> {
  String? token;
  bool isLoading = true;
  User? user;

  late final Widget body;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    loadAsync();
  }

  Future<void> loadAsync() async {
    setState(() {
      isLoading = true;
    });
    token = await loadToken();
    user = await loadUser(token!);
    setState(() {
      isLoading = false;
    });
  }

  Future<String?> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token != null) {
      return token;
    } else {
      return null;
    }
  }

  Future<User?> loadUser(String token) async {
    final user = await _authService.getUser(token);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          backgroundColor: Colors.deepPurple,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(
              top: 40.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isLoading ? 'Cargando...' : user!.residentialUnit!.name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/apartment');
                  },
                  icon: const Icon(Icons.person),
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
      body: widget.body,
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Visitas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: 'Correspondencia',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note_add),
              label: 'PQRS',
            ),
          ],
          onTap: (index) {
            if (index == 2) {
              Navigator.pushNamed(context, '/settings');
            }
          },
        ),
      ),
    );
  }
}
