import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTareaScreen extends StatefulWidget {
  const AddTareaScreen({Key? key}) : super(key: key);

  @override
  State<AddTareaScreen> createState() => _AddTareaScreenState();
}

class _AddTareaScreenState extends State<AddTareaScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String? _tareaId;
  bool _isEditing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Miramos a ver si es Una tarea nueva o Editar alguna que ya tuviéramos
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if ( args != null && args['id'] != null ){
      // Estamos editando una tarea
      _isEditing = true;
      _tareaId = args['id'];
      _titleController.text = args['titulo'] ?? '';
      _descriptionController.text = args['descripcion'] ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Añadir tarea')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(hintText: 'Título'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(hintText: 'Descripción'),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {}, 
                child: Text('Añadir Tarea',
                 style: TextStyle(fontSize: 16, color: Colors.purple),)),
            ],
          ),
        ),
      ),
    );
  }
}
