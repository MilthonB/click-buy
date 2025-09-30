// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productRepositorie)
const productRepositorieProvider = ProductRepositorieProvider._();

final class ProductRepositorieProvider
    extends
        $FunctionalProvider<
          ProductRespositorie,
          ProductRespositorie,
          ProductRespositorie
        >
    with $Provider<ProductRespositorie> {
  const ProductRepositorieProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productRepositorieProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productRepositorieHash();

  @$internal
  @override
  $ProviderElement<ProductRespositorie> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProductRespositorie create(Ref ref) {
    return productRepositorie(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductRespositorie value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductRespositorie>(value),
    );
  }
}

String _$productRepositorieHash() =>
    r'3f38d2e9074af21bc203bcf005345ce5c1db57a9';

@ProviderFor(ProductByCategory)
const productByCategoryProvider = ProductByCategoryProvider._();

final class ProductByCategoryProvider
    extends $AsyncNotifierProvider<ProductByCategory, List<ProductEntity>> {
  const ProductByCategoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productByCategoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productByCategoryHash();

  @$internal
  @override
  ProductByCategory create() => ProductByCategory();
}

String _$productByCategoryHash() => r'080a16a63142f766aa1b8be429b125e59a2e5880';

abstract class _$ProductByCategory extends $AsyncNotifier<List<ProductEntity>> {
  FutureOr<List<ProductEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<ProductEntity>>, List<ProductEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ProductEntity>>, List<ProductEntity>>,
              AsyncValue<List<ProductEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(GetProducts)
const getProductsProvider = GetProductsProvider._();

final class GetProductsProvider
    extends $AsyncNotifierProvider<GetProducts, List<ProductEntity>> {
  const GetProductsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getProductsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getProductsHash();

  @$internal
  @override
  GetProducts create() => GetProducts();
}

String _$getProductsHash() => r'f38212a0c16f1eea23dfdc570ac901336910fc4d';

abstract class _$GetProducts extends $AsyncNotifier<List<ProductEntity>> {
  FutureOr<List<ProductEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<ProductEntity>>, List<ProductEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ProductEntity>>, List<ProductEntity>>,
              AsyncValue<List<ProductEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(GetProductsCarrusel)
const getProductsCarruselProvider = GetProductsCarruselProvider._();

final class GetProductsCarruselProvider
    extends $AsyncNotifierProvider<GetProductsCarrusel, List<ProductEntity>> {
  const GetProductsCarruselProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getProductsCarruselProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getProductsCarruselHash();

  @$internal
  @override
  GetProductsCarrusel create() => GetProductsCarrusel();
}

String _$getProductsCarruselHash() =>
    r'bc9c7449fced301123e2014c5e362fff26bc3ca9';

abstract class _$GetProductsCarrusel
    extends $AsyncNotifier<List<ProductEntity>> {
  FutureOr<List<ProductEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<ProductEntity>>, List<ProductEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ProductEntity>>, List<ProductEntity>>,
              AsyncValue<List<ProductEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(SearchProducts)
const searchProductsProvider = SearchProductsProvider._();

final class SearchProductsProvider
    extends $AsyncNotifierProvider<SearchProducts, List<ProductEntity>> {
  const SearchProductsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchProductsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchProductsHash();

  @$internal
  @override
  SearchProducts create() => SearchProducts();
}

String _$searchProductsHash() => r'86622a29ecfc15132201584d38824420006e9cf5';

abstract class _$SearchProducts extends $AsyncNotifier<List<ProductEntity>> {
  FutureOr<List<ProductEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<ProductEntity>>, List<ProductEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ProductEntity>>, List<ProductEntity>>,
              AsyncValue<List<ProductEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
