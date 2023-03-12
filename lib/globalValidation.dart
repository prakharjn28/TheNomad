mixin InputValidationMixin {
  bool isNameValid(String name) => name.isEmpty;
  bool isLastNameValid(String name) => name.isEmpty;
  bool isPasswordValid(String password) => password.length >= 6;
  bool isVerifyPasswordValid(String password, String pass) => password == pass;

  bool isEmailValid(String email) {
    return RegExp(r'\S+@\S+\.\S+').hasMatch(email);
  }
}
