import 'package:clickbuy/src/config/api/dio.dart';
import 'package:clickbuy/src/domain/datasources/cart_datasources.dart';
import 'package:clickbuy/src/domain/entities/cart_entity.dart';
import 'package:clickbuy/src/domain/entities/product_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

class CartDatasourcesImp implements CartDatasources {
  final FirebaseFirestore _firestore;
  final DioClient _client;

  // prod
  CartDatasourcesImp()
      : _firestore = FirebaseFirestore.instance,
        _client = DioClient();

  //test
  CartDatasourcesImp.forTest(this._firestore, Dio dio)
      : _client = DioClient.forTest(dio);

  @override
  Future<void> addProduct({
    required String userId,
    required ProductEntity product,
    int quantity = 1,
  }) async {
    try {
      final cartRef = _firestore.collection('carts').doc(userId);
      final cartDoc = await cartRef.get();

      List<dynamic> items = cartDoc.data()?['items'] ?? [];

      final index = items.indexWhere((item) => item['productId'] == product.id);
      if (index >= 0) {
        items[index]['quantity'] = (items[index]['quantity'] + quantity).clamp(
          1,
          product.stock,
        );
      } else {
        items.add({'productId': product.id, 'quantity': quantity});
      }

      await cartRef.set({'items': items}, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      print('Exceptions firebase');
    } catch (e) {
      print('Exceptions normal');
    }
  }

  @override
  Future<void> clearCart({required String userId}) async {
    final cartRef = _firestore.collection('carts').doc(userId);
    await cartRef.set({'items': []}, SetOptions(merge: true));
  }

  @override
  Future<List<CartEntity>> getCartItems({required String userId}) async {
    final cartDoc = await _firestore.collection('carts').doc(userId).get();
    final items = cartDoc.data()?['items'] as List<dynamic>? ?? [];

    List<CartEntity> cartItems = [];

    for (var item in items) {
      final response = await _client.dio.get('/products/${item['productId']}');
      final data = response.data;

      final product = ProductEntity(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        price: (data['price'] as num).toDouble(),
        discountPercentage: (data['discountPercentage'] as num).toDouble(),
        rating: (data['rating'] as num).toDouble(),
        stock: data['stock'],
        tags: List<String>.from(data['tags'] ?? []),
        sku: data['sku'] ?? '',
        imagen: data['thumbnail'] ?? '',
      );

      cartItems.add(CartEntity(product: product, quantity: item['quantity']));
    }

    return cartItems;
  }

  @override
  Future<double> getTotal({required String userId}) {
    // TODO: implement getTotal
    throw UnimplementedError();
  }

  @override
  Future<void> removeProduct({
    required String userId,
    required ProductEntity product,
  }) async {
    final cartRef = _firestore.collection('carts').doc(userId);
    final cartDoc = await cartRef.get();

    List<dynamic> items = cartDoc.data()?['items'] ?? [];
    items.removeWhere((item) => item['productId'] == product.id);

    await cartRef.set({'items': items}, SetOptions(merge: true));
  }

  @override
  Future<void> updateQuantity({
    required String userId,
    required ProductEntity product,
    required int quantity,
  }) async {
    final cartRef = _firestore.collection('carts').doc(userId);
    final cartDoc = await cartRef.get();

    List<dynamic> items = cartDoc.data()?['items'] ?? [];
    final index = items.indexWhere((item) => item['productId'] == product.id);
    if (index >= 0) {
      items[index]['quantity'] = quantity.clamp(1, product.stock);
      await cartRef.set({'items': items}, SetOptions(merge: true));
    }
  }

  @override
  Future<int> getTotalItems({required String userId}) async {
    final cartDoc = await FirebaseFirestore.instance
        .collection('carts')
        .doc(userId)
        .get();
    final items = cartDoc.data()?['items'] as List<dynamic>? ?? [];

    final totalItems = items.fold<int>(
      0,
      (prev, item) => prev + (item['quantity'] as int),
    );

    return totalItems;
  }
}
