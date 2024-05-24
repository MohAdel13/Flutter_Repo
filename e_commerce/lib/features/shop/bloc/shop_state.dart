abstract class ShopState{}

class ShopInitState extends ShopState{}

class ShopSuccessState extends ShopState{}

class ShopErrorState extends ShopState{
  String error;
  ShopErrorState(this.error);
}

class ShopPaginationLoadingState extends ShopState{}

class ShopPaginationErrorState extends ShopState{}

class ShopPaginationSuccessState extends ShopState{}

class ShopLoadingState extends ShopState{}