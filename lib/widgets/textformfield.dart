import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentText extends StatefulWidget {
  PaymentText(this.label, this.controller, this.validator, this.keyboardType,
      {Key? key, this.formType})
      : super(key: key);

  String label;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  int? formType;

  @override
  State<PaymentText> createState() => _PaymentTextState();
}

class _PaymentTextState extends State<PaymentText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textAlign: TextAlign.start,
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        prefix: widget.formType == 1 ? null : widget.formType == 2 ? null : const Text('R\$ '),
        suffixIcon: widget.formType == 1 ? const Icon(Icons.calendar_today) : widget.formType == 2 ?  const Icon(Icons.percent) : const Icon(Icons.attach_money),
        focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.amber)),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.black),
      ),
      style:  GoogleFonts.unna(color: Colors.black, fontSize: 12),
    );
  }
}
