abstract class RegisterState{}

class RegisterInitState extends RegisterState{}

class RegisterPassVisibilityState extends RegisterState{}

class RegisterConfPassVisibilityState extends RegisterState{}

class RegisterLoadingState extends RegisterState{}

class RegisterSuccessState extends RegisterState{}

class RegisterErrorState extends RegisterState{
  final String error;
  RegisterErrorState(this.error);
}