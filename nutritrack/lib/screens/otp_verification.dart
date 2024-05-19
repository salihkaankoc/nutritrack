import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/commons/global_variables.dart';
import 'package:nutritrack/services/services.dart';
import 'package:nutritrack/widgets/custom_button.dart';

class OtpVerification extends StatefulWidget {
 


  OtpVerification({super.key, });

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

TextEditingController firstNumber = TextEditingController();
TextEditingController secondNumber = TextEditingController();
TextEditingController thirdNumber = TextEditingController();
TextEditingController fourthNumber = TextEditingController();
FocusNode secondNode = FocusNode();
FocusNode thirdNode = FocusNode();
FocusNode fourthNode = FocusNode();
ApiService _apiService = ApiService();
var errorBar = SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Error',
      message: 'Invalid OTP. Please check your code again.',
      contentType: ContentType.failure,
    ),
  );
  var successBar = SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Success!',
      message: 'User registered successfully!',
      contentType: ContentType.success,
    ),
  );

class _OtpVerificationState extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
     verifyOTP() async {
      try {
        var response = await _apiService.verifyOTP(email: data['email'] ,
         password: data['password'],
          username: data['username'], 
          age: data['age'],
          gender: data['gender'],
           height: data['height'], 
           kilogram: data['kilogram'],
           otp: "${firstNumber.text}${secondNumber.text}${thirdNumber.text}${fourthNumber.text}"
           );
         print(response);
        if(response.data['status'] == -1) {
          return ScaffoldMessenger.of(context).showSnackBar(errorBar);
        } else if(response.data['status'] == 1) {
          Navigator.pushReplacementNamed(context, "/login");
            return ScaffoldMessenger.of(context).showSnackBar(successBar);
            
        }
      } catch (e) {
        print(data);
        print('Error $e');
      }
    }
    print("${firstNumber.text}${secondNumber.text}${thirdNumber.text}${fourthNumber.text}");
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 140.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
              right: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'OTP VERIFICATION',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: GlobalVariables.mainColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Text(
                  'A verification code has been sent to your email address.',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 60,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: firstNumber,
                          onChanged: (e) {
                            if (e.length == 1) {
                              FocusScope.of(context).requestFocus(secondNode);
                            }
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: "",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: GlobalVariables.mainColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: GlobalVariables.mainColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: secondNumber,
                          focusNode: secondNode,
                          onChanged: (e) {
                            if (e.length == 1) {
                              FocusScope.of(context).requestFocus(thirdNode);
                            }
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: "",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: GlobalVariables.mainColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: GlobalVariables.mainColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: thirdNumber,
                          onChanged: (e) {
                            if (e.length == 1) {
                              FocusScope.of(context).requestFocus(fourthNode);
                            }
                          },
                          focusNode: thirdNode,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: "",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: GlobalVariables.mainColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: GlobalVariables.mainColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          focusNode: fourthNode,
                          controller: fourthNumber,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: "",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: GlobalVariables.mainColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: GlobalVariables.mainColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                    onClick: () {
                      verifyOTP();
                    },
                    text: 'Confirm')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
