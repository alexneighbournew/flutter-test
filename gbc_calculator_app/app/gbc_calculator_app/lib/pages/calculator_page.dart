import 'dart:async';

import 'package:flutter/material.dart';

import 'package:gbc_calculator_app/helpers/helpers.dart' show Config, Debouncer;
import 'package:gbc_calculator_app/providers/providers.dart'
    show CalculatorFormProvider;
import 'package:gbc_calculator_app/themes/theme.dart';
import 'package:gbc_calculator_app/widgets/widgets.dart' show CustomInput;
import 'package:provider/provider.dart';

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

    double personalContribution = 0;
    double netIncome            = 0;
    double basicFraction        = 0;
    double surplusFraction      = 0;
    double taxOnBasicFraction   = 0;
    double taxOnSurplusFraction = 0;
    double totalTax             = 0;
    double totalTaxToPay        = 0;
    double employerWithholding  = 0;
    double discountForPersonalExpenses = 0;
    double differentCapacityDeduction  = 0;
    double totalDeductions  = 0;

    CalculatorFormProvider calcFormPrvd = Provider.of<CalculatorFormProvider>(context);

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

                    debouncer.onValue = (value) async {
                      setState(() {
                        formValues['salary'] = value;
                        formValues['grossIncome'] =
                            '${Config.getGrossIncome(value)}';
                      });
                    };

                    final timer =
                        Timer.periodic(const Duration(milliseconds: 300), (_) {
                      debouncer.value = value;
                    });

                    Future.delayed(const Duration(milliseconds: 301))
                        .then((value) => timer.cancel());
                  },
                )),
            Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 6),
                child: CustomInput(
                  readOnly: true,
                  initialValue: formValues['grossIncome'],
                  labelText: 'Ingresos Brutos Anuales',
                  onChanged: (String value) {
                    print(value);

                    setState(() {
                      formValues['grossIncome'] = value;
                    });
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                      'Valor calculado automáticamente con respecto al Sueldo',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: DropdownButtonFormField<Object>(
                  value: formValues['sector'],
                  items: Config.sectors.map((value) {
                    return DropdownMenuItem(
                        value: value['value'], child: Text(value['label']));
                  }).toList(),
                  decoration: const InputDecoration(
                      labelText: '¿En qué Sector Trabajas?',
                      helperText: 'Escoge el sector en el que trabajas'),
                  onChanged: (Object? value) {
                    print(value);
                    setState(() {
                      formValues['sector'] = '$value';
                    });
                  }),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: DropdownButtonFormField<Object>(
                    value: formValues['differentCaps'],
                    items: Config.differentCapacities.map((value) {
                      return DropdownMenuItem(
                          value: value['value'], child: Text(value['label']));
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
            if (formValues['differentCaps'] != null &&
                formValues['differentCaps']!.isNotEmpty &&
                formValues['differentCaps']! == 'yes')
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: DropdownButtonFormField<Object>(
                      value: '${formValues['percentsDifferentCaps']}',
                      items: Config.percentsDifferentCaps.map((value) {
                        return DropdownMenuItem(
                            value: '${value['value']}',
                            child: Text(value['label']));
                      }).toList(),
                      decoration: const InputDecoration(
                          labelText: 'Rango de Capacidad Diferente',
                          helperText:
                              'Escoja el rango del Porcentaje de Capacidad Diferente que posee',
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

                    debouncer.onValue = (value) async {
                      setState(() {
                        formValues['personalExps'] = value;
                      });
                    };

                    final timer =
                        Timer.periodic(const Duration(milliseconds: 300), (_) {
                      debouncer.value = value;
                    });

                    Future.delayed(const Duration(milliseconds: 301))
                        .then((value) => timer.cancel());
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

                    personalContribution = Config.getPersonalContribution(
                        double.parse(formValues['grossIncome']!),
                        formValues['sector']!);
                    calcFormPrvd.personalContribution = personalContribution;                    

                    netIncome = Config.getNetIncome(
                        double.parse(formValues['grossIncome']!),
                        personalContribution);
                    calcFormPrvd.netIncome = netIncome;                    

                    differentCapacityDeduction = Config.getDifferentCapacityDeduction( int.parse( formValues['percentsDifferentCaps']!  ) );
                    calcFormPrvd.differentCapacityDeduction = differentCapacityDeduction;

                    totalDeductions = Config.getTotalDeductions(personalContribution, differentCapacityDeduction);
                    calcFormPrvd.totalDeductions = totalDeductions;

                    basicFraction = Config.getBasicFraction( netIncome );
                    calcFormPrvd.basicFraction = basicFraction;

                    surplusFraction = Config.getSurplusFraction( netIncome, basicFraction );
                    calcFormPrvd.surplusFraction = surplusFraction;

                    taxOnBasicFraction = Config.getTaxOnBasicFraction( netIncome );
                    calcFormPrvd.taxOnBasicFraction = taxOnBasicFraction;

                    taxOnSurplusFraction = Config.getTaxOnSurplusFraction( netIncome, surplusFraction );
                    calcFormPrvd.taxOnSurplusFraction = taxOnSurplusFraction;

                    totalTax = Config.getTotalTax( taxOnBasicFraction, taxOnSurplusFraction );
                    calcFormPrvd.totalTax = totalTax;

                    discountForPersonalExpenses = Config.getDiscountForPersonalExpenses( double.parse( formValues['personalExps']! )  );
                    calcFormPrvd.discountForPersonalExpenses = discountForPersonalExpenses;

                    totalTaxToPay = Config.getTotalTaxToPay(totalTax, discountForPersonalExpenses);
                    calcFormPrvd.totalTaxToPay = totalTaxToPay;

                    employerWithholding = Config.getEmployerWithholding( totalTaxToPay );
                    calcFormPrvd.employerWithholding = employerWithholding;
                    
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
            ),
            const _Results(),
            const SizedBox(height: 20),
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
    CalculatorFormProvider calcFormPrvd =
        Provider.of<CalculatorFormProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text('Aporte Personal IESS:', style: AppTheme.resultStyle),
              Expanded(child: Container()),
              Text('${calcFormPrvd.personalContribution.toStringAsFixed(2)} US\$',
                  style: AppTheme.resultStyle),
            ],
          ),          
          if ( calcFormPrvd.differentCapacityDeduction > 0 )
            Column(
                children: [
                  const SizedBox(height: 5),
                  Row(
                  children: [
                    Text('Deducción por Capacidad Diferente:', style: AppTheme.resultStyle),
                    Expanded(child: Container()),
                    Text('${calcFormPrvd.differentCapacityDeduction.toStringAsFixed(2)} US\$',
                        style: AppTheme.resultStyle),
                  ],
                ),    
                ],
            ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Total Deducciones:', style: AppTheme.resultStyle),
              Expanded(child: Container()),
              Text('${calcFormPrvd.totalDeductions.toStringAsFixed(2)} US\$', style: AppTheme.resultStyle),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Ingresos Netos:', style: AppTheme.resultStyle),
              Expanded(child: Container()),
              Text('${calcFormPrvd.netIncome.toStringAsFixed(2)} US\$', style: AppTheme.resultStyle),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Fracción Básica:', style: AppTheme.resultStyle),
              Expanded(child: Container()),
              Text('${calcFormPrvd.basicFraction.toStringAsFixed(2) } US\$',
                  style: AppTheme.resultStyle),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Fracción Excedente:', style: AppTheme.resultStyle),
              Expanded(child: Container()),
              Text('${calcFormPrvd.surplusFraction.toStringAsFixed(2)} US\$',
                  style: AppTheme.resultStyle),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Impuesto sobre FB:', style: AppTheme.resultStyle),
              Expanded(child: Container()),
              Text('${calcFormPrvd.taxOnBasicFraction.toStringAsFixed(2)} US\$',
                  style: AppTheme.resultStyle),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Impuesto sobre FE:', style: AppTheme.resultStyle),
              Expanded(child: Container()),
              Text('${calcFormPrvd.taxOnSurplusFraction.toStringAsFixed(2)} US\$',
                  style: AppTheme.resultStyle),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Impuesto calculado:', style: AppTheme.resultStyle),
              Expanded(child: Container()),
              Text('${ calcFormPrvd.totalTax.toStringAsFixed( 2 ) } US\$', style: AppTheme.resultStyle),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Rebaja por gastos personales:',
                  style: AppTheme.resultStyle),
              Expanded(child: Container()),
              Text('${ calcFormPrvd.discountForPersonalExpenses.toStringAsFixed( 2 ) } US\$', style: AppTheme.resultStyle),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('Impuesto anual a pagar:', style: AppTheme.resultStyle),
              Expanded(child: Container()),
              Text('${ calcFormPrvd.totalTaxToPay.toStringAsFixed( 2 ) } US\$', style: AppTheme.resultStyle),
            ],
          ),
          if ( calcFormPrvd.employerWithholding > 0 )
            Column(
              children: [
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text('Tu empleador te rentendrá mensualmente:', style: AppTheme.resultStyle),
                    Expanded(child: Container()),
                    Text('${ calcFormPrvd.employerWithholding.toStringAsFixed( 2 ) } US\$', style: AppTheme.resultStyle),
                  ],
                ),
              ],
            )
        ],
      ),
    );
  }
}
