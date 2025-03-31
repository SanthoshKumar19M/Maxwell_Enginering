class Service {
  String? serviceId;
  String serviceNumber;
  String machine;
  String vendor;
  String assignedTo;
  List<bool> axis;
  String duration;
  String status;
  DateTime startedAt;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  Service({
    required this.serviceNumber,
    required this.machine,
    required this.vendor,
    required this.assignedTo,
    required this.axis,
    required this.duration,
    required this.status,
    required this.startedAt,
    required this.description,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // Convert Service to Map for Firestore or API
  Map<String, dynamic> toMap() {
    return {
      'serviceNumber': serviceNumber,
      'machine': machine,
      'vendor': vendor,
      'assignedTo': assignedTo,
      'axis': axis,
      'duration': duration,
      'status': status,
      'startedAt': startedAt.toIso8601String(),
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create Service from Firestore or API document
  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      serviceNumber: map['serviceNumber'],
      machine: map['machine'],
      vendor: map['vendor'],
      assignedTo: map['assignedTo'],
      axis: List<bool>.from(map['axis']),
      duration: map['duration'],
      status: map['status'],
      startedAt: DateTime.parse(map['startedAt']),
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
