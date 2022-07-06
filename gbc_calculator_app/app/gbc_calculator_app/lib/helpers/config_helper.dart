class Config {
  
  static double sevenBasicBaskets   = 5037.55; // 7* 719.65
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
    
    double parseValue = double.parse( valueTmp );    

    return parseValue * 12;
  }

  static List<Map<String, dynamic>> sectors = [
    { 'label': 'Público', 'value': 'public',  'percent' : 11.45 },
    { 'label': 'Privado', 'value': 'private', 'percent' : 9.45 },
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
    { 'basicFraction' : 0.0,       'excessUp' : 11310.0,        'taxOnBasicFraction' : 0.0,      'percentTaxOnSurplusFraction' : 0 },
    { 'basicFraction' : 11310.01,  'excessUp' : 14410.0,        'taxOnBasicFraction' : 0.0,      'percentTaxOnSurplusFraction' : 5 },
    { 'basicFraction' : 14410.01,  'excessUp' : 18010.0,        'taxOnBasicFraction' : 155.0,    'percentTaxOnSurplusFraction' : 10 },
    { 'basicFraction' : 18010.01,  'excessUp' : 21630.0,        'taxOnBasicFraction' : 515.0,    'percentTaxOnSurplusFraction' : 12 },
    { 'basicFraction' : 21630.01,  'excessUp' : 31630.0,        'taxOnBasicFraction' : 949.40,   'percentTaxOnSurplusFraction' : 15 },
    { 'basicFraction' : 31630.01,  'excessUp' : 41630.0,        'taxOnBasicFraction' : 2449.40,  'percentTaxOnSurplusFraction' : 20 },
    { 'basicFraction' : 41630.01,  'excessUp' : 51630.0,        'taxOnBasicFraction' : 4449.40,  'percentTaxOnSurplusFraction' : 25 },
    { 'basicFraction' : 51630.01,  'excessUp' : 61630.0,        'taxOnBasicFraction' : 6949.40,  'percentTaxOnSurplusFraction' : 30 },
    { 'basicFraction' : 61630.01,  'excessUp' : 100000.0,       'taxOnBasicFraction' : 9949.40,  'percentTaxOnSurplusFraction' : 35 },
    { 'basicFraction' : 100000.01, 'excessUp' : 999999999999.0, 'taxOnBasicFraction' : 23378.90, 'percentTaxOnSurplusFraction' : 37 },
  ];  

  static double getPersonalContribution ( double grossIncome, String sector ) {
    
    int indexSector = sectors.indexWhere((element) => element['value'] == sector );

    double percentContribution = sectors[ indexSector ][ 'percent' ];

    return double.parse( ( grossIncome * ( percentContribution / 100 ) ).toStringAsFixed(2) );

  }

  static double getNetIncome ( double grossIncome, double personalContribution) {    
    return grossIncome - personalContribution;
  }

  static double getBasicFraction ( double netIncome ) {
    double basicFraction = 0;
    for( final tableTax in tableTaxes ) {
      if ( netIncome >= tableTax['basicFraction'] && netIncome <= tableTax['excessUp']  ) {
        basicFraction = tableTax['basicFraction'];
        break;
      }
    }
    return basicFraction;
  }

  static double getSurplusFraction ( double netIncome, double basicFraction ) {
    return netIncome - basicFraction;
  }

  static double getTaxOnBasicFraction ( double netIncome ) {
    double taxOnBasicFraction = 0;

    for( final tableTax in tableTaxes ) {
      if ( netIncome >= tableTax['basicFraction'] && netIncome <= tableTax['excessUp']  ) {
        taxOnBasicFraction = tableTax['taxOnBasicFraction'];
        break;
      }
    }

    return taxOnBasicFraction;
  }

  static double getTaxOnSurplusFraction ( double netIncome, double surplusFraction ) {
    double taxOnSurplusFraction     = 0;
    int percentTaxOnSurplusFraction = 0;

    for( final tableTax in tableTaxes ) {
      if ( netIncome >= tableTax['basicFraction'] && netIncome <= tableTax['excessUp']  ) {
        percentTaxOnSurplusFraction = tableTax['percentTaxOnSurplusFraction'];
        break;
      }
    }

    taxOnSurplusFraction = surplusFraction * ( percentTaxOnSurplusFraction / 100 );

    return taxOnSurplusFraction;
  }

  static double getTotalTax( double taxOnBasicFraction, double taxOnSurplusFraction ) {
    return taxOnBasicFraction + taxOnSurplusFraction;
  }

  static double getDiscountForPersonalExpenses ( double personalExpenses) {    
    
    double percent = ( personalExpenses > baseToDiscountForPE ) ?  0.10 : 0.20;

    personalExpenses = ( personalExpenses > sevenBasicBaskets ) ? sevenBasicBaskets : personalExpenses;

    double discount = personalExpenses * percent;
    
    return discount;    

  }

  static double getTotalTaxToPay( double totalTax, double discount  ) {
    double totalTaxPay = totalTax - discount;

    return totalTaxPay < 0 ? 0.0 : totalTax;
  }
  
} 