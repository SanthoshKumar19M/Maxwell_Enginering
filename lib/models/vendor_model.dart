// model/vendor_model.dart
class Vendor {
  String name;
  String? vendorId;
  String mail;
  String mobile;
  String gstNumber;
  String billingAddress;
  String shippingAddress;
  String userName;
  String? userType = 'vendor';
  String password;

  Vendor({
    required this.name,
    required this.mail,
    this.vendorId,
    required this.mobile,
    required this.gstNumber,
    required this.billingAddress,
    required this.shippingAddress,
    required this.userName,
    this.userType,
    required this.password,
  });

  // Convert Vendor to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mail': mail,
      'vendorId': vendorId,
      'mobile': mobile,
      'gstNumber': gstNumber,
      'billingAddress': billingAddress,
      'userName': userName,
      'userType': userType,
      'password': password,
    };
  }

  // Create Vendor from Firestore document
  factory Vendor.fromMap(Map<String, dynamic> map) {
    return Vendor(
      name: map['name'],
      mail: map['mail'],
      vendorId: map['vendorId'],
      mobile: map['mobile'],
      gstNumber: map['gstNumber'],
      billingAddress: map['billingAddress'],
      shippingAddress: map['shippingAddress'],
      userName: map['userName'],
      userType: map['userType'],
      password: map['password'],
    );
  }
}
