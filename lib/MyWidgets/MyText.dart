import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final text;
  final size;
  final color;
  final textAlign;
  final fontWeight;
  bool showEllipsis;
  int lines;

  MyText({Key? key,required this.text,required this.size,this.color,this.textAlign,this.fontWeight,this.showEllipsis = false,this.lines = 3}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: lines,
      textAlign: textAlign,
      overflow: showEllipsis ? TextOverflow.ellipsis : null,
      style: GoogleFonts.poppins(
        fontSize: size,
        fontWeight: fontWeight == null ? FontWeight.w600 : fontWeight,
        color: color?? Colors.black,
      ),
    );
  }
}