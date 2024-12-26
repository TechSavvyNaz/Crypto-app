import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital/services/firestore_service.dart';
import 'package:digital/models/product.dart';

class ProductListScreen extends StatelessWidget {
  final String category;

  ProductListScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    var firestoreService = Provider.of<FirestoreService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('$category Products')),
      body: StreamBuilder<List<Product>>(
        stream: firestoreService.getProductsByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (!snapshot.hasData) return CircularProgressIndicator();

          List<Product> products = snapshot.data ?? [];
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(products[index].name),
                subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
                onTap: () {
                  // Implement navigation or other action here
                },
              );
            },
          );
        },
      ),
    );
  }
}
