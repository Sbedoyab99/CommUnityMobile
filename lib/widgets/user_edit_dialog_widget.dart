import 'package:community/models/User.dart';
import 'package:flutter/material.dart';

class UserEditModal extends StatefulWidget {

  final User user;
  final Function(String, String, String) onSave;

  const UserEditModal({super.key, required this.user, required this.onSave});

  @override
  State<UserEditModal> createState() => _UserEditModalState();
}

class _UserEditModalState extends State<UserEditModal> {

  late TextEditingController nameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.firstName);
    lastNameController = TextEditingController(text: widget.user.lastName);
    phoneNumberController = TextEditingController(text: widget.user.phoneNumber);
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void closeModal(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Usuario'),
      content: SingleChildScrollView(
        child: Form(
          child: !isLoading ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    labelText: 'Nombre'
                ),
              ),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(
                    labelText: 'Apellido'
                ),
              ),
              TextFormField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                ),
                keyboardType: TextInputType.phone,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  'Nota: Esta funcionalidad está en fase Beta. Para más opciones de edición, utiliza la aplicación web.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ) : const Center(child: CircularProgressIndicator()),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              isLoading = true;
            });
            print('Nombre desde el callback: ${nameController.text}');
            widget.onSave(
                nameController.text,
                lastNameController.text,
                phoneNumberController.text
            );
            closeModal(context);
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
