import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phone_verfication/Login.dart';
import 'package:phone_verfication/PhoneVerIfication.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;

   VerificationScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  PhoneVerification phoneVerification = PhoneVerification();
  TextEditingController validationController = TextEditingController();
  late String otpCode;
  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    //String code = "";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          //margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.05,
                left: 16,
                right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Validation Code",
                  style: TextStyle(fontSize: 26),
                ),


                const SizedBox(
                  height: 44,
                ),
                Container(
                  //color: Colors.blue,
                  margin: const EdgeInsets.only(left: 9),
                  child: const Text("Enter Validation Code",
                      style: TextStyle(fontSize: 14)),
                ),
                const SizedBox(
                  height: 18,
                ),
                buildPinCodeContainer(context),
                const SizedBox(
                  height: 38,
                ),
                customButtom(
                  buttomCollor: Colors.green,
                  text: "Confirm",
                  press: () {
                    setState(() {
                      phoneVerification.submitOtbCode(otpCode);
                      print(otpCode + 'Success OTPCODE********');
                      Get.to(LoginScreen());
                    });

                  },
                  buttomWidth: double.infinity,
                ),
                const SizedBox(
                  height: 73,
                ),
                const Center(
                  child: Text(
                    "Didn’t receive an activation code?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            )),
      ),
    );
  }
  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 26,
        height: 86,
        child: Container(
          padding: const EdgeInsets.only(top: 15),
          decoration: const BoxDecoration(
            //color: Color(0xfff6f5fa),
            image:
            DecorationImage(image: AssetImage('assets/images/empty.png')),

          ),
          child: Text(
            codeNumber,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F1F1F),
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }


  Widget buildPinCodeContainer(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      appContext: context,
      obscureText: false,
      animationType: AnimationType.scale,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 50,
          activeFillColor: Colors.blue[100],
          inactiveFillColor: Colors.grey,
          borderWidth: 1,
          //selectedFillColor: CustomColors.googleBackground,
          inactiveColor: Colors.green,
         // activeColor:CustomColors.colorAmber,
          //selectedColor: CustomColors.colorYellow
      ),
      animationDuration: const Duration(milliseconds: 300),
      //backgroundColor: CustomColors.backgroundColor,
      enableActiveFill: true,
      controller: validationController,
      onCompleted: (code) {
        otpCode = code;
      },
      onChanged: (value) {
      },
    );
  }
}
