part of 'product_cubit.dart';

@immutable
sealed class ProductState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<ProductModel> productList;

  ProductLoaded(this.productList);

  @override
  // TODO: implement props
  List<Object?> get props => [productList];
}

final class ProductError extends ProductState {
  final String errorMessage;

  ProductError(this.errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
