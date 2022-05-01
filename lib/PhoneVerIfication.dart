import 'package:firebase_auth/firebase_auth.dart';

  class  PhoneVerification {
  late String _verificationCode;

  Future<void> signUpWithPhoneNumber(String phoneNum) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+20${phoneNum}",
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _codeSentToUser,
      timeout: const Duration(seconds:25),
      codeAutoRetrievalTimeout:codeAutoRetrievalTimeout,
    );
  }

  void _verificationCompleted(PhoneAuthCredential credential) async {
    await userSignIn(credential);
  }

  void _verificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
  }

  void _codeSentToUser(String verificationID, int? reSentCode) {
    _verificationCode = verificationID;
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    _verificationCode = verificationId;

  }

  Future<void> submitOtbCode(String otpCode) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationCode, smsCode: otpCode);

    await userSignIn(phoneAuthCredential);
  }

  Future<void> userSignIn(PhoneAuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
  void signInWithPhoneNumber({required String phone})  {
     FirebaseAuth.instance.signInWithPhoneNumber(phone).then((value) {
       print('LOGIN SUCCESS ' + value.toString());
     }).catchError((error) {
       print('ERROR LOGIN' + error.toString());
     });
  }
}


