import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_sate_management_bloc_cubit/models/product_model.dart';
import 'package:flutter_sate_management_bloc_cubit/models/rating_model.dart';
import 'package:flutter_sate_management_bloc_cubit/repos/product_repository.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductLoading());
  final ProductRepository repository = ProductRepository();

  Future<void> callApi() async {
    try {
      await Future.delayed(Duration(seconds: 3));
      final productList = await repository.getProductData();
      emit(ProductLoaded(productList));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
