import 'package:flutter/material.dart';
import '../../models/category.dart';
import '../../services/category_service.dart';

class CategoryEditScreen extends StatefulWidget {
  final Category category;

  CategoryEditScreen({required this.category});

  @override
  _CategoryEditScreenState createState() => _CategoryEditScreenState();
}

class _CategoryEditScreenState extends State<CategoryEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _categoryService = CategoryService();

  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category.name);
  }

  void _submitEdit() async {
    if (_formKey.currentState!.validate()) {
      final success = await _categoryService.editCategory(
        id: widget.category.id,
        name: _nameController.text.trim(),
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Categoría actualizada exitosamente")),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al actualizar categoría")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar Categoría")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Nombre de la categoría"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Campo obligatorio" : null,
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
