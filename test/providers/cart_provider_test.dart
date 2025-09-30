import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:clickbuy/src/domain/entities/cart_entity.dart';
import 'package:clickbuy/src/domain/entities/product_entity.dart';
import 'package:clickbuy/src/domain/repositories/cart_repositorie.dart';
import 'package:clickbuy/src/presentation/provider/cart/cart_provider.dart';

// 🔹 Mock y Fake necesarios para mocktail
class MockCartRepositorie extends Mock implements CartRepositorie {}

class FakeProductEntity extends Fake implements ProductEntity {}

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
    // 👇 Registrar fallback para parámetros nombrados
    registerFallbackValue(FakeProductEntity());
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

    // 🔹 Esperar a que el estado se actualice
    await Future.delayed(Duration(milliseconds: 10));

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
    final cartState = container.read(cartProvider);
    final items = cartState.maybeWhen(
      data: (data) => data,
      orElse: () => <CartEntity>[],
    );

    expect(items.length, 1);
    expect(items.first.product.id, testProduct.id);
    expect(items.first.quantity, 1);
  });

}
