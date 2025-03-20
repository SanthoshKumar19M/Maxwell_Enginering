import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maxwellengineering/models/user_role_model.dart';

class UserController {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  bool isloading = false;

  /// Login User using Firestore `users` collection
  Future<UserModel?> loginUser(String userName, String password, BuildContext context) async {
    try {
      QuerySnapshot querySnapshot = await _usersCollection
          .where('userName', isEqualTo: userName.trim()) // Trim spaces
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

        if (userData != null) {
          String storedPassword = userData['password'] ?? '';

          if (storedPassword == password) {
            return UserModel.fromMap(userData); // Successful login
          } else {
            showSnackBar(context, 'Incorrect password');
          }
        }
      } else {
        showSnackBar(context, 'User not found');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Login Error: $e');
      }
      showSnackBar(context, 'Login failed. Please try again.');
    }
    return null;
  }

  /// Helper function to show messages in a SnackBar
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Add a new users to Firestore
  Future<void> addUser(UserModel users, BuildContext context) async {
    try {
      DocumentReference docRef = _usersCollection.doc(); // Generate auto ID
      users.id = docRef.id; // Store the auto ID in the User object
      await docRef.set(users.toMap()); // Save the User with the ID
    } catch (e) {
      if (kDebugMode) {
        print('Error adding users: $e');
      }
    }
  }

  /// Update an existing users's data
  Future<void> updateUser(String usersId, Map<String, dynamic> updatedData, BuildContext context) async {
    try {
      await _usersCollection.doc(usersId).update(updatedData);
    } catch (e) {
      if (kDebugMode) {
        print('Error updating users: $e');
      }
    }
  }

  /// Get a single users by ID
  Future<UserModel?> getUser(String usersId) async {
    try {
      DocumentSnapshot doc = await _usersCollection.doc(usersId).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching users: $e');
      }
    }
    return null;
  }

  /// Get a list of all userss
  Future<List<UserModel>> getAllUsers() async {
    try {
      QuerySnapshot snapshot = await _usersCollection.get();
      return snapshot.docs.map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching userss: $e');
      }
      return [];
    }
  }

  /// Delete an users by ID
  Future<void> deleteUser(String usersId, BuildContext context) async {
    try {
      await _usersCollection.doc(usersId).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting users: $e');
      }
    }
  }
}
