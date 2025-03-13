class Categories {
  String categoryName;
  String? categoryId;

  Categories({
    required this.categoryName,
    this.categoryId,
  });

  factory Categories.fromMap(Map<String, dynamic> map) {
    return Categories(
      categoryName: map['categoryName'],
      categoryId: map['categoryId'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'categoryName': categoryName,
      'categoryId': categoryId,
    };
  }
}
