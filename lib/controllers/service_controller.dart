import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maxwellengineering/models/service_model.dart';

class ServiceController {
  final CollectionReference _serviceCollection = FirebaseFirestore.instance.collection('services');
  bool isLoading = false;

  /// Add a new service to Firestore
  Future<void> addService(Service service, BuildContext context) async {
    try {
      DocumentReference docRef = _serviceCollection.doc(); // Generate auto ID
      service.serviceId = docRef.id; // Store the auto ID in the Service object
      service.createdAt = DateTime.now(); // Set createdAt
      service.updatedAt = DateTime.now(); // Set updatedAt

      await docRef.set(service.toMap()); // Save the Service with timestamps
    } catch (e) {
      if (kDebugMode) {
        print('Error adding service: $e');
      }
    }
  }

  /// Update an existing service's data
  Future<void> updateService(String serviceId, Map<String, dynamic> updatedData) async {
    try {
      updatedData['updatedAt'] = DateTime.now().toIso8601String(); // Update timestamp
      await _serviceCollection.doc(serviceId).update(updatedData);
    } catch (e) {
      if (kDebugMode) {
        print('Error updating service: $e');
      }
    }
  }

  /// Get a single service by ID
  Future<Service?> getService(String serviceId) async {
    try {
      DocumentSnapshot doc = await _serviceCollection.doc(serviceId).get();
      if (doc.exists) {
        return Service.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching service: $e');
      }
    }
    return null;
  }

  /// Get a list of all services
  Future<List<Service>> getAllServices() async {
    try {
      QuerySnapshot snapshot = await _serviceCollection.get();
      return snapshot.docs.map((doc) => Service.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching services: $e');
      }
      return [];
    }
  }

  /// Delete a service by ID
  Future<void> deleteService(String serviceId, BuildContext context) async {
    try {
      await _serviceCollection.doc(serviceId).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting service: $e');
      }
    }
  }
}
