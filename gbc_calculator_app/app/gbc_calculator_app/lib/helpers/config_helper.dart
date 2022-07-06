class Config {

  // TODO: revisar si estas son las 7 canastas básicas
  static double sevenBasicBaskets   = 4981.76; // 7*711.68 o * 719.65
  static double baseToDiscountForPE = 24090; // 2.13*11310

  static Map<String, String> formValues = {
    'salary'        : '',
    'grossIncome'   : '',
    'sector'        : 'public',
    'differentCaps' : 'no',
    'percentsDifferentCaps' : '0',
    'personalExps'  : '',
  };

  static double getGrossIncome( String? value ) {
    String valueTmp = value ?? '';

    if (valueTmp.isEmpty) return 0;
    
    double? parseValue = double.tryParse( valueTmp );

    double result = parseValue ?? 0;

    return result * 12;
  }

  static List<Map<String, dynamic>> sectors = [
    { 'label': 'Público', 'value': 'public',  'percentage' : 9.45 },
    { 'label': 'Privado', 'value': 'private', 'percentage' : 11.45 },
  ];

  static List<Map<String, dynamic>> differentCapacities = [
    { 'label': 'Sí', 'value': 'yes' },
    { 'label': 'No', 'value': 'no' },
  ];
  
  static List<Map<String, dynamic>> percentsDifferentCaps = [
    { 'label': 'Menos del 30%',  'value': 0 },
    { 'label': 'Del 30 al 49%',  'value': 60 },
    { 'label': 'Del 50 al 74%',  'value': 70 },
    { 'label': 'Del 75 al 84%',  'value': 80 },
    { 'label': 'Del 85 al 100%', 'value': 100 },
  ];

  static List<Map<String, dynamic>> tableTaxes = [
    { 'basicFraction' : 0,         'excessUp' : 11310,        'taxOnBasicFraction' : 0,        'percentageTaxOnSurplusFraction' : 0 },
    { 'basicFraction' : 11310.01,  'excessUp' : 14410,        'taxOnBasicFraction' : 0,        'percentageTaxOnSurplusFraction' : 5 },
    { 'basicFraction' : 14410.01,  'excessUp' : 18010,        'taxOnBasicFraction' : 155,      'percentageTaxOnSurplusFraction' : 10 },
    { 'basicFraction' : 18010.01,  'excessUp' : 21630,        'taxOnBasicFraction' : 515,      'percentageTaxOnSurplusFraction' : 12 },
    { 'basicFraction' : 21630.01,  'excessUp' : 31630,        'taxOnBasicFraction' : 949.40,   'percentageTaxOnSurplusFraction' : 15 },
    { 'basicFraction' : 31630.01,  'excessUp' : 41630,        'taxOnBasicFraction' : 2449.40,  'percentageTaxOnSurplusFraction' : 20 },
    { 'basicFraction' : 41630.01,  'excessUp' : 51630,        'taxOnBasicFraction' : 4449.40,  'percentageTaxOnSurplusFraction' : 25 },
    { 'basicFraction' : 51630.01,  'excessUp' : 61630,        'taxOnBasicFraction' : 6949.40,  'percentageTaxOnSurplusFraction' : 30 },
    { 'basicFraction' : 61630.01,  'excessUp' : 100000,       'taxOnBasicFraction' : 9949.40,  'percentageTaxOnSurplusFraction' : 35 },
    { 'basicFraction' : 100000.01, 'excessUp' : 999999999999, 'taxOnBasicFraction' : 23378.90, 'percentageTaxOnSurplusFraction' : 37 },
  ];

  static getDiscountForPersonalExpenses ( double value) {    
    
    double percent = ( value > baseToDiscountForPE ) ?  0.10 : 0.20;

    value = ( value > sevenBasicBaskets ) ? sevenBasicBaskets : value;

    double discount = value * percent;
    
    return discount;    

  }
  
} 