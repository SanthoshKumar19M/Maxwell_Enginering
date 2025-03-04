import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maxwellengineering/models/employee_model.dart';

class EmployeeController {
  final CollectionReference _employeeCollection = FirebaseFirestore.instance.collection('employees');
  bool isloading = false;

  /// Add a new employee to Firestore
  Future<void> addEmployee(Employee employee, BuildContext context) async {
    try {
      await _employeeCollection.doc(employee.employeeId).set(employee.toMap());
    } catch (e) {
      print('Error adding employee: $e');
    }
  }

  /// Update an existing employee's data
  Future<void> updateEmployee(String employeeId, Map<String, dynamic> updatedData, BuildContext context) async {
    try {
      await _employeeCollection.doc(employeeId).update(updatedData);
    } catch (e) {
      print('Error updating employee: $e');
    }
  }

  /// Get a single employee by ID
  Future<Employee?> getEmployee(String employeeId) async {
    try {
      DocumentSnapshot doc = await _employeeCollection.doc(employeeId).get();
      if (doc.exists) {
        return Employee.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error fetching employee: $e');
    }
    return null;
  }

  /// Get a list of all employees
  Future<List<Employee>> getAllEmployees() async {
    try {
      QuerySnapshot snapshot = await _employeeCollection.get();
      return snapshot.docs.map((doc) => Employee.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error fetching employees: $e');
      return [];
    }
  }

  /// Delete an employee by ID
  Future<void> deleteEmployee(String employeeId, BuildContext context) async {
    try {
      await _employeeCollection.doc(employeeId).delete();
    } catch (e) {
      print('Error deleting employee: $e');
    }
  }
}
