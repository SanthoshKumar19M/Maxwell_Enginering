import 'package:cloud_firestore/cloud_firestore.dart';

class Machine {
  String? machineId;
  String machineName;
  String machineType;
  String modelNumber;
  Timestamp? manufactureYear;
  Timestamp? lastServiceDate;
  Timestamp? nextServiceDate;
  String currentStatus;
  String assignedTo;
  String notes;

  Machine({
    this.machineId,
    required this.machineName,
    required this.machineType,
    required this.modelNumber,
    this.manufactureYear,
    this.lastServiceDate,
    this.nextServiceDate,
    required this.currentStatus,
    required this.assignedTo,
    required this.notes,
  });

  // Convert Machine object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'machineId': machineId,
      'machineName': machineName,
      'machineType': machineType,
      'modelNumber': modelNumber,
      'manufactureYear': manufactureYear,
      'lastServiceDate': lastServiceDate,
      'nextServiceDate': nextServiceDate,
      'currentStatus': currentStatus,
      'assignedTo': assignedTo,
      'notes': notes,
    };
  }

  // Create Machine object from Firestore document
  factory Machine.fromMap(Map<String, dynamic> map) {
    return Machine(
      machineId: map['machineId'],
      machineName: map['machineName'],
      machineType: map['machineType'],
      modelNumber: map['modelNumber'],
      manufactureYear: map['manufactureYear'],
      lastServiceDate: map['lastServiceDate'],
      nextServiceDate: map['nextServiceDate'],
      currentStatus: map['currentStatus'],
      assignedTo: map['assignedTo'],
      notes: map['notes'] ?? '',
    );
  }
}
