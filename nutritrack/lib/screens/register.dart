import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/commons/global_variables.dart';
import 'package:nutritrack/services/services.dart';
import 'package:nutritrack/widgets/custom_button.dart';
import 'package:nutritrack/widgets/custom_input.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String selectedGender = "Male";
  List<String> genders = ["Male", "Female", "Other"];
  var alreadyBar = SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Error',
      message: 'Email or username already exists.',
      contentType: ContentType.failure,
    ),
  );
   var successBar = SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Yeap!',
      message: 'An OTP code send to your email address.',
      contentType: ContentType.success,
    ),
  );
  ApiService apiService = ApiService();
   register() async {
    try {
      var response = await apiService.registerUser(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
        age: int.parse(ageController.text),
        gender: selectedGender,
        height: int.parse(heightController.text),
        kilogram: double.parse(weightController.text),
      );
      print(response.data);
      if (response.data['status'] == 1) {
        ScaffoldMessenger.of(context)..showSnackBar(successBar);
        Navigator.pushReplacementNamed(
          context,
          '/otp',
          arguments: {
            'email': emailController.text,
            'password': passwordController.text,
            'username': usernameController.text,
            'age': int.parse(ageController.text),
            'gender': selectedGender,
            'height': int.parse(heightController.text),
            'kilogram': double.parse(weightController.text),
          },
        );
      } else if (response.data['status'] == -4) {
        return ScaffoldMessenger.of(context)..showSnackBar(alreadyBar);
      }
    } catch (e) {
      print('Error: $e');
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
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  'Register',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: GlobalVariables.mainColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              CustomInput(
                  type: TextInputType.text,
                  icon: const Icon(Icons.person),
                  obs: false,
                  controller: usernameController,
                  hint: 'Username',
                  title: 'Username'),
              CustomInput(
                  type: TextInputType.text,
                  icon: const Icon(Icons.lock),
                  obs: true,
                  controller: passwordController,
                  hint: 'Password',
                  title: 'Password'),
              CustomInput(
                  type: TextInputType.text,
                  icon: const Icon(Icons.email),
                  obs: false,
                  controller: emailController,
                  hint: 'Email',
                  title: 'Email'),
              CustomInput(
                  type: TextInputType.number,
                  icon: const Icon(Icons.onetwothree),
                  obs: false,
                  controller: ageController,
                  hint: 'Age',
                  title: 'Age'),
              CustomInput(
                  type: TextInputType.number,
                  icon: const Icon(Icons.onetwothree),
                  obs: false,
                  controller: heightController,
                  hint: 'Height (cm)',
                  title: 'Height'),
              CustomInput(
                  type: TextInputType.number,
                  icon: const Icon(Icons.onetwothree),
                  obs: false,
                  controller: weightController,
                  hint: 'Weight (kg)',
                  title: 'Weight'),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                child: CustomDropdown<String>(
                  decoration: const CustomDropdownDecoration(
                    closedBorder: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  hintText: 'Gender',
                  items: genders,
                  initialItem: genders[0],
                  onChanged: (value) {
                    selectedGender = value;
                  },
                ),
              ),
              CustomButton(
                onClick: () {
                  register();
                },
                text: 'Register',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
