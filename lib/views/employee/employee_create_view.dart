import 'package:flutter/material.dart';
import '../../models/employee_model.dart';

class EmployeeCreateView extends StatefulWidget {
  @override
  _EmployeeCreateViewState createState() => _EmployeeCreateViewState();
}

class _EmployeeCreateViewState extends State<EmployeeCreateView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Employee')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _employeeIdController,
                decoration: InputDecoration(labelText: 'Employee ID'),
              ),
              TextFormField(
                controller: _mailController,
                decoration: InputDecoration(labelText: 'Mail'),
              ),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(labelText: 'Mobile'),
              ),
              TextFormField(
                controller: _addressLine1Controller,
                decoration: InputDecoration(labelText: 'Address Line 1'),
              ),
              TextFormField(
                controller: _addressLine2Controller,
                decoration: InputDecoration(labelText: 'Address Line 2'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Employee employee = Employee(
                          name: _nameController.text,
                          employeeId: _employeeIdController.text,
                          mail: _mailController.text,
                          mobile: _mobileController.text,
                          addressLine1: _addressLine1Controller.text,
                          addressLine2: _addressLine2Controller.text,
                        );
                        // Handle employee data
                      }
                    },
                    child: Text('Create Employee'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
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
