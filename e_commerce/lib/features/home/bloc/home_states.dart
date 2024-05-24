abstract class HomeState{}

class HomeInitState extends HomeState{}

class HomeLoadingState extends HomeState{}

class HomeSuccessState extends HomeState{}

class HomeErrorState extends HomeState{
  String error;
  HomeErrorState(this.error);
}

class HomePaginationLoadingState extends HomeState{}

class HomePaginationErrorState extends HomeState{}

class HomePaginationSuccessState extends HomeState{}