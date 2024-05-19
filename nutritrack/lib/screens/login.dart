import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/commons/global_variables.dart';
import 'package:nutritrack/services/services.dart';
import 'package:nutritrack/widgets/custom_button.dart';
import 'package:nutritrack/widgets/custom_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ApiService apiService = ApiService();
  var successBar = SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Success!',
      message: 'Logged in!',
      contentType: ContentType.success,
    ),
  );
  var errorBar = SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Failure!',
      message: 'Invalid email or password',
      contentType: ContentType.failure,
    ),
  );
  var fillBar = SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Failure!',
      message: 'Please fill all required fields',
      contentType: ContentType.failure,
    ),
  );
  login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   if(emailController.text.isNotEmpty || passwordController.text.isNotEmpty) {
     try {
      var response = await apiService.login(
        email: emailController.text,
        password: passwordController.text,
      );
      print(response.data);
      if (response.data['status'] == 1) {
        prefs.setInt('userID', response.data['data']['id']);
        Navigator.pushReplacementNamed(context, "/", arguments: {
          "id": response.data['data']['id']
        });
        return ScaffoldMessenger.of(context).showSnackBar(successBar);
      } else if (response.data['status'] == -1) {
        return ScaffoldMessenger.of(context).showSnackBar(errorBar);
      }
    } catch (e) {
      print('Error: $e');
    }
   } else {
    return ScaffoldMessenger.of(context).showSnackBar(fillBar);
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 140.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: GlobalVariables.mainColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInput(
                  type: TextInputType.text,
                  icon: const Icon(Icons.email),
                  obs: false,
                  controller: emailController,
                  hint: 'Email',
                  title: 'Email'),
              CustomInput(
                  type: TextInputType.text,
                  icon: const Icon(Icons.lock),
                  obs: true,
                  controller: passwordController,
                  hint: 'Password',
                  title: 'Password'),
              CustomButton(
                onClick: () {
                  login();
                },
                text: 'Login',
              ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                  text: TextSpan(
                      text: "Don\'t have an account?",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, "/register");
                        },
                      text: 'Sign up',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: GlobalVariables.mainColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
