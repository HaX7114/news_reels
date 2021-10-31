import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_reels/Consts.dart';

class MyTextField extends StatelessWidget {
  final hintText;
  final hintTextColor;
  final labelText;
  final labelTextColor;
  final prifixIcon;
  final borderColor;
  final borderRadius;
  final validatorText;
  final ValueChanged<String> onChange;
  final TextEditingController textController;

  const MyTextField(
      {Key? key,
      this.hintText,
      this.hintTextColor,
      this.labelText,
      this.labelTextColor,
      required this.borderColor,
      required this.validatorText,
      this.prifixIcon,
      required this.textController,
      this.borderRadius,
      required this.onChange,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      maxLength: 25,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorText;
        }
      },
      onChanged: onChange,
      style: const TextStyle(
        color: K_whiteColor
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          prifixIcon,
          color: K_whiteColor,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: hintTextColor ?? K_greyColor,
          fontSize: 13.0,
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius?? 20.0),
            borderSide: BorderSide(
              color: borderColor,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius?? 20.0),
            borderSide: BorderSide(
              color: borderColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius?? 20.0),
            borderSide: BorderSide(
              color: borderColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius?? 20.0),
            borderSide: BorderSide(
              color: borderColor,
            )),
      ),
    );
  }
}
