import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget{
    final TextEditingController textEditingController;
    final bool ifPass;
    final String hintText;
    final TextInputType textInputType;

  const TextFieldInput({
    Key? key,
    required this.textEditingController, 
    this.ifPass = false, 
    required this.hintText, 
    required this.textInputType, 

    }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final inputBoarder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
      borderRadius: BorderRadius.circular(10),
    );

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBoarder,
        focusedBorder: inputBoarder,
        enabledBorder: inputBoarder,
        filled: true,
        contentPadding: const EdgeInsets.all(8)
      ),
      keyboardType: textInputType,
      obscureText: ifPass,
    );
  }



}