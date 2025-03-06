import 'package:flutter/material.dart';
import 'package:maxwellengineering/controllers/unit_contoller.dart';
import 'package:maxwellengineering/models/tax_model.dart';
import 'package:maxwellengineering/models/unit_model.dart';
import '../../controllers/tax_contoller.dart';

class UnitView extends StatefulWidget {
  const UnitView({super.key});

  @override
  UnitViewState createState() => UnitViewState();
}

class UnitViewState extends State<UnitView> {
  late Future<List<Unit>> _unitFuture;

  @override
  void initState() {
    super.initState();
    _unitFuture = unitController.getAllUnites();
  }

  final UnitController unitController = UnitController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Units List')),
      body: FutureBuilder<List<Unit>>(
        future: _unitFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Error message
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No units found')); // No data message
          }

          List<Unit> units = snapshot.data!;

          return ListView.builder(
            itemCount: units.length,
            itemBuilder: (context, index) {
              Unit unit = units[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(unit.unitName.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
