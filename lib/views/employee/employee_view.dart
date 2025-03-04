import 'package:flutter/material.dart';
import 'package:maxwellengineering/controllers/employee_controller.dart';
import 'package:maxwellengineering/models/employee_model.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late Future<List<Employee>> _employeesFuture;

  @override
  void initState() {
    super.initState();
    _employeesFuture = employeeController.getAllEmployees(); // Fetch employees when the screen loads
  }

  final EmployeeController employeeController = EmployeeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employee List')),
      body: FutureBuilder<List<Employee>>(
        future: _employeesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Error message
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No employees found')); // No data message
          }

          List<Employee> employees = snapshot.data!;

          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              Employee employee = employees[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(employee.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Employee ID: ${employee.employeeId}\nEmail: ${employee.mail}"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    // MaterialPageRoute(
                    //   builder: (context) => EmployeeDetailsScreen(
                    //     name: employee.name,
                    //     employeeId: employee.employeeId,
                    //     email: employee.mail,
                    //     mobile: employee.mobile,
                    //     addressLine1: employee.addressLine1,
                    //     addressLine2: employee.addressLine2,
                    //   ),
                    // ),
                    // );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
