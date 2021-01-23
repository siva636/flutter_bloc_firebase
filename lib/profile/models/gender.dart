import 'package:formz/formz.dart';

enum GenderValidationError { invalid }

class Gender extends FormzInput<String, GenderValidationError> {
  const Gender.pure() : super.pure('');
  const Gender.dirty([String value = '']) : super.dirty(value);

  @override
  GenderValidationError validator(String value) {
    return value == 'male' || value == 'female'
        ? null
        : GenderValidationError.invalid;
  }
}
