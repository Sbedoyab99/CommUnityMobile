import 'package:community/dto/pqrs_dto.dart';
import 'package:community/services/pqrs_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:community/helper_enum/PqrsStateColorHelper.dart';
import 'package:community/helper_enum/PqrsStateHelper.dart';
import 'package:community/helper_enum/PqrsTypeHelper.dart';
import 'package:community/models/Pqrs.dart';
import 'package:community/models/User.dart';
import 'package:community/services/auth_service.dart';

class PqrsScreen extends StatefulWidget {
  const PqrsScreen({super.key});

  @override
  State<PqrsScreen> createState() => _PqrsScreenState();
}

class _PqrsScreenState extends State<PqrsScreen> {
  bool isLoading = true;
  int currentPage = 1;
  String? token;
  User? user;

  List<Pqrs> pqrss = [];

  final List<Map<String, String>> dropdownItemsType = [
    {'value': 'Request', 'label': 'Petición'},
    {'value': 'Complaint', 'label': 'Queja'},
    {'value': 'Claim', 'label': 'Reclamo'},
    {'value': 'Suggestion', 'label': 'Sugerencia'},
  ];

  final List<Map<String, String>> dropdownItemsStatus = [
    {'value': 'Settled', 'label': 'Radicada'},
    {'value': 'InReview', 'label': 'En Revisión'},
    {'value': 'InProgress', 'label': 'En Progeso'},
    {'value': 'Resolved', 'label': 'Resuelta'},
    {'value': 'Closed', 'label': 'Cerrada'},
  ];

  final List<Map<int, String>> dropdownItemsTypeAdd = [
    {0: 'Petición'},
    {1: 'Queja'},
    {2: 'Reclamo'},
    {3: 'Sugerencia'},
  ];

  final AuthService _authService = AuthService();
  final PqrsService _pqrsService = PqrsService();

  String filterValueType = 'Request';
  String filterValueStatus = 'Settled';

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
    await loadPqrs();
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

