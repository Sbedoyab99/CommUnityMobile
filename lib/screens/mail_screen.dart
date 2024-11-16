import 'package:community/models/Mail.dart';
import 'package:community/services/mail_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../dto/MailDTO.dart';
import '../models/User.dart';
import '../services/auth_service.dart';

class MailScreen extends StatefulWidget {
  const MailScreen({super.key});

  @override
  State<MailScreen> createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  bool isLoading = true;
  String? token;
  User? user;
  List<Mail> mails = [];

  int currentPage = 1;

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

  /*Future<void> loadMail() async {
    if (token != null && user != null) {
      setState(() {
        isLoading = true;
      });
      mails =
          await _mailService.fetchMail(token!, user!.apartmentId!, filterValue);
      setState(() {
        isLoading = false;
      });
    }
  }*/

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
        mails.addAll(newMails);
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.purple.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Correspondencia",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownMenu<String>(
                    initialSelection: dropdownItems.first['value']!,
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
                ),
              ],
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
                )
              : mails.isEmpty
                  ? const Center(
                      child: Text('No hay correspondencia para mostrar'))
                  : Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: ListView.separated(
                          itemCount:
                              mails.length + 1,
                          itemBuilder: (context, index) {
                            if (index < mails.length) {
                              final mail = mails[index];
                              return Card(
                                elevation: 5,
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
                                      Text("Tipo: ${mail.type}",
                                          style: TextStyle(color: Colors.grey)),
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
                                          child: const Text(
                                              "Marcar como Recibido"),
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
                              return Center(
                                child: ElevatedButton(
                                  onPressed: loadMoreMails,
                                  child: const Text('Ver más'),
                                ),
                              );
                            }
                          },
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                        ),
                      ),
                    ),
        ],
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
      print('Error al marcar como recibido: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
