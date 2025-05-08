import 'package:flutter/material.dart';
import '../../models/provider.dart';
import '../../services/provider_service.dart';
import 'provider_edit_screen.dart';

class ProviderListScreen extends StatefulWidget {
  @override
  _ProviderListScreenState createState() => _ProviderListScreenState();
}

class _ProviderListScreenState extends State<ProviderListScreen> {
  final ProviderService _providerService = ProviderService();
  late Future<List<Provider>> _providers;

  @override
  void initState() {
    super.initState();
    _loadProviders();
  }

  void _loadProviders() {
    _providers = _providerService.getProviders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Proveedores")),
      body: FutureBuilder<List<Provider>>(
        future: _providers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final providers = snapshot.data!;
          if (providers.isEmpty) {
            return Center(child: Text("No hay proveedores."));
          }

          return ListView.builder(
            itemCount: providers.length,
            itemBuilder: (context, index) {
              final p = providers[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text("${p.name} ${p.lastName}"),
                  subtitle: Text(p.email),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('¿Eliminar proveedor?'),
                          content: Text('¿Deseas eliminar a ${p.name}?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              child: Text('Eliminar', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        final success = await _providerService.deleteProvider(p.id);
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Proveedor eliminado")),
                          );
                          setState(() => _loadProviders());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error al eliminar proveedor")),
                          );
                        }
                      }
                    },
                  ),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProviderEditScreen(provider: p),
                      ),
                    );
                    if (result == true) {
                      setState(() => _loadProviders());
                    }
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/provider-form');
          if (result == true) {
            setState(() => _loadProviders());
          }
        },
      ),
    );
  }
}
