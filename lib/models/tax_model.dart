class Tax {
  double taxPercent;
  String? taxId;

  Tax({
    required this.taxPercent,
    this.taxId,
  });

  factory Tax.fromMap(Map<String, dynamic> map) {
    return Tax(
      taxPercent: map['taxPercent'],
      taxId: map['taxId'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'taxPercent': taxPercent,
      'taxId': taxId,
    };
  }
}
