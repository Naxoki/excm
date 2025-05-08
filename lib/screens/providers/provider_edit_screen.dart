import 'package:flutter/material.dart';
import '../../models/provider.dart';
import '../../services/provider_service.dart';

class ProviderEditScreen extends StatefulWidget {
  final Provider provider;

  ProviderEditScreen({required this.provider});

  @override
  _ProviderEditScreenState createState() => _ProviderEditScreenState();
}

class _ProviderEditScreenState extends State<ProviderEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _providerService = ProviderService();

  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.provider.name);
    _lastNameController = TextEditingController(text: widget.provider.lastName);
    _emailController = TextEditingController(text: widget.provider.email);
  }

  void _submitEdit() async {
    if (_formKey.currentState!.validate()) {
      final success = await _providerService.editProvider(
        id: widget.provider.id,
        name: _nameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Proveedor actualizado correctamente")),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al actualizar proveedor")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar Proveedor")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Nombre"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Requerido" : null,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: "Apellido"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Requerido" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Correo"),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Requerido";
                  if (!value.contains("@")) return "Correo inválido";
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitEdit,
                child: Text("Guardar Cambios"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
