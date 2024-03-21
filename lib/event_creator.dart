import 'package:flutter/material.dart';

enum Category {
  workshop,
  sustainability,
  nutrition,
  exercise,
  mindfulness,
  socialInteractions
}

class Event {
  String name;
  DateTime date;
  String creatorName;
  int points;
  Category category;
  String description;

  Event({
    required this.name,
    required this.date,
    required this.creatorName,
    required this.points,
    required this.category,
    required this.description,
  });
}

class EventEditor extends StatefulWidget {
  final Function(Event) onSave;

  EventEditor({required this.onSave});

  @override
  _EventEditorState createState() => _EventEditorState();
}

class _EventEditorState extends State<EventEditor> {
  late TextEditingController _nameController;
  late TextEditingController _creatorNameController;
  late TextEditingController _pointsController;
  late Category _selectedCategory;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _creatorNameController = TextEditingController();
    _pointsController = TextEditingController();
    _descriptionController = TextEditingController();
    _selectedCategory = Category.workshop;
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _creatorNameController.dispose();
    _pointsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Date: ${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                  ),
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Date'),
                ),
              ],
            ),
            TextField(
              controller: _creatorNameController,
              decoration: InputDecoration(labelText: 'Creator Name'),
            ),
            TextField(
              controller: _pointsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Points'),
            ),
            DropdownButtonFormField<Category>(
              value: _selectedCategory,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
              items: Category.values.map((category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text('${category.toString().split('.').last[0].toUpperCase()}${category.toString().split('.').last.substring(1)}'),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final event = Event(
                  name: _nameController.text,
                  date: _selectedDate,
                  creatorName: _creatorNameController.text,
                  points: int.tryParse(_pointsController.text) ?? 0,
                  category: _selectedCategory,
                  description: _descriptionController.text,
                );
                widget.onSave(event);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }
}
