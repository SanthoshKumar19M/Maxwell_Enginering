import 'package:flutter/material.dart';
import 'package:maxwellengineering/controllers/employee_controller.dart';
import 'package:maxwellengineering/models/employee_model.dart';
import 'package:maxwellengineering/models/tax_model.dart';

import '../../controllers/tax_contoller.dart';

class TaxView extends StatefulWidget {
  const TaxView({super.key});

  @override
  TaxViewState createState() => TaxViewState();
}

class TaxViewState extends State<TaxView> {
  late Future<List<Tax>> _taxFuture;

  @override
  void initState() {
    super.initState();
    _taxFuture = taxController.getAllTaxes();
  }

  final TaxController taxController = TaxController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tax List')),
      body: FutureBuilder<List<Tax>>(
        future: _taxFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Error message
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No taxes found')); // No data message
          }

          List<Tax> taxes = snapshot.data!;

          return ListView.builder(
            itemCount: taxes.length,
            itemBuilder: (context, index) {
              Tax tax = taxes[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(tax.taxPercent.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
