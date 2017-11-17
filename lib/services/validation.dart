class Validation{
  String validateEmail(String value) {
    if (value.isEmpty) return 'Email is required.';
    final RegExp nameExp = new RegExp(r'^(\w|\D)+@[a-zA-Z_]+?\.[a-zA-Z.]{2,5}$');
    if (!nameExp.hasMatch(value)) return 'Invalid email address';
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) return 'Please choose a password.';
    if (value.length < 8) return 'Password length must be at least 8.';
    return null;
  }

  String validateName(String value) {
    if (value.isEmpty) return 'Please write something.';
    return null;
  }

  String validateDay(String value) {
    if (value.isEmpty) return 'Error.';
    if (value.length >= 3) return 'noooo';
    return null;
  }

  String validatMonth(String value) {
    if (value.isEmpty) return 'Error.';
    if (value.length >= 3) return 'noooo';
    return null;
  }

  String validatYear(String value) {
    if (value.isEmpty) return 'Error.';
    if (value.length <= 3) return 'noooo';
    return null;
  }
}