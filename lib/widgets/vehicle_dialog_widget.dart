import 'package:community/models/Vehicle.dart';
import 'package:flutter/material.dart';

class VehicleModal extends StatefulWidget {

  final Vehicle? vehicle;
  final bool isEdit;
  final Function(String, String, String) onSave;

  const VehicleModal({
    super.key,
    this.vehicle,
    this.isEdit = false,
    required this.onSave
  });

  @override
  State<VehicleModal> createState() => _VehicleModalState();
}

class _VehicleModalState extends State<VehicleModal> {

  late TextEditingController plateController;
  late TextEditingController descriptionController;
  bool isLoading = false;

  final List<String> vehicleTypes = ["Automovil", "Motocicleta", "Camioneta"];
  late String? selectedVehicleType;

  @override
  void initState() {
    super.initState();
    plateController = TextEditingController(text: widget.isEdit ? widget.vehicle!.plate : '');
    selectedVehicleType = widget.isEdit ? widget.vehicle!.type : vehicleTypes[0];
    descriptionController = TextEditingController(text: widget.isEdit ? widget.vehicle!.description : '');
  }

  @override
  void dispose() {
    plateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEdit ? 'Editar Vehiculo' : 'Registrar Vehiculo'),
      content: SingleChildScrollView(
        child: Form(
          child: !isLoading
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: plateController,
                decoration: const InputDecoration(labelText: 'Placa'),
              ),
              DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Tipo'),
                  value: selectedVehicleType,
                  items: vehicleTypes.map((String type) {
                    return DropdownMenuItem<String>(
                        value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedVehicleType = value;
                    });
                  }
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Descripcion'),
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
                plateController.text,
                selectedVehicleType!,
                descriptionController.text
            );
            Navigator.of(context).pop();
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
