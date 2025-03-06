import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maxwellengineering/core/theme.dart';
import '../../controllers/employee_controller.dart';
import '../../models/employee_model.dart';
import '../../utils/textformfield_decorattion.dart';

class EmployeeCreation extends StatefulWidget {
  const EmployeeCreation({super.key});

  @override
  EmployeeCreationState createState() => EmployeeCreationState();
}

class EmployeeCreationState extends State<EmployeeCreation> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final EmployeeController employeeController = EmployeeController();

  Future<void> addEmployee(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      await employeeController.addEmployee(
        Employee(
          name: _nameController.text,
          employeeId: _employeeIdController.text,
          mail: _mailController.text,
          mobile: _mobileController.text,
          addressLine1: _addressLine1Controller.text,
          addressLine2: _addressLine2Controller.text,
        ),
        context,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Employee added successfully!')),
      );

      // Optionally, clear the form fields after adding the employee
      _nameController.clear();
      _employeeIdController.clear();
      _mailController.clear();
      _mobileController.clear();
      _addressLine1Controller.clear();
      _addressLine2Controller.clear();
    } catch (error) {
      // Handle error gracefully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding employee: $error')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isLoading = false;
// Add an employee

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Employee')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecorations.textFieldDecoration(
                                    labelText: "Name",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Please enter a name";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _employeeIdController,
                                  decoration: InputDecorations.textFieldDecoration(
                                    labelText: "Employee Id",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Please enter an Employee ID";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _mailController,
                                  decoration: InputDecorations.textFieldDecoration(
                                    labelText: "Email",
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Please enter an email";
                                    }
                                    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                                    if (!emailRegex.hasMatch(value)) {
                                      return "Enter a valid email";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _mobileController,
                                  decoration: InputDecorations.textFieldDecoration(
                                    labelText: "Mobile",
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly, // Allows only numbers
                                    LengthLimitingTextInputFormatter(10), // Limits to 10 digits without showing counter
                                  ],
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Please enter a mobile number";
                                    }
                                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                      return "Only numbers are allowed";
                                    }
                                    if (value.length != 10) {
                                      return "Mobile number must be 10 digits";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _addressLine1Controller,
                                  decoration: InputDecorations.textFieldDecoration(
                                    labelText: "Address Line 1",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Please enter Address Line 1";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _addressLine2Controller,
                                  decoration: InputDecorations.textFieldDecoration(
                                    labelText: "Address Line 2",
                                  ),
                                ),
                                const SizedBox(height: 10),
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
                                  addEmployee(context);
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                AppTheme.primaryColor,
                              )),
                              child: const Text(
                                'Add Employee',
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
            ],
          ),
        ),
      ),
    );
  }
}
