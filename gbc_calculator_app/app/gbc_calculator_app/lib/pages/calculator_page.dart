import 'dart:async';

import 'package:flutter/material.dart';

import 'package:gbc_calculator_app/helpers/helpers.dart' show Config, Debouncer;
import 'package:gbc_calculator_app/themes/theme.dart';
import 'package:gbc_calculator_app/widgets/widgets.dart' show CustomInput;

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora Tributaria'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              // form
              _Form(),

              // Results
              _Results(),

              SizedBox(height: 20)
            ],
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form({
    Key? key,
  }) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

    final Map<String, String> formValues = Config.formValues;

    final debouncer = Debouncer(duration: const Duration(milliseconds: 500));    

    return Form(
        key: myFormKey,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: CustomInput(
                  initialValue: formValues['salary'],
                  required: true,
                  errorLabel: 'Ingrese un valor',
                  keyboardType: TextInputType.number,
                  labelText: 'Sueldo Mensual',
                  helperText: 'Ingrese el sueldo mensual. Ej: 750.50',
                  onChanged: (String value) {
                    print(value);

                    debouncer.value = '';

                    debouncer.onValue = ( value ) async {
                      setState(() {
                        formValues['salary'] = value;
                        formValues['grossIncome'] = '${ Config.getGrossIncome( value ) }' ;
                      });
                    };

                    final timer = Timer.periodic(const Duration( milliseconds: 300), ( _ ) { 
                      debouncer.value = value;
                    });

                    Future.delayed( const Duration(milliseconds: 301) ).then((value) => timer.cancel());
                    
                  },
                )),

            // TODO: cálculo de los ingresos brutos anuales
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: CustomInput(
                  readOnly: true,
                  initialValue: formValues['grossIncome'],
                  labelText: 'Ingresos Brutos Anuales',
                  onChanged: (String value) {
                    print(value);

                    setState(() {
                      formValues['grossIncome']  = value;
                    });
                  },
                )),

            const Text(
              'Valor calculado automáticamente con respecto al Sueldo',
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: DropdownButtonFormField<Object>(
                  value: formValues['sector'],
                  items: Config.sectors.map((value) {
                    return DropdownMenuItem( value: value['value'], child: Text(value['label']));
                  }).toList(),
                  decoration: const InputDecoration(
                      labelText: '¿En qué Sector Trabajas?',
                      helperText: 'Escoje el sector en el que trabajas'),
                  onChanged: (Object? value) {
                    print(value);
                    setState(() {
                      formValues['sector'] = '$value';
                    });
                  }),
            ),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: DropdownButtonFormField<Object>(
                    value: formValues['differentCaps'],
                    items: Config.differentCapacities.map((value) {
                      return DropdownMenuItem( value: value['value'], child: Text(value['label']));
                    }).toList(),
                    decoration: const InputDecoration(
                        labelText: '¿Tienes Capacidades Diferentes?',
                        helperText:
                            'Cuéntanos si tienes una capacidad diferente'),
                    onChanged: (Object? value) {
                      print(value);
                      setState(() {
                        formValues['differentCaps'] = '$value';
                        formValues['percentsDifferentCaps'] = '0';
                      });
                    })),

            if (formValues['differentCaps'] != null && formValues['differentCaps']!.isNotEmpty && formValues['differentCaps']! == 'yes')
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: DropdownButtonFormField<Object>(
                      value: '${formValues['percentsDifferentCaps']}',
                      items: Config.percentsDifferentCaps.map((value) {
                        return DropdownMenuItem( value: '${value['value']}', child: Text(value['label']));
                      }).toList(),
                      decoration: const InputDecoration(
                          labelText: 'Rango de Capacidad Diferente',
                          helperText: 'Escoja el rango del Porcentaje de Capacidad Diferente que posee',
                          helperMaxLines: 2),
                      onChanged: (Object? value) {
                        print(value);
                        setState(() {
                          formValues['percentsDifferentCaps'] = '$value';
                        });
              })),

            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: CustomInput(
                  initialValue: formValues['personalExps'],
                  required: true,
                  errorLabel: 'Ingrese un valor',
                  keyboardType: TextInputType.number,
                  labelText: 'Gastos Personales',
                  helperText:
                      'Coloca una cifra aproximada de tus gastos personales para el 2022. Podrás utilizar un máximo de 7 canastas básicas** \$5,037.55',
                  helperMaxLines: 3,
                  formProperty: 'personalExps',
                  formValues: formValues,
                  onChanged: (String value) {
                    print(value);

                    debouncer.value = '';

                    debouncer.onValue = ( value ) async {
                      setState(() {
                        formValues['personalExps'] = value;
                      });
                    };

                    final timer = Timer.periodic(const Duration( milliseconds: 300), ( _ ) { 
                      debouncer.value = value;
                    });

                    Future.delayed( const Duration(milliseconds: 301) ).then((value) => timer.cancel());
                    
                  },
                )),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppTheme.colorPrimary),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))))),
                  onPressed: () {
                    FocusManager.instance.primaryFocus ?.unfocus(); // keyboard hide

                    if (!myFormKey.currentState!.validate()) {
                      print('Formulario no válido');
                      return;
                    }

                    // print form values
                    print(formValues);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Calcular',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.6),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.calculate,
                          color: Colors.white,
                        )
                      ])),
            )
          ],
        ));
  }
}

class _Results extends StatelessWidget {
  const _Results({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text('Impuesto calculado:', style: AppTheme.resultStyle),
              Expanded(child: Container()),
              Text('\$ 0.00', style: AppTheme.resultStyle),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Rebaja por gastos personales:',
                  style: AppTheme.resultStyle),
              Expanded(child: Container()),
              Text('\$ 0.00', style: AppTheme.resultStyle),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Impuesto anual a pagar:', style: AppTheme.resultStyle),
              Expanded(child: Container()),
              Text('\$ 0.00', style: AppTheme.resultStyle),
            ],
          )
        ],
      ),
    );
  }
}
