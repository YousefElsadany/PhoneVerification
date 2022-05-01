import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phone_verfication/PhoneVerIfication.dart';
import 'package:phone_verfication/SignUp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var phoneController =  TextEditingController();
  var formKey = GlobalKey<FormState>();
  final PhoneVerification phoneVerification = PhoneVerification();
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Welcome,',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(const SignUpScreen());
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Text(
                              'Sign in to Continue',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Color(0xff929292),
                              ),
                            ),
                            const SizedBox(
                              height: 38.0,
                            ),
                            // ignore: prefer_const_constructors
                            Text(
                              'Phone',
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                fontSize: 14.0,
                                color: const Color(0xff929292),
                              ),
                            ),
                            customTextFeild(
                              controller: phoneController,
                              inputType: TextInputType.emailAddress,
                              title: '',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'phone Required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 38.0,
                            ),


                        customButtom(
                            buttomCollor: Colors.green,
                            buttomWidth: double.infinity,
                            text: 'LOGIN',
                            press: () {
                              formKey.currentState!.save();
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  phoneVerification.signInWithPhoneNumber(phone: phoneController.text,);
                                  Get.snackbar('Login', 'Login Success');
                                });
                              }
                            }),
                      ],
                    ),
              ]
                  ),
          ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
Widget customButtom({
  required Color buttomCollor,
  double? buttomWidth,
  required String text,
  required Function()? press,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: buttomCollor,
      ),
      width: buttomWidth,
      child: MaterialButton(
        onPressed: press,
        child: Text(
          text.toUpperCase(),
          style:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

Widget customTextFeild({
  Color? textColor,
  required TextEditingController controller,
  required TextInputType inputType,
  required String title,
  IconData? pIcon,
  bool isPassword = false,
  IconData? sIcon,
  String? Function(String?)? validate,
  Function()? tap,
  String? Function(String?)? change,
  String? Function(String?)? Submit,
  suffixPress,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: isPassword,
      validator: validate,
      onChanged: change,
      onFieldSubmitted: Submit,
      onTap: tap,
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        focusedBorder:  UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffdddddd),
          ),
        ),
        labelText: title,
        labelStyle: TextStyle(color: Colors.grey[500]),
        suffixStyle: TextStyle(backgroundColor: Colors.grey[700]),
        suffixIcon: IconButton(
          icon: Icon(
            sIcon,
            color: Colors.green,
          ),
          onPressed: suffixPress,
        ),
      ),
    );