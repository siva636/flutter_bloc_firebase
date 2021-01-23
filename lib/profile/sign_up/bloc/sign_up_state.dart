part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.name = const Name.pure(),
    this.age = const Age.pure(),
    this.gender = const Gender.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final Name name;
  final Age age;
  final Gender gender;
  final FormzStatus status;

  SignUpState copyWith({
    Email email,
    Password password,
    Name name,
    Age age,
    Gender gender,
    FormzStatus status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, name, age, gender, status];
}
