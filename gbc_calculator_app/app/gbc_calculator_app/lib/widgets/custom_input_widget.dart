import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final String? initialValue;
  final bool? readOnly;
  final bool? enabled;
  final bool? autofocus;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final int? helperMaxLines;
  final bool? required;
  final String? errorLabel;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;

  final String formProperty;
  final Map<String, String> formValues;

  const CustomInput({
    Key? key, 
    this.initialValue,
    this.readOnly,
    this.enabled,
    this.autofocus,
    this.hintText, 
    this.labelText, 
    this.helperText,
    this.helperMaxLines,
    this.required,
    this.errorLabel,
    this.icon, 
    this.suffixIcon, 
    this.keyboardType, 
    this.obscureText = false, 
    required this.formProperty, 
    required this.formValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bool isReadOnly = readOnly ?? false;
    final bool isRequired = required ?? false;

    return TextFormField(
      readOnly: readOnly ?? false,
      enabled: enabled,
      autofocus: autofocus ?? false,
      initialValue: initialValue,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textCapitalization: TextCapitalization.words,
      onChanged: ( String value) => formValues[formProperty] = value,
      validator: ( value ) {        
        if ( ( isRequired == true  && value == null ) ) return 'Este campo es requerido';
        return ( isRequired == true && value!.isEmpty ) ? ( errorLabel ?? 'Ingrese un valor' ) : null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: !isReadOnly
        ? InputDecoration(
            hintText: hintText,
            labelText: labelText,
            helperText: helperText,
            helperMaxLines: helperMaxLines,
            suffixIcon: suffixIcon == null ? null : Icon( suffixIcon ),
            icon: icon == null ? null : Icon( icon ),
        )
        : InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            labelText: labelText,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.only( topRight: Radius.circular( 10 ), bottomLeft: Radius.circular( 10 ) )
            ),                  
        ),
    );
  }
}