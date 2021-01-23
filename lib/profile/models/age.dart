import 'package:formz/formz.dart';

enum AgeValidationError { empty }

class Age extends FormzInput<String, AgeValidationError> {
  const Age.pure() : super.pure('');
  const Age.dirty([String value = '']) : super.dirty(value);

  @override
  AgeValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : AgeValidationError.empty;
  }
}