  Future<void> loadPqrs() async {
    if (token != null && user != null) {
      setState(() {
        isLoading = true;
      });
      if (currentPage == 1) {
        pqrss = await _pqrsService.fetchMail(token!, user!.residentialUnitId!,
            filterValueType, filterValueStatus, user!.apartmentId!,
            page: currentPage);
        print(pqrss);
      } else {
        List<Pqrs> newPqrss = await _pqrsService.fetchMail(
            token!,
            user!.residentialUnitId!,
            filterValueType,
            filterValueStatus,
            user!.apartmentId!,
            page: currentPage);

        if (newPqrss.length == 0) {
          currentPage = currentPage - 1;
        } else {
          pqrss.addAll(newPqrss);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void loadMorePqrss() {
    currentPage++;
    loadPqrs();
  }

  void onFilterChange(String newType, String newStatus) {
    setState(() {
      filterValueType = newType;
      filterValueStatus = newStatus;
      currentPage = 1;
    });
    loadPqrs();
  }

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  String formatContent(String content, int maxLength) {
    return content.length <= maxLength
        ? content
        : '${content.substring(0, maxLength)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            currentPage = 1;
          });
          await loadPqrs();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Text(
                'PQRS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade800,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      DropdownMenu<String>(
                        label: const Text('Tipo',
                            style: TextStyle(color: Colors.white)),
                        initialSelection: filterValueType,
                        onSelected: (String? value) {
                          if (value != null) {
                            setState(() {
                              filterValueType = value;
                              currentPage = 1;
                            });
                            loadPqrs();
                          }
                        },
                        dropdownMenuEntries: dropdownItemsType
                            .map((item) => DropdownMenuEntry<String>(
                                  value: item['value']!,
                                  label: item['label']!,
                                ))
                            .toList(),
                      ),
                      const SizedBox(width: 4),
                      DropdownMenu<String>(
                        label: const Text('Estado',
                            style: TextStyle(color: Colors.white)),
                        initialSelection: filterValueStatus,
                        onSelected: (String? value) {
                          if (value != null) {
                            setState(() {
                              filterValueStatus = value;
                              currentPage = 1;
                            });
                            loadPqrs();
                          }
                        },
                        dropdownMenuEntries: dropdownItemsStatus
                            .map((item) => DropdownMenuEntry<String>(
                                  value: item['value']!,
                                  label: item['label']!,
                                ))
                            .toList(),
                      ),
                    ],
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
                                Colors.deepPurple),
                          ),
                        ],
                      ),
                    )
                  : pqrss.isEmpty
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
                                  'No hay PQRS para mostrar',
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
                      : ListView.builder(
                          itemCount: pqrss.length + (pqrss.length >= 5 ? 1 : 0),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemBuilder: (context, index) {
                            if (index < pqrss.length) {
                              final pqrs = pqrss[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Text(
                                    "Nro. ${pqrs.id}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      buildRichText(
                                        "Tipo: ",
                                        PqrsTypeHelper.getDescription(
                                            pqrs.pqrsType!),
                                      ),
                                      buildRichText(
                                        "Estado: ",
                                        PqrsStateHelper.getDescription(
                                            pqrs.pqrsState),
                                        color: PqrsStateColorHelper.getColor(
                                            pqrs.pqrsState),
                                      ),
                                      buildRichText("Fecha Radicación: ",
                                          formatDate(pqrs.dateTime ?? ''),
                                          color: Colors.black54),
                                      buildRichText(
                                          "Contenido: ",
                                          formatContent(
                                              pqrs.content ?? '', 70)),
                                    ],
                                  ),
                                  onTap: () => showModalDetails(pqrs),
                                ),
                              );
                            } else {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: ElevatedButton.icon(
                                    onPressed: loadMorePqrss,
                                    icon: const Icon(Icons.add_circle),
                                    label: const Text('Cargar más'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.deepPurple.shade400,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPqrsModal(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple.shade400,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget buildRichText(String title, String value, {Color? color}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: color ?? Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  void showModalDetails(Pqrs pqrs) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.purple, size: 30),
              const SizedBox(width: 10),
              Text(
                'Detalles de PQRS Nro. ${pqrs.id}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                buildRichText(
                  "Tipo: ",
                  PqrsTypeHelper.getDescription(pqrs.pqrsType!),
                ),
                buildRichText(
                  "Estado: ",
                  PqrsStateHelper.getDescription(pqrs.pqrsState),
                  color: PqrsStateColorHelper.getColor(pqrs.pqrsState),
                ),
                buildRichText(
                  "Fecha Radicación: ",
                  formatDate(pqrs.dateTime ?? ''),
                  color: Colors.black54,
                ),
                buildRichText(
                  "Contenido: ",
                  formatContent(pqrs.content ?? '', 3000),
                  // Ajusta el número para el contenido completo
                  color: Colors.black54,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cerrar',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddPqrsModal(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    int selectedType = 0;
    String content = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Agregar PQRS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        DropdownButtonFormField<int>(
                          value: selectedType,
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedType = newValue!;
                            });
                          },
                          items: dropdownItemsTypeAdd
                              .map<DropdownMenuItem<int>>(
                                  (Map<int, String> item) =>
                                      DropdownMenuItem<int>(
                                        value: item.keys.first,
                                        child: Text(item.values.first),
                                      ))
                              .toList(),
                          decoration: const InputDecoration(
                            labelText: 'Tipo de PQRS',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value < 0) {
                              return 'Seleccione un tipo de PQRS';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          onChanged: (value) {
                            content = value;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Contenido',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'El contenido es obligatorio';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _addPqrs(selectedType, content);
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Guardar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _addPqrs(int type, String content) async {
    setState(() {
      isLoading = true;
    });

    try {
      final pqrsDTO = PqrsDTO(
          dateTime: DateTime.now(),
          type: type,
          content: content,
          status: 0,
          apartmentId: user!.apartmentId!,
          residentialUnitId: user!.residentialUnitId!);

      final success = await _pqrsService.createPqrs(token, pqrsDTO);

      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pqrs registrada con éxito.')),
        );

        setState(() {
          currentPage = 1;
        });

        await loadPqrs();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al crear la pqrs.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al crear la pqrs.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
