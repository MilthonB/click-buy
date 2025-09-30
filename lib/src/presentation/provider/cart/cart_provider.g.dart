// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cartDatasources)
const cartDatasourcesProvider = CartDatasourcesProvider._();

final class CartDatasourcesProvider
    extends
        $FunctionalProvider<CartRepositorie, CartRepositorie, CartRepositorie>
    with $Provider<CartRepositorie> {
  const CartDatasourcesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartDatasourcesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartDatasourcesHash();

  @$internal
  @override
  $ProviderElement<CartRepositorie> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CartRepositorie create(Ref ref) {
    return cartDatasources(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CartRepositorie value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CartRepositorie>(value),
    );
  }
}

String _$cartDatasourcesHash() => r'ab97c65913f0473559567eac9172ffc3c17a0423';

@ProviderFor(Cart)
const cartProvider = CartProvider._();

final class CartProvider
    extends $AsyncNotifierProvider<Cart, List<CartEntity>> {
  const CartProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartHash();

  @$internal
  @override
  Cart create() => Cart();
}

String _$cartHash() => r'4e9edfbb2c76012e35ec1d5296164dff0ac16454';

abstract class _$Cart extends $AsyncNotifier<List<CartEntity>> {
  FutureOr<List<CartEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<CartEntity>>, List<CartEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CartEntity>>, List<CartEntity>>,
              AsyncValue<List<CartEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CartTotals)
const cartTotalsProvider = CartTotalsProvider._();

final class CartTotalsProvider
    extends $NotifierProvider<CartTotals, Map<String, double>> {
  const CartTotalsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartTotalsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartTotalsHash();

  @$internal
  @override
  CartTotals create() => CartTotals();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, double> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, double>>(value),
    );
  }
}

String _$cartTotalsHash() => r'c8227fe11329816319865b7b2871a16b3e444446';

abstract class _$CartTotals extends $Notifier<Map<String, double>> {
  Map<String, double> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, double>, Map<String, double>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, double>, Map<String, double>>,
              Map<String, double>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CartQuantity)
const cartQuantityProvider = CartQuantityProvider._();

final class CartQuantityProvider
    extends $NotifierProvider<CartQuantity, Map<int, int>> {
  const CartQuantityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartQuantityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartQuantityHash();

  @$internal
  @override
  CartQuantity create() => CartQuantity();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<int, int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<int, int>>(value),
    );
  }
}

String _$cartQuantityHash() => r'cc0e7922c55bb17390b6a834f17be578401ddc3c';

abstract class _$CartQuantity extends $Notifier<Map<int, int>> {
  Map<int, int> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<int, int>, Map<int, int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<int, int>, Map<int, int>>,
              Map<int, int>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
