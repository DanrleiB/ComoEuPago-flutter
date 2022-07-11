import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonCalc extends StatefulWidget {
  ButtonCalc(this.text, this.onPressed, {Key? key}) : super(key: key);

  String text;
  Function() onPressed;

  @override
  State<ButtonCalc> createState() => _ButtonCalcState();
}

class _ButtonCalcState extends State<ButtonCalc> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 150,
        child: ElevatedButton(
          child: Text(widget.text, style: GoogleFonts.adamina(),),
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}
