import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  final String label;

  final TextInputType type;
  final TextEditingController ctl;
  const InputTextWidget(
      {Key? key, required this.label, required this.type, required this.ctl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctl,
      keyboardType: type,
       style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white54),
        
        hintStyle: TextStyle(color: Colors.white60),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
