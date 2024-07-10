abstract class RegisterStates{}

class RegisterInitState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{}

class RegisterErrorState extends RegisterStates{
  String? error;
  RegisterErrorState(this.error);
}

class RegisterVisibilityChangeState extends RegisterStates{}

class RegisterConfPassVisibilityChangeState extends RegisterStates{}

class RegisterUserCreateErrorState extends RegisterStates{}