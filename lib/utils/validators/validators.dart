class Validators{
  static String? validateName(String? name){
    if(name == null || name.isEmpty){
      return 'Username cannot be empty.';
    }else{
      return null;
    }
  }

  static String? validateEmail(String? email){
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );
    if(email == null || email.isEmpty){
      return 'Email cannot be empty.';
    }else if(!emailRegExp.hasMatch(email)){
      return 'Enter a valid email.';
    }
    else{
      return null;
    }
  }

  static String? validatePassword(String? password){
    if(password == null || password.isEmpty){
      return 'Password cannot be empty.';
    }else if(password.length < 8){
      return 'Password must be at least 8 characters.';
    } else{
      return null;
    }
  }
  static String? validateConfirmPassword(String? confirmPassword,String? password){
    if(confirmPassword == null || confirmPassword.isEmpty){
      return 'confirmPassword cannot be empty.';
    }else if(confirmPassword!=password){
      return 'Password do not match.';
    } else{
      return null;
    }
  }

  static String? validateMyanmarPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }

    final RegExp phoneRegExp = RegExp(
      r'^09[0-9]{7,10}$',
    );

    if (!phoneRegExp.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }


}