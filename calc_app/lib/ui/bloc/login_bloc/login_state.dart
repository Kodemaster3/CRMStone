abstract class LoginState {
  const LoginState();
}

///The initial state before any login attempt has been made.
class LoginInitialState extends LoginState {}

///Indicates that the login process is in progress, such as when
///validating credentials or communicating with a server.
class LoginLoadingState extends LoginState {}

///Indicates that the login was successful.
class LoginSuccessState extends LoginState {}

///Indicates that the login attempt failed, usually accompanied by
///an error message or code to provide details about the failure.
class LoginFailureState extends LoginState {}

///Indicates an error occurred during the login process, such as network
///issues or server errors.
class LoginErrorState extends LoginState {}

/// Represents a state where the login form is ready for user input.
class LoginNewIdleState extends LoginState {}

/// A state where the password is ready for user update.
class LoginUpdateIdleState extends LoginState{}
