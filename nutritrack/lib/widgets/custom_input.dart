import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/commons/global_variables.dart';

class CustomInput extends StatelessWidget {
  final String hint;
  final Icon icon;
  final TextInputType type;
  final bool obs;
  final String title;
  final TextEditingController controller;

  const CustomInput(
      {super.key,
      required this.controller,
      required this.icon,
      required this.type,
      required this.hint,
      required this.obs,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        height: 60,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            keyboardType: type,
            obscureText: obs,
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: icon,
              prefixIconColor: GlobalVariables.secondColor,
              focusedBorder:  OutlineInputBorder(
                 borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: GlobalVariables.secondColor,
                  
                ),
              ),
              focusColor: GlobalVariables.secondColor,
              
              isDense: true,
              hintText: hint,
              hintStyle: GoogleFonts.poppins(),
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  
                  color: GlobalVariables.secondColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
