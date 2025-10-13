// import 'package:clickbuy/src/presentation/bloc/cubit/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clickbuy/src/domain/repositories/product_respositorie.dart';

import 'products_state.dart';  // Importar el state generado por Freezed

class ProductsCubit extends Cubit<ProductsState> {

  final ProductRespositorie _repository;
  ProductsCubit(this._repository) : super(ProductsState.initial());

  Future<void> getProducts() async {
    emit(ProductsState.loading());
    try {
      final products = await _repository.products();
      if(isClosed) return;
      emit(ProductsState.loaded(products));
    } catch (e) {
      emit(ProductsState.error(e.toString()));
    }
  }

  Future<void> getProductsByCategory(String categoryName) async {
    emit(ProductsState.loading());
    try {
      final products = await _repository.producsByCategoryName(
        categoryName: categoryName,
      );
      if(isClosed) return;
      emit(ProductsState.loaded(products));
    } catch (e) {
      emit(ProductsState.error(e.toString()));
    }
  }

  Future<void> searchProducts(String query) async {
    emit(ProductsState.loading());
    try {
      final products = await _repository.searchProducts(nameProduct: query);
      emit(ProductsState.loaded(products));
    } catch (e) {
      emit(ProductsState.error(e.toString()));
    }
  }

  Future<void> getProductsCarrusel() async {
    emit(ProductsState.loading());
    try {
      final products = await _repository.productsCarrusel();
      emit(ProductsState.loaded(products));
    } catch (e) {
      emit(ProductsState.error(e.toString()));
    }
  }

  Future<void> getProductById(int productId) async {
    emit(ProductsState.loading());
    try {
      final product = await _repository.productById(idProduct: productId);
      emit(ProductsState.productLoaded(product));
    } catch (e) {
      emit(ProductsState.error(e.toString()));
    }
  }
}




class ProductsCarruselCubit extends Cubit<ProductsState> {
  final ProductRespositorie _repository;
  ProductsCarruselCubit(this._repository) : super(ProductsState.initial());

  Future<void> getProductsCarrusel() async {
    emit(ProductsState.loading());
    try {
      final products = await _repository.productsCarrusel();
      emit(ProductsState.loaded(products));
    } catch (e) {
      emit(ProductsState.error(e.toString()));
    }
  }
}




class ProductDetailCubit extends Cubit<ProductsState> {
  final ProductRespositorie _repository;

  ProductDetailCubit(this._repository) : super(const ProductsState.initial());

  Future<void> getProductById(int productId) async {
    emit(const ProductsState.loading());
    try {
      final product = await _repository.productById(idProduct: productId);
      emit(ProductsState.productLoaded(product));
    } catch (e) {
      emit(ProductsState.error(e.toString()));
    }
  }
}


class SelectedCategory extends Cubit<String> {
  SelectedCategory() : super('all');
   void setCategory(String category) async {
    emit(category);
    
  }
}

