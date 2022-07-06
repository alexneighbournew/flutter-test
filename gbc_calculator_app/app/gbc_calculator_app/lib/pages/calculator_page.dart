import 'package:flutter/material.dart';

import 'package:gbc_calculator_app/helpers/helpers.dart';
import 'package:gbc_calculator_app/themes/theme.dart';
import 'package:gbc_calculator_app/widgets/widgets.dart' show CustomInput;

class CalculatorPage extends StatelessWidget {

  const CalculatorPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text( 'Calculadora Tributaria' ),
        actions: [
          IconButton(
            onPressed: () => null,  // TODO: action to clear form.
            icon: const Icon( Icons.restore_outlined ),
            tooltip: 'Limpiar Formulario',            
          )
        ],
      ),
      body: SingleChildScrollView(

        child: Column(
          children: const [
            
            // form
            _Form(),

            // Results
            _Results(),

            SizedBox( height: 20 )

          ],
        ),


      )
    );
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

    return Form(
      key: myFormKey,
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 20 ),
            child: CustomInput( required: true, errorLabel: 'Ingrese un valor', 
              keyboardType: TextInputType.number, labelText: 'Salario Mensual', 
              helperText: 'Ingrese el sueldo mensual. Ej: 750.50', 
              formProperty: 'salary', formValues: formValues,
            )
          ),

          // TODO: cálculo de los ingresos brutos anuales
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 20 ),
            child: CustomInput( readOnly: true, initialValue: '1500', labelText: 'Ingresos Brutos Anuales',
              formProperty: 'grossIncome', formValues: formValues,
            )
          ),
                                
      
          const Text('Valor calculado automáticamente con respecto al Sueldo', ),
      
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 20 ),
            child: DropdownButtonFormField<Object>(                
              items: Config.sectors.map(( value) {
                return DropdownMenuItem( value: value['value'], child: Text( value['label']) );
              }).toList(),
              decoration: const InputDecoration(
                labelText: '¿En qué Sector Trabajas?',
                helperText: 'Escoje el sector en el que trabajas'
              ),
              
              
              onChanged: ( Object? value ) {
                formValues['sector'] = value.toString();
              }
            ),
          ),
      
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 20 ),
            child: DropdownButtonFormField<Object>(                
              items: Config.differentCapacities.map(( value) {
                return DropdownMenuItem(                   
                  value: value['value'],
                  child: Text( value['label'])
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: '¿Tienes Capacidades Diferentes?',
                helperText: 'Cuéntanos si tienes una capacidad diferente'
              ),
              onChanged: ( Object? value ) {
                formValues['differentCaps'] = value.toString();
              }
            )
          ),

          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 20 ),
            child: CustomInput( required: true, errorLabel: 'Ingrese un valor', 
              keyboardType: TextInputType.number, labelText: 'Gastos Personales', 
              helperText: 'Coloca una cifra aproximada de tus gastos personales para el 2022. Podrás utilizar un máximo de 7 canastas básicas** \$5,037.55', 
              helperMaxLines: 3,
              formProperty: 'personalExps', formValues: formValues,
            )
          ),

          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 20 ),
            child: OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppTheme.colorPrimary ),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder( 
                    borderRadius: BorderRadius.all( Radius.circular( 8 ) )
                  )
                )

              ),
              onPressed: () {
                
                FocusManager.instance.primaryFocus?.unfocus(); // keyboard hide

                if ( !myFormKey.currentState!.validate()) {
                  print('Formulario no válido');
                  return;
                }

                // print form values
                print( formValues );
              }, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [

                  Text('Calcular', style: TextStyle( color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 1.6 ),),

                  SizedBox( width: 6 ),

                  Icon( Icons.calculate, color: Colors.white, )
                ]
              )
            ),
          )
          
        ],
      )
    );
  }
}

class _Results extends StatelessWidget {
  const _Results({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 10 ),
      child: Column(
    
        children: [
          
          Row(
            children: [
    
              Text('Impuesto calculado:', style: AppTheme.resultStyle),

              Expanded(child: Container() ),
    
              Text('\$ 0.00', style: AppTheme.resultStyle),
    
            ],
          ),

          const SizedBox( height: 5),

          Row(
            children: [
    
              Text('Rebaja por gastos personales:', style: AppTheme.resultStyle),

              Expanded(child: Container() ),
    
              Text('\$ 0.00', style: AppTheme.resultStyle),
    
            ],
          ),

          const SizedBox( height: 5),

          Row(
            children: [
    
              Text('Impuesto anual a pagar:', style: AppTheme.resultStyle),

              Expanded(child: Container() ),
    
              Text('\$ 0.00', style: AppTheme.resultStyle),
    
            ],
          )

        ],
      ),
    );
  }
}