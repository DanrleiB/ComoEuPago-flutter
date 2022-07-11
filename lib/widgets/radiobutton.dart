import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
   RadioButton(this.value, this.valueGroup, this.onChanged,{ Key? key }) : super(key: key);
  
  int value;
  int valueGroup;
  Function() onChanged;


  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Radio(
      value: widget.value,
      groupValue: widget.valueGroup,
      onChanged: widget.onChanged(),
    );
  }
}