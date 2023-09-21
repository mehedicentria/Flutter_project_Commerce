

class Validator {
  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    if (email.isEmpty) {
      return 'email can\'t be empty';
    }
    return null;
  }


  static String? validatePassword({required String? password}) {
    if(password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }

  



}