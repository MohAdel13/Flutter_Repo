abstract class ProductsState{}

class ProductsInitState extends ProductsState{}

class ProductsLoadingState extends ProductsState{}

class ProductsSuccessState extends ProductsState{}

class ProductsErrorState extends ProductsState{
  String error;
  ProductsErrorState(this.error);
}

class ProductsPaginationLoadingState extends ProductsState{}

class ProductsPaginationErrorState extends ProductsState{}

class ProductsPaginationSuccessState extends ProductsState{}
