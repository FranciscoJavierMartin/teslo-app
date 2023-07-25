import 'package:formz/formz.dart';

// Define input validation errors
enum EmailError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Email extends FormzInput<String, EmailError> {
  static final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  // Call super.pure to represent an unmodified form input.
  const Email.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Email.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    String? res;

    if (!(isValid || isPure)) {
      switch (displayError) {
        case (EmailError.empty):
          res = 'Required';
          break;
        case (EmailError.format):
          res = 'Invalid format';
          break;
        default:
          res = null;
      }
    }

    return res;
  }

  // Override validator to handle validating a given input value.
  @override
  EmailError? validator(String value) {
    EmailError? res;

    if (value.isEmpty || value.trim().isEmpty) {
      res = EmailError.empty;
    } else if (!emailRegExp.hasMatch(value)) {
      res = EmailError.format;
    }

    return res;
  }
}
