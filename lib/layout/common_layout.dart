import 'package:community/models/User.dart';
import 'package:community/providers/user_provider.dart';
import 'package:community/screens/apartment_screen.dart';
import 'package:community/screens/home_screen.dart';
import 'package:community/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonLayout extends StatefulWidget {
  const CommonLayout({super.key});

  @override
  State<CommonLayout> createState() => _CommonLayoutState();
}

class _CommonLayoutState extends State<CommonLayout> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  String? token;
  bool isLoading = true;
  User? user;
  int _selectedIndex = 0;

  final Map<int, String> _routes = {
    0: '/home',
    1: '/apartment',
  };

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

  void navigateLogOut(String route) {
    Navigator.pushReplacementNamed(context, route);
  }

  void navigateIfNotCurrentRoute(String route) {
    if (ModalRoute.of(context)!.settings.name != route) {
      Navigator.pushNamed(context, route);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(_routes[index]!, (route) => false);
  }

  Future<void> logout() async {
    await _authService.logOut();
    navigateLogOut('/login');
  }

  void _openLogOutModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Estas seguro?'),
          content: const Text('Deseas cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                logout();
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          automaticallyImplyLeading: true,
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
                Expanded(
                  child: Text(
                    isLoading ? 'Cargando...' : user!.residentialUnit!.name!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
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
                ),
                IconButton(
                  onPressed: () => _openLogOutModal(context),
                  icon: const Icon(Icons.logout),
                  color: Colors.white,
                ),
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
              child: Navigator(
                key: GlobalKey<NavigatorState>(),
                initialRoute: _routes[_selectedIndex],
                onGenerateRoute: (settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case '/home':
                      builder = (context) => const HomePage();
                      break;
                    case '/apartment':
                      builder = (context) => const ApartmentScreen();
                      break;
                    default:
                      builder = (BuildContext _) => const HomePage();
                  }
                  return MaterialPageRoute(
                      builder: builder, settings: settings);
                },
              ),
            ),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
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
            if (_selectedIndex != index) {
              _onItemTapped(index);
            }
          },
        ),
      ),
    );
  }
}
