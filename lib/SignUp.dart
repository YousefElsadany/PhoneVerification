import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phone_verfication/PhoneVerIfication.dart';
import 'package:phone_verfication/Verification.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  var phoneController =  TextEditingController();
  var formKey = GlobalKey<FormState>();
  String? phoneNumber ;
  final PhoneVerification phoneVerification = PhoneVerification();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          margin: const EdgeInsetsDirectional.only(start: 16, end: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customHeader("Welcome", "Continue with Phone number"),
              buildPhoneFormField(context, phoneController, phoneNumber),
              customButtom(
                buttomCollor: Colors.green,
                text: "Confirm",
                press: ()  {
                  //showLoadingDialog(context);
                  setState(() {
                    submitPhone(context);
                  });

                },
                buttomWidth: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> submitPhone(BuildContext context) async {
    if (formKey.currentState!.validate())  {

      formKey.currentState!.save();

        phoneVerification.signUpWithPhoneNumber(phoneController.text);
        Get.to(VerificationScreen( phoneNumber:phoneController.text,));

      // controller.signinWithPhoneNumber(phoneController.text);
      // Get.to(Validation( phoneNumber:phoneController.text,));
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
  Widget customHeader(String header, String title) => Container(
    margin: const EdgeInsetsDirectional.only(top: 9, bottom: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(
            fontSize: 26,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(title, style: const TextStyle(fontSize: 16))
      ],
    ),
  );

  Widget buildPhoneFormField(BuildContext context,
      TextEditingController textEditingController, String? phoneNumber) {
    var width = MediaQuery
        .of(context)
        .size
        .width * 0.75;
    var height = MediaQuery
        .of(context)
        .size
        .height * 0.65;
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Expanded(

        child: TextFormField(

          controller: textEditingController,
          autofocus: true,
          style: const TextStyle(
            fontSize: 22,
            letterSpacing: 2.0,
          ),
          decoration: const InputDecoration(
              fillColor: Colors.grey,
              filled: true,
              contentPadding: EdgeInsets.all(10),
              constraints: BoxConstraints(
                  maxHeight: double.infinity, maxWidth: double.infinity),
              border: InputBorder.none),
          cursorColor: Colors.black,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter you phone number!';
            } else if (value.length < 10) {
              return 'Too short for a phone number!';
            }
            return null;
          },

          onSaved: (value) {
            phoneNumber = value;
          },
        ),
      )
    ]);
  }

}
