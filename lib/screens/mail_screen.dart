import 'package:community/models/Mail.dart';
import 'package:community/services/mail_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../dto/mail_dto.dart';
import '../models/User.dart';
import '../services/auth_service.dart';

class MailScreen extends StatefulWidget {
  const MailScreen({super.key});

  @override
  State<MailScreen> createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  bool isLoading = true;
  int currentPage = 1;
  String? token;
  User? user;
  List<Mail> mails = [];

  final List<Map<String, String>> dropdownItems = [
    {'value': 'Stored', 'label': 'Almacenado'},
    {'value': 'Delivered', 'label': 'Entregado'},
  ];

  final AuthService _authService = AuthService();
  final MailService _mailService = MailService();

  String filterValue = 'Stored';

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
    await loadMail();
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

  Future<void> loadMail() async {
    if (token != null && user != null) {
      setState(() {
        isLoading = true;
      });
      if (currentPage == 1) {
        mails = await _mailService.fetchMail(
            token!, user!.apartmentId!, filterValue,
            page: currentPage);
      } else {
        List<Mail> newMails = await _mailService.fetchMail(
            token!, user!.apartmentId!, filterValue,
            page: currentPage);

        if (newMails.length == 0) {
          currentPage = currentPage - 1;
        } else {
          mails.addAll(newMails);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void loadMoreMails() {
    currentPage++;
    loadMail();
  }

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('dd/MM/yyyy').format(dateTime);
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
          await loadMail();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Text(
                'Correspondencia',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade800,
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 110, vertical: 12),
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
                        label: const Text('Estado',
                            style: TextStyle(color: Colors.white)),
                        initialSelection: filterValue,
                        onSelected: (String? value) {
                          if (value != null) {
                            setState(() {
                              filterValue = value;
                              currentPage = 1;
                            });
                            loadMail();
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
                  : mails.isEmpty
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
                                  'No hay correspondencia para mostrar',
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
                          itemCount: mails.length + (mails.length >= 5 ? 1 : 0),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemBuilder: (context, index) {
                            if (index < mails.length) {
                              final mail = mails[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Text(
                                    mail.sender ?? "No title",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      Text("Tipo: ${mail.type}",
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                      Text(
                                        "Estado: ${mail.status == 1 ? 'Almacenado' : 'Entregado'}",
                                        style: TextStyle(
                                            color: mail.status == 1
                                                ? Colors.red
                                                : Colors.green),
                                      ),
                                      Text(
                                          "Fecha: ${formatDate(mail.dateTime!)}"),
                                    ],
                                  ),
                                  trailing: mail.status == 1
                                      ? ElevatedButton(
                                          onPressed: () {
                                            _showMarkAsReceivedDialog(mail);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                  size: 16,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              const Text(
                                                'Recibir',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade100,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                        ),
                                ),
                              );
                            } else {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: ElevatedButton.icon(
                                    onPressed: loadMoreMails,
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
    );
  }

  void _showMarkAsReceivedDialog(Mail mail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Marcar como recibida"),
          content: const Text(
              "¿Estás seguro de que deseas marcar esta correspondencia como recibida?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _markAsReceived(mail);
              },
              child: const Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _markAsReceived(Mail mail) async {
    setState(() {
      isLoading = true;
    });

    try {
      final mailDTO = MailDTO(
          id: mail.id,
          Sender: 'defaul sender',
          Type: mail.type,
          Status: 0,
          ApartmentId: user!.apartmentId!);

      final success = await _mailService.editMail(token, mailDTO);

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Correo marcado como recibido')),
        );
        setState(() {
          currentPage = 1;
        });
        await loadMail();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error al actualizar el estado del correo')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error al intentar actualizar el correo')),
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
