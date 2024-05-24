abstract class LoginState{}

class LoginInitState extends LoginState{}

class LoginUserCheckState extends LoginState{}

class LoginPassVisibilityState extends LoginState{}

class LoginLoadingState extends LoginState{}

class LoginSuccessState extends LoginState{}

class LoginErrorState extends LoginState{
  final String error;
  LoginErrorState(this.error);
}