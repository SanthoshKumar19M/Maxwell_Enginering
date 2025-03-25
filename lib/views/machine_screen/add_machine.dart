import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controllers/machine_entry_controller.dart';
import '../../core/theme.dart';
import '../../models/machine_entry_model.dart';

class MachineEntryScreen extends StatefulWidget {
  @override
  _MachineEntryScreenState createState() => _MachineEntryScreenState();
}

class _MachineEntryScreenState extends State<MachineEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final MachineController _machineController = MachineController();

  // Controllers
  final TextEditingController _machineNameController = TextEditingController();
  final TextEditingController _modelNumberController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String? _selectedMachineType;
  String? _selectedStatus;
  String? _selectedUser;

  DateTime? _manufactureYear;
  DateTime? _lastServiceDate;
  DateTime? _nextServiceDate;

  List<String> machineTypes = ['CNC', 'AMC', 'HMC'];
  List<String> statuses = ['Not yet started', 'In progress', 'Completed'];
  List<String> employees = [];

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  @override
  void dispose() {
    _machineNameController.dispose();
    _modelNumberController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  // Fetch employee list
  void _fetchEmployees() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('employees').get();
    setState(() {
      employees = snapshot.docs.map((doc) => doc['name'].toString()).toList();
    });
  }

  // Show Date Picker
  Future<void> _pickDate(BuildContext context, DateTime? selectedDate, Function(DateTime) onDateSelected) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      onDateSelected(pickedDate);
    }
  }

  // Save Machine Entry
  void _saveMachine() {
    if (_formKey.currentState!.validate()) {
      Machine machine = Machine(
        machineName: _machineNameController.text,
        machineType: _selectedMachineType!,
        modelNumber: _modelNumberController.text,
        manufactureYear: _manufactureYear != null ? Timestamp.fromDate(_manufactureYear!) : null,
        lastServiceDate: _lastServiceDate != null ? Timestamp.fromDate(_lastServiceDate!) : null,
        nextServiceDate: _nextServiceDate != null ? Timestamp.fromDate(_nextServiceDate!) : null,
        currentStatus: _selectedStatus!,
        assignedTo: _selectedUser ?? "",
        notes: _notesController.text,
      );

      _machineController.addMachine(machine, context).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Machine added successfully!')),
        );
      });
    }
  }

  // Common Style for TextFields
  InputDecoration _textFieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    );
  }

  // Dropdown Widget
  Widget _buildDropdown<T>(String label, T? value, List<T> items, Function(T?) onChanged) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: _textFieldDecoration(label),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item.toString()))).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Please select $label' : null,
    );
  }

  // Date Picker Widget
  Widget _buildDatePicker(String label, DateTime? date, Function(DateTime) onDateSelected) {
    return ListTile(
      title: Text(date == null ? label : '$label: ${DateFormat.yMMMd().format(date)}'),
      trailing: const Icon(Icons.calendar_today),
      onTap: () => _pickDate(context, date, onDateSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Machine")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _machineNameController,
                  decoration: _textFieldDecoration('Machine Name'),
                  validator: (value) => value!.isEmpty ? 'Enter machine name' : null,
                ),
                const SizedBox(height: 10),
                _buildDropdown('Machine Type', _selectedMachineType, machineTypes, (value) {
                  setState(() => _selectedMachineType = value);
                }),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _modelNumberController,
                  decoration: _textFieldDecoration('Model Number'),
                  validator: (value) => value!.isEmpty ? 'Enter model number' : null,
                ),
                const SizedBox(height: 10),
                _buildDatePicker('Select Manufacture Year', _manufactureYear, (date) {
                  setState(() => _manufactureYear = date);
                }),
                _buildDatePicker('Select Last Service Date', _lastServiceDate, (date) {
                  setState(() => _lastServiceDate = date);
                }),
                _buildDatePicker('Select Next Service Date', _nextServiceDate, (date) {
                  setState(() => _nextServiceDate = date);
                }),
                _buildDropdown('Current Status', _selectedStatus, statuses, (value) {
                  setState(() => _selectedStatus = value);
                }),
                const SizedBox(height: 10),
                _buildDropdown('Assigned To', _selectedUser, employees, (value) {
                  setState(() => _selectedUser = value);
                }),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _notesController,
                  decoration: _textFieldDecoration('Notes'),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _saveMachine,
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                      child: const Text('Add Machine', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
