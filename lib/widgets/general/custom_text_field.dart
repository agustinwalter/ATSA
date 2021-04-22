import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    this.controller,
    this.textInputAction,
    this.onEditingComplete,
    this.labelText,
    this.icon,
    this.focusColor,
    this.focusNode,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.inputFormatters,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final void Function() onEditingComplete;
  final String labelText;
  final IconData icon;
  final Color focusColor;
  final FocusNode focusNode;
  final bool obscureText;
  final TextInputType keyboardType;
  final String Function(String) validator;
  final AutovalidateMode autovalidateMode;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: focusColor),
      child: TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
        focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        autovalidateMode: autovalidateMode,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          prefixIcon: Icon(icon),
          errorMaxLines: 2,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
