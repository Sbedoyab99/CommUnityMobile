import 'package:community/models/User.dart';
import 'package:community/providers/user_provider.dart';
import 'package:community/screens/apartment_screen.dart';
import 'package:community/screens/home_screen.dart';
import 'package:community/screens/pqrs_screen.dart';
import 'package:community/screens/visitor_entry_screen.dart';
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
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  String? token;
  bool isLoading = true;
  User? user;
  int _selectedIndex = 0;

  final Map<int, String> _routes = {
    0: '/home',
    1: '/visitorEntry',
    2: '/mail',
    3: '/pqrs',
    4: '/apartment'
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

  /* @override
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
                    case '/visitorEntry':
                      builder = (context) => const VisitorEntryScreen();
                      break;
                    case '/mail':
                      builder = (context) => const MailScreen();
                      break;
                    case '/pqrs':
                      builder = (context) => const PqrsScreen();
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
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Apartamento',
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
  }*/

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            height: 160,
            decoration: BoxDecoration(
              color: Colors.deepPurple[700],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 60.0,
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
                        fontSize: 14, // Texto más pequeño
                        fontWeight: FontWeight.bold,
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
                    case '/visitorEntry':
                      builder = (context) => const VisitorEntryScreen();
                      break;
                    case '/mail':
                      builder = (context) => const MailScreen();
                      break;
                    case '/pqrs':
                      builder = (context) => const PqrsScreen();
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
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
              backgroundColor: Colors.deepPurple[700],
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(0.7),
              showSelectedLabels: true,
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
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Apartamento',
                ),
              ],
              onTap: (index) {
                if (_selectedIndex != index) {
                  _onItemTapped(index);
                }
              },
              selectedLabelStyle: const TextStyle(
                fontSize:
                    9,
              )),
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple[700]!, Colors.deepPurple[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              // borderRadius: const BorderRadius.only(
              //   bottomLeft: Radius.circular(30),
              //   bottomRight: Radius.circular(30),
              // ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 60.0,
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
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
                    case '/visitorEntry':
                      builder = (context) => const VisitorEntryScreen();
                      break;
                    case '/mail':
                      builder = (context) => const MailScreen();
                      break;
                    case '/pqrs':
                      builder = (context) => const PqrsScreen();
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
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.deepPurple[700],
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.7),
            showSelectedLabels: true,
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
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Apartamento',
              ),
            ],
            onTap: (index) {
              if (_selectedIndex != index) {
                _onItemTapped(index);
              }
            },
            selectedLabelStyle: const TextStyle(
              fontSize: 9,
              fontWeight:
                  FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}
