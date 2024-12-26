import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String id;
  final String productId;
  final int quantity;

  // Updated constructor with required keyword
  CartItem({required this.id, required this.productId, required this.quantity});

  // Factory constructor to create a CartItem from a Firestore document snapshot
  factory CartItem.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>; // Corrected data access with type casting
    return CartItem(
      id: doc.id,
      productId: data['productId'], // Ensure the key matches your document structure
      quantity: data['quantity'],   // Ensure the key matches your document structure
    );
  }

  // Method to convert a CartItem instance back to a Map for Firestore storage
  Map<String, dynamic> toFirestore() {
    return {
      'productId': productId,
      'quantity': quantity
    };
  }
}
