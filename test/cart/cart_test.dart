import 'package:clickbuy/src/infrastructure/datasorces/cart_datasources_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:clickbuy/src/domain/entities/cart_entity.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}
class MockDio extends Mock implements Dio {}
class MockResponse extends Mock implements Response {}

void main() {
  late MockFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late MockDocumentReference mockDocRef;
  late MockDocumentSnapshot mockSnapshot;
  late MockDio mockDio;
  late CartDatasourcesImp datasource;

  const testUserId = 'user123';
  const testProductId = 1;

  setUp(() {
    mockFirestore = MockFirestore();
    mockCollection = MockCollectionReference();
    mockDocRef = MockDocumentReference();
    mockSnapshot = MockDocumentSnapshot();
    mockDio = MockDio();

    when(() => mockFirestore.collection('carts')).thenReturn(mockCollection);
    when(() => mockCollection.doc(testUserId)).thenReturn(mockDocRef);
    when(() => mockDocRef.get()).thenAnswer((_) async => mockSnapshot);
    when(() => mockSnapshot.data()).thenReturn({
      'items': [
        {'productId': testProductId, 'quantity': 2}
      ]
    });

    final mockResponse = MockResponse();
    when(() => mockDio.get('/products/$testProductId')).thenAnswer((_) async => mockResponse);
    when(() => mockResponse.data).thenReturn({
      'id': testProductId,
      'title': 'Producto 1',
      'description': 'Descripción',
      'price': 100,
      'discountPercentage': 0,
      'rating': 5,
      'stock': 10,
      'tags': [],
      'sku': 'SKU1',
      'thumbnail': 'https://example.com/image.png',
    });

    datasource = CartDatasourcesImp.forTest(mockFirestore, mockDio);
  });

  test('Reconstruye carrito con productos completos desde Firestore y Dio', () async {
    final result = await datasource.getCartItems(userId: testUserId);

    print('Resultado: ${result.length} items');

    expect(result, isA<List<CartEntity>>());
    expect(result.length, 1);
    expect(result.first.product.id, testProductId);
    expect(result.first.quantity, 2);

    verify(() => mockFirestore.collection('carts')).called(1);
    verify(() => mockCollection.doc(testUserId)).called(1);
    verify(() => mockDocRef.get()).called(1);
    verify(() => mockDio.get('/products/$testProductId')).called(1);
  });
}
