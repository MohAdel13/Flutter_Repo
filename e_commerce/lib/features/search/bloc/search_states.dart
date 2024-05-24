abstract class SearchState{}

class SearchInitState extends SearchState{}

class SearchLoadingState extends SearchState{}

class SearchErrorState extends SearchState{
  String error;
  SearchErrorState(this.error);
}

class SearchSuccessState extends SearchState{}

class SearchPaginationLoadingState extends SearchState{}

class SearchPaginationErrorState extends SearchState{}

class SearchPaginationSuccessState extends SearchState{}