import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:clickbuy/src/domain/entities/cart_entity.dart';
import 'package:clickbuy/src/domain/entities/product_entity.dart';
import 'package:clickbuy/src/domain/repositories/cart_repositorie.dart';
import 'package:clickbuy/src/presentation/provider/cart/cart_provider.dart';

// 🔹 Mocks y Fakes
class MockCartRepositorie extends Mock implements CartRepositorie {}
class FakeProductEntity extends Fake implements ProductEntity {}
class FakeCartEntity extends Fake implements CartEntity {}

void main() {
  late ProviderContainer container;
  late MockCartRepositorie mockRepository;

  const testUserId = 'user123';

  final testProduct = ProductEntity(
    id: 1,
    title: 'Producto 1',
    description: 'Descripción',
    price: 100,
    discountPercentage: 0,
    rating: 5,
    stock: 10,
    tags: [],
    sku: 'SKU1',
    imagen: 'https://example.com/image.png',
  );
  
  setUpAll(() {
    registerFallbackValue(FakeProductEntity());
    registerFallbackValue(FakeCartEntity());
  });

  setUp(() {
    mockRepository = MockCartRepositorie();
    container = ProviderContainer(
      overrides: [
        cartDatasourcesProvider.overrideWith((ref) => mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

test('Agregar producto al carrito', () async {
  // 🔹 Configurar mocks
  when(() => mockRepository.addProduct(
    userId: any(named: 'userId'),
    product: any(named: 'product'),
    quantity: any(named: 'quantity'),
  )).thenAnswer((_) async {});

  when(() => mockRepository.getCartItems(
    userId: any(named: 'userId'),
  )).thenAnswer((_) async => [
    CartEntity(product: testProduct, quantity: 1),
  ]);

  // 🔹 Ejecutar acción
  final cartNotifier = container.read(cartProvider.notifier);
  await cartNotifier.addToCart(testUserId, testProduct);

  // ✅ Esperar a que el estado se actualice completamente
  final cartItems = await container.read(cartProvider.future);

  // 🔹 Verificar llamadas
  verify(() => mockRepository.addProduct(
    userId: testUserId,
    product: testProduct,
    quantity: 1,
  )).called(1);

  verify(() => mockRepository.getCartItems(
    userId: testUserId,
  )).called(1);

  // 🔹 Verificar estado final
  expect(cartItems.length, 1);
  expect(cartItems.first.product.id, testProduct.id);
  expect(cartItems.first.quantity, 1);


  print('🛒 Carrito actualizado con ${cartItems.length} producto(s)');
});

}