import 'package:flutter/material.dart';

class InputData extends StatelessWidget {
  InputData(
      {super.key,
      required this.hintedtext,
      required this.labledtext,
      required this.Inputcontroller});

  final String hintedtext;
  final String labledtext;
  final TextEditingController Inputcontroller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: Inputcontroller,
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          if (value!.isEmpty) {
            return "$labledtext is required";
          }
        },
        decoration: InputDecoration(
          hintText: hintedtext,
          labelText: labledtext,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.blueAccent)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.blueAccent)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.red)),
        ),
      ),
    );
  }
}
