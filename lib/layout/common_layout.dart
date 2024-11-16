import 'package:community/models/User.dart';
import 'package:community/providers/user_provider.dart';
import 'package:community/screens/apartment_screen.dart';
import 'package:community/screens/home_screen.dart';
import 'package:community/screens/mail_screen.dart';
import 'package:community/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonLayout extends StatefulWidget {
  const CommonLayout({super.key});

  @override
  State<CommonLayout> createState() => _CommonLayoutState();
}

class _CommonLayoutState extends State<CommonLayout> {
  String? token;
  bool isLoading = true;
  User? user;
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ApartmentScreen(),
    const MailScreen(),
  ];

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

  void navigateIfNotCurrentRoute(String route) {
    if (ModalRoute.of(context)!.settings.name != route) {
      Navigator.pushNamed(context, route);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      print(index);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: AppBar(
            automaticallyImplyLeading: false,
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
                      if (_selectedIndex != 1) {
                        _onItemTapped(1);
                      }
                    },
                    icon: const Icon(Icons.person),
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : UserProvider(
                user: user,
                child: IndexedStack(
                  index: _selectedIndex,
                  children: _pages,
                ),
              ),
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
            /*onTap: (index) {
              if (_selectedIndex != 0) {
                _onItemTapped(0);
              }
            },*/
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
