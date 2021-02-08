// import 'dart:async';
import 'package:flutter_bloc_firebase/profile/models/models.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:flutter_bloc_firebase/authentication/models/models.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(
      {@required AuthenticationRepository authenticationRepository,
      @required ProfileRepository profileRepository})
      : this._authenticationRepository = authenticationRepository,
        this._profileRepository = profileRepository,
        super(SignUpState());

  AuthenticationRepository _authenticationRepository;
  ProfileRepository _profileRepository;

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield _emailChanged(event);
    }
    if (event is EmailUnfocused) {
      yield _emailUnfocused();
    }
    if (event is PasswordChanged) {
      yield _passwordChanged(event);
    }
    if (event is PasswordUnfocused) {
      yield _passwordUnfocused();
    }
    if (event is NameChanged) {
      yield _nameChanged(event);
    }
    if (event is NameUnfocused) {
      yield _nameUnfocused();
    }
    if (event is AgeChanged) {
      yield _ageChanged(event);
    }
    if (event is AgeUnfocused) {
      yield _ageUnfocused();
    }
    if (event is GenderChanged) {
      yield _genderChanged(event);
    }
    if (event is GenderUnfocused) {
      yield _genderUnfocused();
    }
    if (event is FormSubmitted) {
      yield* _formSubmitted();
    }
  }

  SignUpState _emailChanged(EmailChanged event) {
    final email = Email.dirty(event.email);
    return state.copyWith(
        email: email,
        status: Formz.validate(
            [email, state.password, state.name, state.age, state.gender]));
  }

  SignUpState _emailUnfocused() {
    final email = Email.dirty(state.email.value);
    return state.copyWith(
        email: email,
        status: Formz.validate(
            [email, state.password, state.name, state.age, state.gender]));
  }

  SignUpState _passwordChanged(PasswordChanged event) {
    final password = Password.dirty(event.password);
    return state.copyWith(
        password: password,
        status: Formz.validate(
            [state.email, password, state.name, state.age, state.gender]));
  }

  SignUpState _passwordUnfocused() {
    final password = Password.dirty(state.password.value);
    return state.copyWith(
        password: password,
        status: Formz.validate(
            [state.email, password, state.name, state.age, state.gender]));
  }

  SignUpState _nameChanged(NameChanged event) {
    final name = Name.dirty(event.name);
    return state.copyWith(
        name: name,
        status: Formz.validate(
            [state.email, state.password, name, state.age, state.gender]));
  }

  SignUpState _nameUnfocused() {
    final name = Name.dirty(state.name.value);
    return state.copyWith(
        name: name,
        status: Formz.validate(
            [state.email, state.password, name, state.age, state.gender]));
  }

  SignUpState _ageChanged(AgeChanged event) {
    final age = Age.dirty(event.age);
    return state.copyWith(
        age: age,
        status: Formz.validate(
            [state.email, state.password, state.name, age, state.gender]));
  }

  SignUpState _ageUnfocused() {
    final age = Age.dirty(state.age.value);
    return state.copyWith(
        age: age,
        status: Formz.validate(
            [state.email, state.password, state.name, age, state.gender]));
  }

  SignUpState _genderChanged(GenderChanged event) {
    final gender = Gender.dirty(event.gender);
    return state.copyWith(
        gender: gender,
        status: Formz.validate(
            [state.email, state.password, state.name, state.age, gender]));
  }

  SignUpState _genderUnfocused() {
    final gender = Gender.dirty(state.gender.value);
    return state.copyWith(
        gender: gender,
        status: Formz.validate(
            [state.email, state.password, state.name, state.age, gender]));
  }

  Stream<SignUpState> _formSubmitted() async* {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    yield state.copyWith(
      email: email,
      password: password,
      status: Formz.validate([email, password]),
    );
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        String uid = await _authenticationRepository.signUp(
            state.email.value, state.password.value);
        await _profileRepository.createProfile(
            uid: uid,
            name: state.name.value,
            age: int.parse(state.age.value),
            gender: state.gender.value);
      } catch (e) {
        print('Sign up error! $e');
        addError(Exception('Sign up error!'), StackTrace.current);
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
      yield state.copyWith(status: FormzStatus.submissionSuccess);
    }
  }

  // _createProfile(
  //     {String email,
  //     String password,
  //     int age,
  //     String gender,
  //     String name}) async {
  //   final String uid = await _authenticationRepository.signUp(email, password);
  //   await _profileRepository.createProfile(
  //       uid: uid, age: age, gender: gender, name: name);
  //   return SignUpInitial();
  // }

  // _deleteProfile(String uid) async {
  //   await _authenticationRepository.deleteUser();
  //   await _profileRepository.deleteProfile(uid);
  // }
}
