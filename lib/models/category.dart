class Category {
  final String id;
  final String name;
  final String description;
  final String icon;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });

  factory Category.fromMap(Map<String, dynamic> data, String documentId) {
    return Category(
      id: documentId,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      icon: data['icon'] ?? '',
    );
  }
}
