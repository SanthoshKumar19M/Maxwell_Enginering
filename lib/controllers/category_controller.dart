import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maxwellengineering/models/category_model.dart';

class CategoriesController {
  final CollectionReference _categoryCollection = FirebaseFirestore.instance.collection('Categories');
  bool isloading = false;

  /// Add a new Categories to Firestore
  Future<void> addCategories(Categories category, BuildContext context) async {
    try {
      DocumentReference docRef = _categoryCollection.doc(); // Generate auto ID
      category.categoryId = docRef.id; // Store the auto ID in the Vendor object
      await docRef.set(category.toMap()); // Save the Vendor with the ID
    } catch (e) {
      if (kDebugMode) {
        print('Error adding Categories details: $e');
      }
    }
  }

  /// Update an existing Categories's data
  Future<void> updateCategories(String categoryId, Map<String, dynamic> updatedData, BuildContext context) async {
    try {
      await _categoryCollection.doc(categoryId).update(updatedData);
    } catch (e) {
      print('Error updating Categories details: $e');
    }
  }

  /// Get a single Categories by ID
  Future<Categories?> getCategories(String categoryId) async {
    try {
      DocumentSnapshot doc = await _categoryCollection.doc(categoryId).get();
      if (doc.exists) {
        return Categories.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching Categories: $e');
      }
    }
    return null;
  }

  /// Get a list of all category
  Future<List<Categories>> getAllCategorieses() async {
    try {
      QuerySnapshot snapshot = await _categoryCollection.get();
      return snapshot.docs.map((doc) => Categories.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching Categories details: $e');
      }
      return [];
    }
  }

  /// Delete an category by ID
  Future<void> deleteCategories(String categoryId, BuildContext context) async {
    try {
      await _categoryCollection.doc(categoryId).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting category Details: $e');
      }
    }
  }
}
