import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maxwellengineering/models/unit_model.dart';
import '../models/tax_model.dart';

class UnitController {
  final CollectionReference _unitCollection = FirebaseFirestore.instance.collection('unit');
  bool isloading = false;

  /// Add a new Unit to Firestore
  Future<void> addUnit(Unit unit, BuildContext context) async {
    try {
      DocumentReference docRef = _unitCollection.doc(); // Generate auto ID
      unit.unitId = docRef.id; // Store the auto ID in the Vendor object
      await docRef.set(unit.toMap()); // Save the Vendor with the ID
    } catch (e) {
      if (kDebugMode) {
        print('Error adding Unit details: $e');
      }
    }
  }

  /// Update an existing Unit's data
  Future<void> updateUnit(String unitId, Map<String, dynamic> updatedData, BuildContext context) async {
    try {
      await _unitCollection.doc(unitId).update(updatedData);
    } catch (e) {
      print('Error updating Unit details: $e');
    }
  }

  /// Get a single Unit by ID
  Future<Unit?> getUnit(String unitId) async {
    try {
      DocumentSnapshot doc = await _unitCollection.doc(unitId).get();
      if (doc.exists) {
        return Unit.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching Unit: $e');
      }
    }
    return null;
  }

  /// Get a list of all unit
  Future<List<Unit>> getAllUnites() async {
    try {
      QuerySnapshot snapshot = await _unitCollection.get();
      return snapshot.docs.map((doc) => Unit.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching Unit details: $e');
      }
      return [];
    }
  }

  /// Delete an unit by ID
  Future<void> deleteUnit(String unitId, BuildContext context) async {
    try {
      await _unitCollection.doc(unitId).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting unit Details: $e');
      }
    }
  }
}
