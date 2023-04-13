class AppValidator{

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return  "Enter Your Password";
    } else if (value.length<6) {
      return 'Password length must be greater than 5 characters.';
    } else {
      return null;
    }
  }


  static String? phoneNoValidator(String? value) {
    if (value!.isEmpty) {
      return  "Enter Your Phone No";
    } else if (value.length!=10) {
      return 'Phone Number length must be at least 10 characters.';
    } else {
      return null;
    }
  }

  static String? otpValidator(String? value) {
    if (value!.isEmpty) {
      return  "Enter Your Otp";
    } else if (value.length!=6) {
      return 'Phone Number length must be at least 6 characters.';
    } else {
      return null;
    }
  }


}


