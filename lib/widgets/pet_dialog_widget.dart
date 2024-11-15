import 'package:community/models/Pet.dart';
import 'package:flutter/material.dart';

class PetModal extends StatefulWidget {

  final Pet? pet;
  final bool isEdit;
  final Function(String, String) onSave;

  const PetModal({
    super.key,
    this.pet,
    this.isEdit = false,
    required this.onSave
  });

  @override
  State<PetModal> createState() => _PetModalState();
}

class _PetModalState extends State<PetModal> {

  late TextEditingController nameController;
  late TextEditingController breedController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.isEdit ? widget.pet!.name : '');
    breedController = TextEditingController(text: widget.isEdit ? widget.pet!.breed : '');
  }

  @override
  void dispose() {
    nameController.dispose();
    breedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEdit ? 'Editar Mascota' : 'Registrar Mascota'),
      content: SingleChildScrollView(
        child: Form(
          child: !isLoading
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                    ),
                    TextFormField(
                      controller: breedController,
                      decoration: const InputDecoration(labelText: 'Raza'),
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
                )
              : const Center(child: CircularProgressIndicator()),
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
              widget.onSave(
                nameController.text,
                breedController.text
              );
              Navigator.of(context).pop();
            },
            child: const Text('Guardar'),
        ),
      ],
    );
  }
}
