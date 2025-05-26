part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

class GetProducts extends ProductsEvent {}

class GetDetailProduct extends ProductsEvent {
  final Product product;
  GetDetailProduct(this.product);
}

class NextPageEvent extends ProductsEvent {
  final int currentIndex;
  NextPageEvent(this.currentIndex);
}

class TransactionsNextPage extends ProductsEvent {
  final Product product;
  final int nextPage;
  TransactionsNextPage(this.product, this.nextPage);
}

class FilterTransactions extends ProductsEvent {
  final String query;
  FilterTransactions(this.query);
}
