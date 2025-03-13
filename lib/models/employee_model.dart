// model/employee_model.dart
class Employee {
  String name;
  String employeeId;
  String mail;
  String mobile;
  String addressLine1;
  String addressLine2;

  Employee({
    required this.name,
    required this.employeeId,
    required this.mail,
    required this.mobile,
    required this.addressLine1,
    required this.addressLine2,
  });

  // Convert Employee to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'employeeId': employeeId,
      'mail': mail,
      'mobile': mobile,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
    };
  }

  // Create Employee from Firestore document
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      name: map['name'],
      employeeId: map['employeeId'],
      mail: map['mail'],
      mobile: map['mobile'],
      addressLine1: map['addressLine1'],
      addressLine2: map['addressLine2'],
    );
  }
}
