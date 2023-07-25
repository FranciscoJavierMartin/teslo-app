import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordError { empty, length, format }

// Extend FormzInput and provide the input type and error type.
class Password extends FormzInput<String, PasswordError> {
  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  // Call super.pure to represent an unmodified form input.
  const Password.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Password.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    String? res;

    if (!(isValid || isPure)) {
      switch (displayError) {
        case PasswordError.empty:
          res = 'Required';
          break;
        case PasswordError.length:
          res = 'Min 6 characters';
          break;
        case PasswordError.format:
          res = 'Must contain a upper case letter and a number';
          break;
        default:
          res = null;
      }
    }

    return res;
  }

  // Override validator to handle validating a given input value.
  @override
  PasswordError? validator(String value) {
    PasswordError? res;

    if (value.isEmpty || value.trim().isEmpty) {
      res = PasswordError.empty;
    } else if (value.length < 6) {
      res = PasswordError.length;
    } else if (!passwordRegExp.hasMatch(value)) {
      res = PasswordError.format;
    }

    return res;
  }
}
