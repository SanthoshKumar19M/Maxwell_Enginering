import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maxwellengineering/models/vendor_model.dart';

class VendorController {
  final CollectionReference _vendorCollection = FirebaseFirestore.instance.collection('vendors');
  bool isloading = false;

  /// Add a new vendor to Firestore
  Future<void> addVendor(Vendor vendor, BuildContext context) async {
    try {
      DocumentReference docRef = _vendorCollection.doc(); // Generate auto ID
      vendor.vendorId = docRef.id; // Store the auto ID in the Vendor object
      await docRef.set(vendor.toMap()); // Save the Vendor with the ID
    } catch (e) {
      if (kDebugMode) {
        print('Error adding vendor: $e');
      }
    }
  }

  /// Update an existing vendor's data
  Future<void> updateVendor(String vendorId, Map<String, dynamic> updatedData, BuildContext context) async {
    try {
      await _vendorCollection.doc(vendorId).update(updatedData);
    } catch (e) {
      if (kDebugMode) {
        print('Error updating vendor: $e');
      }
    }
  }

  /// Get a single vendor by ID
  Future<Vendor?> getVendor(String vendorId) async {
    try {
      DocumentSnapshot doc = await _vendorCollection.doc(vendorId).get();
      if (doc.exists) {
        return Vendor.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching vendor: $e');
      }
    }
    return null;
  }

  /// Get a list of all vendors
  Future<List<Vendor>> getAllVendors() async {
    try {
      QuerySnapshot snapshot = await _vendorCollection.get();
      return snapshot.docs.map((doc) => Vendor.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching vendors: $e');
      }
      return [];
    }
  }

  /// Delete an vendor by ID
  Future<void> deleteVendor(String vendorId, BuildContext context) async {
    try {
      await _vendorCollection.doc(vendorId).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting vendor: $e');
      }
    }
  }
}
