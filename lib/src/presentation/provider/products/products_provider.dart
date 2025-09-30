import 'package:clickbuy/src/domain/entities/product_entity.dart';
import 'package:clickbuy/src/domain/repositories/product_respositorie.dart';
import 'package:clickbuy/src/infrastructure/datasorces/product_datasources_imp.dart';
import 'package:clickbuy/src/infrastructure/repositories/product_repositorie_imp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_provider.g.dart';

@riverpod
ProductRespositorie productRepositorie(ref) {
  return ProductRepositorieImp(ProductDatasourcesImp());
}

@riverpod
class ProductByCategory extends _$ProductByCategory {
  @override
  Future<List<ProductEntity>> build() {
    return Future.value(null);
  }

  Future<void> getProductsByCategory(String categoryName) async {
    state = const AsyncLoading(); // 🔄 loading en UI
    try {
      final datasources = ref.read(productRepositorieProvider);
      final resp = await datasources.producsByCategoryName(
        categoryName: categoryName,
      );

      state = AsyncData(resp); // ✅ datos listos
    } catch (e, st) {
      state = AsyncError(e, st); // ❌ error manejado
    }
  }
}

@riverpod
class GetProducts extends _$GetProducts {
   @override
  Future<List<ProductEntity>> build() async {
    final datasources = ref.read(productRepositorieProvider);
      final resp = await datasources.products();
      return Future.value(resp);
  }

  Future<void> getProducts() async {
    state = const AsyncLoading(); // 🔄 loading en UI
    try {
      final datasources = ref.read(productRepositorieProvider);
      final resp = await datasources.products();
      state = AsyncData(resp); // ✅ datos listos
    } catch (e, st) {
      state = AsyncError(e, st); // ❌ error manejado
    }
  }

  setProduct(AsyncValue<List<ProductEntity>> prodctSearch){
    state = prodctSearch;
  }
}



  @riverpod
  class GetProductsCarrusel extends _$GetProductsCarrusel {
    @override
    Future<List<ProductEntity>> build() async {
      final datasources = ref.read(productRepositorieProvider);
      final resp = await datasources.productsCarrusel();
      return Future.value(resp);
    }

    Future<void> getProductsCarrusel() async {
      state = const AsyncLoading(); // 🔄 loading en UI
      try {
        final datasources = ref.read(productRepositorieProvider);
        final resp = await datasources.productsCarrusel();
        state = AsyncData(resp); // ✅ datos listos
      } catch (e, st) {
        state = AsyncError(e, st); // ❌ error manejado
      }
    }
  }


@riverpod
class SearchProducts extends _$SearchProducts {
  @override
  Future<List<ProductEntity>> build() async {
     return Future.value([]);
  }

  Future<void> searchProduct(String nameProduct) async {
    state = const AsyncLoading(); // 🔄 loading en UI
    try {
      final datasources = ref.read(productRepositorieProvider);
      final resp = await datasources.searchProducts(nameProduct: nameProduct);
      state = AsyncData(resp); // ✅ datos listos
      ref.read(getProductsProvider.notifier).setProduct(AsyncData(resp));

    } catch (e, st) {
      state = AsyncError(e, st); // ❌ error manejado
      return;
    }

  }

}




