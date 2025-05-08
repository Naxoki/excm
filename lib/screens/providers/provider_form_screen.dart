import 'package:flutter/material.dart';
import '../../services/provider_service.dart';

class ProviderFormScreen extends StatefulWidget {
  @override
  _ProviderFormScreenState createState() => _ProviderFormScreenState();
}

class _ProviderFormScreenState extends State<ProviderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  final _providerService = ProviderService();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final success = await _providerService.addProvider(
        name: _nameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Proveedor agregado correctamente")),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al agregar proveedor")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agregar Proveedor")),
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
                onPressed: _submitForm,
                child: Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
