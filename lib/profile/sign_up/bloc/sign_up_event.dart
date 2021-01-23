part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends SignUpEvent {
  const EmailChanged({@required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailUnfocused extends SignUpEvent {}

class PasswordChanged extends SignUpEvent {
  const PasswordChanged({@required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordUnfocused extends SignUpEvent {}

class NameChanged extends SignUpEvent {
  const NameChanged({@required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class NameUnfocused extends SignUpEvent {}

class AgeChanged extends SignUpEvent {
  const AgeChanged({@required this.age});

  final String age;

  @override
  List<Object> get props => [age];
}

class AgeUnfocused extends SignUpEvent {}

class GenderChanged extends SignUpEvent {
  const GenderChanged({@required this.gender});

  final String gender;

  @override
  List<Object> get props => [gender];
}

class GenderUnfocused extends SignUpEvent {}

class FormSubmitted extends SignUpEvent {}
