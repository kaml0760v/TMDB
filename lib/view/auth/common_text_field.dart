import 'package:flutter/material.dart';

import '../../_core/app_theme/app_theme.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyBoardType;
  final IconData icon;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmit;
  final String label;
  final bool obscureText;

  const CommonTextField({
    Key? key,
    required this.icon,
    required this.label,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.keyBoardType,
    this.onFieldSubmit,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        suffix: Icon(
          icon,
        ),
        labelText: label,
        labelStyle: Theme.of(context).textTheme.caption,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: const BorderSide(
            color: AppTheme.grey3,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: const BorderSide(
            color: AppTheme.grey3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: const BorderSide(
            color: AppTheme.grey3,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: const BorderSide(
            color: AppTheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: const BorderSide(
            color: AppTheme.error,
          ),
        ),
      ),
      style: Theme.of(context).textTheme.caption,
      textAlignVertical: TextAlignVertical.center,
      autocorrect: false,
      obscureText: obscureText,
      validator: validator,
      onFieldSubmitted: onFieldSubmit,
    );
  }
}
