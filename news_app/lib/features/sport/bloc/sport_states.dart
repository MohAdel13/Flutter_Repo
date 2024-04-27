abstract class SportState {}

class SportInitState extends SportState {}

class SportLoadingState extends SportState{}

class SportGetDataSuccessState extends SportState{}

class SportGetDataErrorState extends SportState{
  final String error;
  SportGetDataErrorState({required this.error});
}