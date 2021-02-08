import 'package:formz/formz.dart';

enum AgeValidationError { invalid }

class Age extends FormzInput<String, AgeValidationError> {
  const Age.pure() : super.pure('');
  const Age.dirty([String value = '']) : super.dirty(value);

  @override
  AgeValidationError validator(String value) {
    return value.indexOf('.') == -1 && double.tryParse(value) != null
        ? null
        : AgeValidationError.invalid;
  }
}
