abstract class LoginEvent {
  const LoginEvent();
}

class LoginStartedEvent extends LoginEvent {}

class LoginSubmittedEvent extends LoginEvent {}

class LogoutEvent extends LoginEvent {}

class LoginSingUpEvent extends LoginEvent {}

class LoginRemoveEvent extends LoginEvent {}