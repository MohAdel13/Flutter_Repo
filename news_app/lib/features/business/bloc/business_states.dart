abstract class BusinessState{}

class BusinessInitState extends BusinessState{}

class BusinessLoadingState extends BusinessState{}

class BusinessGetDataSuccessState extends BusinessState{}

class BusinessGetDataErrorState extends BusinessState{
  final String error;
  BusinessGetDataErrorState({required this.error});
}