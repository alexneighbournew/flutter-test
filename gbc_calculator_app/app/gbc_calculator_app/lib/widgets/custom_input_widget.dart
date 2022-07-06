import 'package:flutter/material.dart';

//import 'package:provider/provider.dart';

//import 'package:gbc_calculator_app/providers/providers.dart' show CalculatorFormProvider;

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
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  final String? formProperty;
  final Map<String, String>? formValues;

  const CustomInput({
    Key? key, 
    this.autofocus,
    this.controller,
    this.enabled,
    this.errorLabel,
    this.formValues,
    this.helperMaxLines,
    this.helperText,
    this.hintText, 
    this.icon, 
    this.initialValue,
    this.keyboardType, 
    this.labelText, 
    this.obscureText = false,
    this.onChanged,
    this.readOnly,
    this.required,
    this.suffixIcon, 
    this.formProperty, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //final calcFormPvd = Provider.of<CalculatorFormProvider>(context);
    final bool isReadOnly = readOnly ?? false;
    final bool isRequired = required ?? false;
    

    return TextFormField(
      readOnly: readOnly ?? false,
      enabled: enabled,
      autofocus: autofocus ?? false,
      initialValue: initialValue ?? '',
      keyboardType: keyboardType,
      obscureText: obscureText,
      textCapitalization: TextCapitalization.words,
      onChanged: onChanged,
      validator: ( value ) {        
        if ( ( isRequired == true  && value == null ) ) return 'Este campo es requerido';
        return ( isRequired == true && value!.isEmpty ) ? ( errorLabel ?? 'Ingrese un valor' ) : null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
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