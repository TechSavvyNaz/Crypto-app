import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital/models/product.dart';
import '../models/cart_item.dart';
import '../models/category.dart.';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream of products
  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList());
  }
  Stream<List<Product>> getProductsByCategory(String category) {
    return _db.collection('products')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }
  Stream<List<Category>> getCategories() {
    return _db.collection('categories').snapshots().map(
            (snapshot) => snapshot.docs.map(
                (doc) => Category.fromMap(doc.data() as Map<String, dynamic>, doc.id)
        ).toList()
    );
  }
  // Add or Update cart item
  Future<void> addToCart(String userId, CartItem item) {
    return _db.collection('users').doc(userId).collection('cart').doc(item.productId).set(item.toFirestore());
  }

  // Remove cart item
  Future<void> removeFromCart(String userId, String productId) {
    return _db.collection('users').doc(userId).collection('cart').doc(productId).delete();
  }

  // Stream of cart items
  Stream<List<CartItem>> getCartItems(String userId) {
    return _db.collection('users').doc(userId).collection('cart').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => CartItem.fromFirestore(doc)).toList());
  }
}
