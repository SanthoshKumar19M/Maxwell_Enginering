import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maxwellengineering/controllers/service_controller.dart';
import 'package:maxwellengineering/controllers/user_controller.dart';
import 'package:maxwellengineering/core/theme.dart';
import 'package:maxwellengineering/models/service_model.dart';
import '../../utils/textformfield_decorattion.dart';

class ServiceCreation extends StatefulWidget {
  const ServiceCreation({super.key});

  @override
  ServiceCreationState createState() => ServiceCreationState();
}

class ServiceCreationState extends State<ServiceCreation> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController serviceNumberController = TextEditingController();
  final TextEditingController vendorNameController = TextEditingController();
  // final TextEditingController status = TextEditingController();
  final ServiceController serviceController = ServiceController();
  final UserController userController = UserController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  List<String> employees = [];
  List<String> machines = [];
  String? _selectedUser;
  String? _selectedMachine;
  String? _selectedStatus = "Not yet started";
  DateTime? _startedAt;

  List<String> statuses = ['Not yet started', 'In progress', 'Completed'];
  List<String> axisLabels = ["X", "Y", "Z", "A", "B"];
  List<bool> checkboxValues = List.filled(5, false); // Default all unchecked

  // Fetch employee list
  void _fetchEmployees() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('employees').get();
    setState(() {
      employees = snapshot.docs.map((doc) => doc['name'].toString()).toList();
    });
  }

  void _fetchMachines() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('machines').get();
    setState(() {
      machines = snapshot.docs.map((doc) => doc['machineName'].toString()).toList();
    });
  }

  Future<void> addService(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      await serviceController.addService(
        Service(
          serviceNumber: serviceNumberController.text,
          machine: _selectedMachine ?? '',
          vendor: "Sandy",
          assignedTo: _selectedUser ?? '',
          axis: checkboxValues,
          duration: durationController.text,
          status: _selectedStatus ?? '',
          startedAt: _startedAt ?? DateTime.now(),
          description: descriptionController.text,
        ),
        context,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Service created successfully!')),
      );
      // await userController.addUser(
      //   UserModel(
      //     userType: "vendor",
      //     userName: userNameController.text,
      //     password: passwordController.text,
      //   ),
      //   context,
      // );

      serviceNumberController.clear();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding Service: $error')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isLoading = false;
  late AnimationController _animationController; // Declare AnimationController
  late Animation<Offset> _slideAnimation; // Declare SlideAnimation

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
    _fetchMachines();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), // Start slightly below
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward(); // Start the slide-in animation
  }

  InputDecoration _textFieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    );
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

  // Date Picker Widget
  Widget _buildDatePicker(String label, DateTime? date, Function(DateTime) onDateSelected) {
    return ListTile(
      title: Text(date == null ? label : '$label: ${DateFormat.yMMMd().format(date)}'),
      trailing: const Icon(Icons.calendar_today),
      onTap: () => _pickDate(context, date, onDateSelected),
    );
  }

  Widget _buildDropdown<T>(String label, T? value, List<T> items, Function(T?) onChanged) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: _textFieldDecoration(label),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item.toString()))).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Please select $label' : null,
    );
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose of AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Service')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              AnimatedOpacity(
                opacity: isLoading ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              if (!isLoading) // Show form only when not loading
                SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: serviceNumberController,
                                decoration: InputDecorations.textFieldDecoration(
                                  labelText: "Service number",
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter Service number";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              _buildDropdown('Machine', _selectedMachine, machines, (value) {
                                setState(() => _selectedMachine = value);
                              }),
                              const SizedBox(height: 10),
                              TextFormField(
                                readOnly: true,
                                // controller: ,
                                decoration: InputDecorations.textFieldDecoration(
                                  labelText: "Vendor",
                                ),
                              ),
                              const SizedBox(height: 10),
                              _buildDropdown('Assigned To', _selectedUser, employees, (value) {
                                setState(() => _selectedUser = value);
                              }),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "Axis: ",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  ...List.generate(axisLabels.length, (index) {
                                    return Row(
                                      children: [
                                        Text(axisLabels[index]),
                                        Checkbox(
                                          value: checkboxValues[index],
                                          onChanged: (bool? newValue) {
                                            setState(() {
                                              checkboxValues[index] = newValue!;
                                            });
                                          },
                                        ),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: durationController,
                                decoration: InputDecorations.textFieldDecoration(
                                  labelText: "Duration",
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter Service number";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              _buildDropdown('Status', _selectedStatus, statuses, (value) {
                                setState(() => _selectedStatus = value);
                              }),
                              const SizedBox(height: 10),
                              _buildDatePicker('Started at', _startedAt, (date) {
                                setState(() => _startedAt = date);
                              }),
                              const SizedBox(height: 10),
                              TextFormField(
                                maxLines: 3,
                                controller: descriptionController,
                                decoration: InputDecorations.textFieldDecoration(
                                  labelText: "Description",
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter Description";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                addService(context);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(AppTheme.primaryColor),
                            ),
                            child: const Text(
                              'Add Service',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
