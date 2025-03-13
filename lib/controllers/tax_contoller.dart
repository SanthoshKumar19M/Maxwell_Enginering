import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/tax_model.dart';

class TaxController {
  final CollectionReference _taxCollection = FirebaseFirestore.instance.collection('tax');
  bool isloading = false;

  /// Add a new Tax to Firestore
  Future<void> addTax(Tax tax, BuildContext context) async {
    try {
      DocumentReference docRef = _taxCollection.doc(); // Generate auto ID
      tax.taxId = docRef.id; // Store the auto ID in the Vendor object
      await docRef.set(tax.toMap()); // Save the Vendor with the ID
    } catch (e) {
      if (kDebugMode) {
        print('Error adding Tax details: $e');
      }
    }
  }

  /// Update an existing Tax's data
  Future<void> updateTax(String taxId, Map<String, dynamic> updatedData, BuildContext context) async {
    try {
      await _taxCollection.doc(taxId).update(updatedData);
    } catch (e) {
      print('Error updating Tax details: $e');
    }
  }

  /// Get a single Tax by ID
  Future<Tax?> getEmployee(String taxId) async {
    try {
      DocumentSnapshot doc = await _taxCollection.doc(taxId).get();
      if (doc.exists) {
        return Tax.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching Tax: $e');
      }
    }
    return null;
  }

  /// Get a list of all tax
  Future<List<Tax>> getAllTaxes() async {
    try {
      QuerySnapshot snapshot = await _taxCollection.get();
      return snapshot.docs.map((doc) => Tax.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching Tax details: $e');
      }
      return [];
    }
  }

  /// Delete an tax by ID
  Future<void> deleteEmployee(String taxId, BuildContext context) async {
    try {
      await _taxCollection.doc(taxId).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting tax Details: $e');
      }
    }
  }
}
