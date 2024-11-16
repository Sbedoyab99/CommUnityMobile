import 'package:community/dto/pet_dto.dart';
import 'package:community/dto/user_edit_dto.dart';
import 'package:community/dto/vehicle_dto.dart';
import 'package:community/models/Pet.dart';
import 'package:community/models/User.dart';
import 'package:community/models/Vehicle.dart';
import 'package:community/providers/user_provider.dart';
import 'package:community/services/apartment_service.dart';
import 'package:community/services/pet_service.dart';
import 'package:community/services/user_service.dart';
import 'package:community/services/vehicle_service.dart';
import 'package:community/widgets/pet_card_widget.dart';
import 'package:community/widgets/pet_dialog_widget.dart';
import 'package:community/widgets/user_card_widget.dart';
import 'package:community/widgets/user_edit_dialog_widget.dart';
import 'package:community/widgets/vehicle_dialog_widget.dart';
import 'package:community/widgets/vehicle_tile_widget.dart';
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
  final ValueNotifier<User?> _user = ValueNotifier(null);
  User? user;
  ap.Apartment? apartment;
  List<Pet>? pets;
  List<Vehicle>? vehicles;
  List<User>? residents;

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
    user = getUser();
    setUser();
    apartment = await loadApartment(token!, user!.apartmentId!);
    pets = await loadPet(token!, apartment!.id!);
    vehicles = await loadVehicle(token!, apartment!.id!);
    residents = await loadResidents(token!, apartment!.id!);
    setState(() {
      isLoading = false;
    });
  }

  User? getUser() {
    return UserProvider.of(context)?.user;
  }

  void setUser() {
    _user.value = user;
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

  List<User> filterResidents(User? user, List<User> residents) {
    return residents.where((resident) => resident.id != user!.id).toList();
  }

  Future<void> editUser(
      String firstName, String lastName, String phoneNumber) async {
    final userProvider = UserProvider.of(context);

    final userdto = UserEditDTO(
        firstName: firstName, lastName: lastName, phoneNumber: phoneNumber);
    setState(() {
      isLoading = true;
    });
    await userProvider?.editUser(userdto, token);
    setUser();
    print('Nombre desde Apartment: ${user!.firstName}');
    setState(() {
      isLoading = false;
    });
  }

  void _openUserModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return UserEditModal(
          user: user!,
          onSave: (firstName, lastName, phoneNumber) async {
            await editUser(firstName, lastName, phoneNumber);
          },
        );
      },
    );
  }

  Future<void> onSavePet(String name, String breed,
      {num? id = 0, bool isEdit = false}) async {
    final PetDTO petdto = PetDTO(
        id: id,
        Name: name,
        Breed: breed,
        Picture: null,
        ApartmentId: user!.apartmentId);
    late final bool result;
    if (isEdit) {
      result = await _petService.editPet(token, petdto);
    } else {
      result = await _petService.createPet(token, petdto);
    }
    if (result) {
      setState(() {
        isLoading = true;
      });
      pets = await loadPet(token!, apartment!.id!);
      setState(() {
        isLoading = false;
      });
    }
  }

  void _openNewPetModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return PetModal(
          onSave: (name, breed) {
            onSavePet(name, breed);
          },
          isEdit: false,
        );
      },
    );
  }

  void _openEditPetModal(BuildContext context, Pet pet) {
    showDialog(
      context: context,
      builder: (context) {
        return PetModal(
          pet: pet,
          onSave: (name, breed) {
            onSavePet(name, breed, id: pet.id, isEdit: true);
          },
          isEdit: true,
        );
      },
    );
  }

  Future<void> deletePet(num petId) async {
    final result = await _petService.deletePet(token!, petId);
    if (result) {
      setState(() {
        isLoading = true;
      });
      pets = await loadPet(token!, apartment!.id!);
      setState(() {
        isLoading = false;
      });
    }
  }

  void _openDeletePetModal(BuildContext context, Pet pet) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Estas seguro?'),
          content: Text(
              'Estas seguro de que deseas eliminar a ${pet.name}? Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                deletePet(pet.id!);
                Navigator.of(context).pop();
              },
              child:
                  const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> onSaveVehicle(String plate, String type, String description,
      {num? id = 0, bool isEdit = false}) async {
    final VehicleDTO vehicledto = VehicleDTO(
        id: id,
        plate: plate,
        type: type,
        description: description,
        apartmentId: user!.apartmentId);
    late final bool result;
    if (isEdit) {
      result = await _vehicleService.editVehicle(token, vehicledto);
    } else {
      result = await _vehicleService.createVehicle(token, vehicledto);
    }
    if (result) {
      setState(() {
        isLoading = true;
      });
      vehicles = await loadVehicle(token!, apartment!.id!);
      setState(() {
        isLoading = false;
      });
    }
  }

  void _openNewVehicleModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return VehicleModal(
          onSave: (plate, type, description) {
            onSaveVehicle(plate, type, description);
          },
          isEdit: false,
        );
      },
    );
  }

  void _openEditVehicleModal(BuildContext context, Vehicle vehicle) {
    showDialog(
      context: context,
      builder: (context) {
        return VehicleModal(
          vehicle: vehicle,
          onSave: (plate, type, description) {
            onSaveVehicle(plate, type, description,
                id: vehicle.id, isEdit: true);
          },
          isEdit: true,
        );
      },
    );
  }

  Future<void> deleteVehicle(num vehicleId) async {
    final result = await _vehicleService.deleteVehicle(token!, vehicleId);
    if (result) {
      setState(() {
        isLoading = true;
      });
      vehicles = await loadVehicle(token!, apartment!.id!);
      setState(() {
        isLoading = false;
      });
    }
  }

  void _openDeleteVehicleModal(BuildContext context, Vehicle vehicle) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Estas seguro?'),
          content: Text(
              'Estas seguro de que deseas eliminar el vehiculo con placa ${vehicle.plate}? Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                deleteVehicle(vehicle.id!);
                Navigator.of(context).pop();
              },
              child:
                  const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
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
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Center(
                          child: Text(
                            'Mi Apartamento: ${apartment?.number!}',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ValueListenableBuilder<User?>(
                          valueListenable: _user,
                          builder: (context, value, child) {
                            return UserCard(
                              key: UniqueKey(),
                              user: value,
                              isUser: true,
                              onEdit: () => _openUserModal(context),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        const Center(
                          child: Text(
                            'Mi Grupo',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 24),
                        filterResidents(user, residents!).isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount:
                                    filterResidents(user, residents!).length,
                                itemBuilder: (context, index) {
                                  final residentsList =
                                      filterResidents(user, residents!);
                                  final residentItem = residentsList[index];
                                  return UserCard(user: residentItem);
                                },
                              )
                            : const Center(
                                child: Text(
                                  'No hay más residentes en tu apartamento',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                        const SizedBox(height: 24),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Mis Mascotas',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () => _openNewPetModal(context),
                                icon: const Icon(Icons.add_box_outlined,
                                    color: Colors.blueAccent),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        pets!.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: pets!.length,
                                itemBuilder: (context, index) {
                                  final pet = pets![index];
                                  return PetCard(
                                    pet: pet,
                                    onEdit: () =>
                                        _openEditPetModal(context, pet),
                                    onDelete: () =>
                                        _openDeletePetModal(context, pet),
                                  );
                                },
                              )
                            : const Center(
                                child: Text(
                                  'No hay mascotas en tu apartamento',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                        const SizedBox(height: 24),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Mis Vehiculos',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () => _openNewVehicleModal(context),
                                icon: const Icon(Icons.add_box_outlined,
                                    color: Colors.blueAccent),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: vehicles!.length,
                          itemBuilder: (context, index) {
                            final vehicle = vehicles![index];
                            return VehicleTile(
                              vehicle: vehicles![index],
                              onEdit: () =>
                                  _openEditVehicleModal(context, vehicle),
                              onDelete: () =>
                                  _openDeleteVehicleModal(context, vehicle),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
