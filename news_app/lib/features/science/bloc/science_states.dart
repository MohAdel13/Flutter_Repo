abstract class ScienceState {}

class ScienceInitState extends ScienceState {}

class ScienceLoadingState extends ScienceState{}

class ScienceGetDataSuccessState extends ScienceState{}

class ScienceGetDataErrorState extends ScienceState{
  final String error;
  ScienceGetDataErrorState({required this.error});
}