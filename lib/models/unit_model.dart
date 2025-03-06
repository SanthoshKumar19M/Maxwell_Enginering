class Unit {
  String unitName;
  String? unitId;

  Unit({
    required this.unitName,
    this.unitId,
  });

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      unitName: map['unitName'],
      unitId: map['unitId'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'unitName': unitName,
      'unitId': unitId,
    };
  }
}
