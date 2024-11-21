import 'package:community/models/VisitorEntry.dart';
import 'package:community/services/visitor_entry_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dto/visitor_entry_dto.dart';
import '../helper_enum/VisitorStateColorHelper.dart';
import '../helper_enum/VisitorStateHelper.dart';
import '../models/User.dart';
import '../services/auth_service.dart';

class VisitorEntryScreen extends StatefulWidget {
  const VisitorEntryScreen({super.key});

  @override
  State<VisitorEntryScreen> createState() => _VisitorEntryScreenState();
}

class _VisitorEntryScreenState extends State<VisitorEntryScreen> {
  bool isLoading = true;
  String? token;
  User? user;
  List<VisitorEntry> visitorEntries = [];
  int currentPage = 1;

  final List<Map<String, String>> dropdownItems = [
    {'value': 'Scheduled', 'label': 'Programado'},
    {'value': 'Approved', 'label': 'Aprobado'},
    {'value': 'Canceled', 'label': 'Cancelado'},
  ];

  final AuthService _authService = AuthService();
  final VisitorEntryService _visitorEntryService = VisitorEntryService();

  String filterValue = 'Scheduled';

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
    await loadVisitorEntry();
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

  Future<void> loadVisitorEntry() async {
    if (token != null && user != null) {
      setState(() {
        isLoading = true;
      });
      if (currentPage == 1) {
        visitorEntries =
            await _visitorEntryService.fetchVisitorEntriesByApartment(
                token!, user!.apartmentId!, filterValue,
                page: currentPage);
      } else {
        List<VisitorEntry> newVisitorEntries =
            await _visitorEntryService.fetchVisitorEntriesByApartment(
                token!, user!.apartmentId!, filterValue,
                page: currentPage);

        if (newVisitorEntries.length == 0) {
          currentPage = currentPage - 1;
        } else {
          visitorEntries.addAll(newVisitorEntries);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void loadMoreVisitorEntries() {
    currentPage++;
    loadVisitorEntry();
  }

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            currentPage = 1;
          });
          await loadVisitorEntry();
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade200,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.people_alt, color: Colors.white, size: 36),
                      SizedBox(width: 10),
                      Text(
                        "Visitas",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  DropdownMenu<String>(
                    label: const Text(
                      'Estado',
                      style: TextStyle(color: Colors.white),
                    ),
                    initialSelection: dropdownItems.first['value']!,
                    onSelected: (String? value) {
                      if (value != null) {
                        setState(() {
                          filterValue = value;
                          currentPage = 1;
                        });
                        loadVisitorEntry();
                      }
                    },
                    dropdownMenuEntries: dropdownItems
                        .map((item) => DropdownMenuEntry<String>(
                              value: item['value']!,
                              label: item['label']!,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/Recurso2.png',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(height: 20),
                          const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.deepPurpleAccent),
                          ),
                        ],
                      ),
                    )
                  : visitorEntries.isEmpty
                      ? Center(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.info,
                                    size: 50, color: Colors.deepPurple),
                                SizedBox(height: 10),
                                Text(
                                  'No hay visitas para mostrar',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: visitorEntries.length +
                              (visitorEntries.length >= 5 ? 1 : 0),
                          padding: const EdgeInsets.all(12),
                          itemBuilder: (context, index) {
                            if (index < visitorEntries.length) {
                              final visitorEntry = visitorEntries[index];
                              return Card(
                                elevation: 5,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Text(
                                    "Visitante: ${visitorEntry.name ?? "Sin nombre"}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Placa: ${visitorEntry.plate ?? "Sin vehículo"}",
                                        style: const TextStyle(
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        "Estado: ${VisitorStateHelper.getDescription(visitorEntry.status)}",
                                        style: TextStyle(
                                          color:
                                              VisitorStateColorHelper.getColor(
                                                  visitorEntry.status),
                                        ),
                                      ),
                                      Text(
                                        "Fecha: ${formatDate(visitorEntry.dateTime!)}",
                                        style: const TextStyle(
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  trailing: visitorEntry.status != 2
                                      ? ElevatedButton.icon(
                                          onPressed: () {
                                            _showMarkAsCanceledDialog(
                                                visitorEntry);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                visitorEntry.status == 0
                                                    ? Colors.orange
                                                    : Colors.green,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          icon: const Icon(Icons.close,
                                              size: 18, color: Colors.white),
                                          label: const Text(
                                            'Cancelar',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ),
                              );
                            } else {
                              return visitorEntries.length >= 5
                                  ? Center(
                                      child: ElevatedButton.icon(
                                        onPressed: loadMoreVisitorEntries,
                                        icon: const Icon(Icons.add_circle),
                                        label: const Text('Ver más'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.deepPurple.shade400,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 20),
                                        ),
                                      ),
                                    )
                                  : Container();
                            }
                          },
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddVisitorDialog,
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple.shade400,
        foregroundColor: Colors.white,
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            currentPage = 1;
          });
          await loadVisitorEntry();
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade200,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.people_alt, color: Colors.white, size: 36),
                      SizedBox(width: 10),
                      Text(
                        "Visitas",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  DropdownMenu<String>(
                    label: const Text(
                      'Estado',
                      style: TextStyle(color: Colors.white),
                    ),
                    initialSelection: dropdownItems.first['value']!,
                    onSelected: (String? value) {
                      if (value != null) {
                        setState(() {
                          filterValue = value;
                          currentPage = 1;
                        });
                        loadVisitorEntry();
                      }
                    },
                    dropdownMenuEntries: dropdownItems
                        .map((item) => DropdownMenuEntry<String>(
                              value: item['value']!,
                              label: item['label']!,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/Recurso2.png',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(height: 20),
                          const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.deepPurpleAccent),
                          ),
                        ],
                      ),
                    )
                  : visitorEntries.isEmpty
                      ? Center(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.info,
                                    size: 50, color: Colors.deepPurple),
                                SizedBox(height: 10),
                                Text(
                                  'No hay visitas para mostrar',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: visitorEntries.length +
                              (visitorEntries.length >= 5 ? 1 : 0),
                          padding: const EdgeInsets.all(12),
                          itemBuilder: (context, index) {
                            if (index < visitorEntries.length) {
                              final visitorEntry = visitorEntries[index];
                              return Card(
                                elevation: 5,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Visitante: ${visitorEntry.name ?? "Sin nombre"}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "Placa: ${visitorEntry.plate ?? "Sin vehículo"}",
                                              style: const TextStyle(
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                              "Estado: ${VisitorStateHelper.getDescription(visitorEntry.status)}",
                                              style: TextStyle(
                                                color: VisitorStateColorHelper
                                                    .getColor(
                                                        visitorEntry.status),
                                              ),
                                            ),
                                            Text(
                                              "Fecha: ${formatDate(visitorEntry.dateTime!)}",
                                              style: const TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                      visitorEntry.status != 2
                                          ? SizedBox(
                                              width:
                                                  150,
                                              child: ElevatedButton.icon(
                                                onPressed: () {
                                                  _showMarkAsCanceledDialog(
                                                      visitorEntry);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      visitorEntry.status == 0
                                                          ? Colors.orange
                                                          : Colors.green,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                icon: const Icon(Icons.close,
                                                    size: 18,
                                                    color: Colors.white),
                                                label: const Text(
                                                  'Cancelar',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return visitorEntries.length >= 5
                                  ? Center(
                                      child: ElevatedButton.icon(
                                        onPressed: loadMoreVisitorEntries,
                                        icon: const Icon(Icons.add_circle),
                                        label: const Text('Ver más'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.deepPurple.shade400,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 20),
                                        ),
                                      ),
                                    )
                                  : Container();
                            }
                          },
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddVisitorDialog,
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple.shade400,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _showMarkAsCanceledDialog(VisitorEntry visitorEntry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Cancelar Visita"),
          content:
              const Text("¿Estás seguro de que deseas cancelar esta visita?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _cancelVisitorEntry(visitorEntry);
              },
              child: const Text("Sí"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _cancelVisitorEntry(VisitorEntry visitorEntry) async {
    if (token == null) {
      return;
    }
    VisitorEntryDTO visitorEntryDTO = VisitorEntryDTO(
        id: visitorEntry.id,
        name: visitorEntry.name ?? '',
        plate: visitorEntry.plate,
        date: DateTime.parse(visitorEntry.dateTime!),
        status: 2,
        apartmentId: user!.apartmentId!);

    try {
      bool success = await _visitorEntryService.cancelVisitorEntry(
          token!, visitorEntryDTO);

      if (success) {
        setState(() {
          visitorEntries.removeWhere((entry) => entry.id == visitorEntry.id);
          loadVisitorEntry();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Visita cancelada exitosamente')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al cancelar la visita')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  Future<void> _showAddVisitorDialog() async {
    final _formKey = GlobalKey<FormState>();
    String? name, plate;
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Programar  Visita"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Campo para el nombre
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value;
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Placa (opcional)'),
                  onSaved: (value) {
                    plate = value;
                  },
                ),
                ListTile(
                  title: Text(
                      "Fecha: ${DateFormat('dd/MM/yyyy').format(selectedDate)}"),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  await _addVisitorEntry(name!, plate, selectedDate);
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Guardar"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addVisitorEntry(
      String name, String? plate, DateTime date) async {
    if (token == null) {
      return;
    }

    VisitorEntryDTO visitorEntryDTO = VisitorEntryDTO(
      name: name,
      plate: plate,
      date: date,
      status: 0,
      apartmentId: user!.apartmentId!,
    );

    try {
      bool success =
          await _visitorEntryService.scheduleVisitor(token!, visitorEntryDTO);

      if (!mounted) return;

      if (success) {
        setState(() {
          visitorEntries.insert(
              0,
              VisitorEntry(
                name: name,
                plate: plate ?? '',
                dateTime: date.toIso8601String(),
                status: 0,
              ));
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Visita añadida con éxito')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al añadir la visita')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
