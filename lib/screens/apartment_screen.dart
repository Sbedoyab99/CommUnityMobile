import 'package:community/models/Pet.dart';
import 'package:community/models/User.dart';
import 'package:community/models/Vehicle.dart';
import 'package:community/providers/user_provider.dart';
import 'package:community/services/apartment_service.dart';
import 'package:community/services/auth_service.dart';
import 'package:community/services/pet_service.dart';
import 'package:community/services/user_service.dart';
import 'package:community/services/vehicle_service.dart';
import 'package:community/widgets/user_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:community/models/Apartment.dart' as ap;

class ApartmentScreen extends StatefulWidget {
  const ApartmentScreen({super.key});

  @override
  State<ApartmentScreen> createState() => _ApartmentScreenState();
}

class _ApartmentScreenState extends State<ApartmentScreen> {
  bool isLoading = false;
  String? token;
  User? user;
  ap.Apartment? apartment;
  List<Pet>? pets;
  List<Vehicle>? vehicles;
  List<User>? residents;

  final AuthService _authService = AuthService();
  final ApartmentService _apartmentService = ApartmentService();
  final PetService _petService = PetService();
  final VehicleService _vehicleService = VehicleService();
  final UserService _userService = UserService();

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
    apartment = await loadApartment(token!, user!.apartmentId!);
    pets = await loadPet(token!, apartment!.id!);
    vehicles = await loadVehicle(token!, apartment!.id!);
    residents = await loadResidents(token!, apartment!.id!);
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

  Future<ap.Apartment> loadApartment(String token, num id) async {
    final apartment = await _apartmentService.fetchApartment(token, id);
    return apartment;
  }

  Future<List<Pet>> loadPet(String token, num id) async {
    final pets = await _petService.fetchPets(token, id);
    return pets;
  }

  Future<List<Vehicle>> loadVehicle(String token, num id) async {
    final vehicles = await _vehicleService.fetchVehicles(token, id);
    return vehicles;
  }

  Future<List<User>> loadResidents(String token, num id) async {
    final residents = await _userService.fetchUsers(token, id);
    return residents;
  }

  List<User> filterResidents(User user, List<User> residents) {
    return residents.where((resident) => resident.id != user.id).toList();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Center(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: loadAsync,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Center(
                        child: Text(
                          'Mi Apartamento: ${apartment?.number!}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      UserCard(user: user),
                      const SizedBox(height: 24),
                      const Center(
                        child: Text(
                          'Mi Grupo',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      filterResidents(user!, residents!).isNotEmpty
                      ? ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: filterResidents(user!, residents!).length,
                        itemBuilder: (context, index) {
                          final residentsList = filterResidents(user!, residents!);
                          final residentItem = residentsList[index];
                          return UserCard(user: residentItem);
                        },
                      ) : const Center(
                        child: Text(
                          'No hay mas residentes en tu apartamento',
                          style: TextStyle(
                              fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}


