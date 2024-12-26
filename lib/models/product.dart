import 'package:cloud_firestore/cloud_firestore.dart'; // Ensure this is correctly imported
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  // This constructor maps the Firestore fields to the Product model.
  factory Product.fromMap(Map<String, dynamic> data, String documentId) {
    return Product(
      id: documentId,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      imageUrl: data['imageUrl'] ?? '',
      category: data['category'] ?? '',
    );
  }

  // Use this if you also want a specific method for Firestore documents
  factory Product.fromFirestore(DocumentSnapshot doc) {
    return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }
}
