import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutritrack/commons/global_variables.dart';


class CustomButton extends StatelessWidget {
  final Function()? onClick;
  final String text;
  const CustomButton({super.key, required this.onClick, required this.text});
  
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15.0, right: 15.0,),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: GlobalVariables.mainColor,
          ),
          child: Center(child: Text(text, style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.7,
            ),
          ),),),
        ),
      ),
    );
  }
}