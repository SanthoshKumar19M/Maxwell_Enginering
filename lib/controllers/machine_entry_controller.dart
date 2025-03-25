import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/machine_entry_model.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import '../models/machine_model.dart';

class MachineController {
  final CollectionReference _machineCollection = FirebaseFirestore.instance.collection('machines');
  bool isLoading = false;

  /// Add a new machine to Firestore
  Future<void> addMachine(Machine machine, BuildContext context) async {
    try {
      DocumentReference docRef = _machineCollection.doc(); // Generate auto ID
      machine.machineId = docRef.id; // Store the auto ID in the Machine object
      await docRef.set(machine.toMap()); // Save the Machine with the ID
    } catch (e) {
      if (kDebugMode) {
        print('Error adding machine: $e');
      }
    }
  }

  /// Update an existing machine's data
  Future<void> updateMachine(String machineId, Map<String, dynamic> updatedData, BuildContext context) async {
    try {
      await _machineCollection.doc(machineId).update(updatedData);
    } catch (e) {
      if (kDebugMode) {
        print('Error updating machine: $e');
      }
    }
  }

  /// Get a single machine by ID
  Future<Machine?> getMachine(String machineId) async {
    try {
      DocumentSnapshot doc = await _machineCollection.doc(machineId).get();
      if (doc.exists) {
        return Machine.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching machine: $e');
      }
    }
    return null;
  }

  /// Get a list of all machines
  Future<List<Machine>> getAllMachines() async {
    try {
      QuerySnapshot snapshot = await _machineCollection.get();
      return snapshot.docs.map((doc) => Machine.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching machines: $e');
      }
      return [];
    }
  }

  /// Delete a machine by ID
  Future<void> deleteMachine(String machineId, BuildContext context) async {
    try {
      await _machineCollection.doc(machineId).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting machine: $e');
      }
    }
  }

  /// Get list of users for dropdown (Assigned To)
  Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'] ?? 'Unknown',
        };
      }).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching users: $e');
      }
      return [];
    }
  }
}
