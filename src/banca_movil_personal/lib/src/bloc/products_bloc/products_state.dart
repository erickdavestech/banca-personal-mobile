part of 'products_bloc.dart';

@immutable
class ProductsState {
  // final ProductsModel? products;
  // final String? message;
  // final Product? product;
  // final TransactionListModel? transactionListModel;
  // final bool loading;
  // final bool detailLoading;

  // const ProductsState({
  //   this.products,
  //   this.message,
  //   this.product,
  //   this.transactionListModel,
  //   this.loading = false,
  //   this.detailLoading = false,
  // });

  // ProductsState copyWith({
  //   ProductsModel? products,
  //   String? message,
  //   Product? product,
  //   TransactionListModel? transactionListModel,
  // }) {
  //   return ProductsState(
  //     products: products ?? this.products,
  //     message: message ?? this.message,
  //     product: product ?? this.product,
  //     transactionListModel: transactionListModel ?? this.transactionListModel,
  //     loading: loading,
  //     detailLoading: detailLoading,
  //   );
  // }
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final ProductsModel products;

  ProductsLoaded({required this.products});
}

class ProductsError extends ProductsState {
  final String message;

  ProductsError({required this.message});
}

class PageUpdatedState extends ProductsState {
  final int pageIndex;
  PageUpdatedState(this.pageIndex);
}

class DetailProductLoading extends ProductsState {}

class DetailProductLoaded extends ProductsState {
  final Product product;
  final TransactionListModel transactionListModel;
  DetailProductLoaded(this.product, this.transactionListModel);
}

class DetailProductError extends ProductsState {
  final String message;
  DetailProductError(this.message);
}
