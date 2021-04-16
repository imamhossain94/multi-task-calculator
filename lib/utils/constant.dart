import 'package:flutter/material.dart';

const String appName = 'Multi-Task Calculator';
const String appNameNewLine = 'Multi-Task\nCalculator';
const String appNameNoSpace = 'MultiTaskCalculator';
const String appVersion = 'app_version';

const String developerName = 'Md. Imam Hossain';
const String designerName = 'Md. Imam Hossain';

const String feedbackMail = 'mailto:haldercalvin00@gmail.com';
const String contactMail = 'mailto:haldercalvin00@gmail.com';

const String appId = '';
const String bannerAdUnitId = 'ca-app-pub-3940256099942544/1033173712';
const String interstitialAsUnitId = 'ca-app-pub-3940256099942544/1033173712';
const String appStoreIdentifier = 'com.myairtelapp';

const String appLink =
    'https://play.google.com/store/apps/details?id=com.myairtelapp';
const String storeLink =
    'https://play.google.com/store/apps/dev?id=5602309161373665584&hl=it&gl=US';

const String loanAppLink =
    'https://play.google.com/store/apps/details?id=com.myairtelapp';

const String appIconLight = 'assets/images/ic_launcher_light.png';

const String fontAudioWide = 'Audiowide';

//Route
const String splashPage = 'splash_page';
const String homePage = 'home_page';
const String helpPage = 'help_page';
const String aboutPage = 'about_page';
const String feedbackPage = 'feedback_page';
const String updateCheckPage = 'update_check_page';

const String generalCalcPage = 'general_calc_page';
const String currencyCalcPage = 'currency_calc_page';
const String unitConverterPage = 'unit_converter_page';
const String unitConverterChildPage = 'unit_converter_child_page';
const String discountCalcPage = 'discount_calc_page';
const String tipCalcPage = 'tip_calc_page';
const String dateCalcPage = 'date_calc_page';
const String fuelEfficiencyCalcPage = 'fuel_efficiency_calc_page';
const String fuelCalcPage = 'fuel_calc_page';
const String healthCalcPage = 'health_calc_page';
const String loanCalcPage = 'loan_calc_page';
const String salesTaxCalcPage = 'sales_tax_calc_page';
const String savingCalcPage = 'saving_calc_page';
const String unitPriceCalcPage = 'unit_calc_page';




const String appTheme = "Theme";
const String dark = "Dark";
const String light = "Light";
const String systemDefault = "System default";
const List<String> themes = ["System default", "Light", "Dark"];

const backgroundLight = Color(0xffFAFAFA);
Color backgroundDark = Color(0xff212121);
const textWhite = Colors.white;
const textBlack = Colors.black;
const textBlue = Color(0xff2962FF);
const textYellow = Color(0xFFFFCF18);
const textGreen = Color(0xFF2EC4B6);
const textRed = Color(0xFFFF3030);
const textMaroon = Color(0xFFB42807);
const textAmber = Colors.amber;
const textOrange = Colors.orange;

//App Feature Max 6
const List<String> appFeature = [
  "The app can save your calculation history.",
  "The app can generate amortization schedule pdf.",
  "The app can save your calculation history.",
  // "The app can generate amortization schedule pdf.",
  // "The app can generate amortization schedule pdf.",
  // "The app can generate amortization schedule pdf.",
];

//App Help Note: Question must be unique
const Map<String, String> appHelp = {
  //Q-1
  "How to Calculate mortgage payment?":
      "Try our mortgage calculator app to see how to calculate mortgage payment",

  //Q-2
  "What Does Home Value Means?":
      "Try our mortgage calculator app to see how to calculate mortgage payment",

  //Q-3
  "Definition of Down Payment?":
      "Try our mortgage calculator app to see how to calculate mortgage payment",

  //Q-4
  "What is Loan?":
      "Try our mortgage calculator app to see how to calculate mortgage payment",

  //Q-5
  "What Is an Interest rate?":
      "Try our mortgage calculator app to see how to calculate mortgage payment",
};


const Map<String, String> currencyCodeList = {
  "AED":"UAEDirham","AFN":"Afghani","ALL":"Lek","AMD":"ArmenianDram","ANG":"NetherlandsAntilleanGuilder","AOA":"Kwanza","ARS":"ArgentinePeso","AUD":"AustralianDollar","AWG":"ArubanFlorin","AZN":"AzerbaijanManat","BAM":"ConvertibleMark","BBD":"BarbadosDollar","BDT":"Taka","BGN":"BulgarianLev","BHD":"BahrainiDinar","BIF":"BurundiFranc","BMD":"BermudianDollar","BND":"BruneiDollar","BOB":"Boliviano","BOV":"Mvdol","BRL":"BrazilianReal","BSD":"BahamianDollar","BTN":"Ngultrum","BWP":"Pula","BYN":"BelarusianRuble","BZD":"BelizeDollar","CAD":"CanadianDollar","CDF":"CongoleseFranc","CHF":"SwissFranc","CLP":"ChileanPeso","CNY":"YuanRenminbi","COP":"ColombianPeso","CRC":"CostaRicanColon","CUC":"PesoConvertible","CUP":"CubanPeso","CVE":"CaboVerdeEscudo","CZK":"CzechKoruna","DJF":"DjiboutiFranc","DKK":"DanishKrone","DOP":"DominicanPeso","DZD":"AlgerianDinar","EGP":"EgyptianPound","ERN":"Nakfa","ETB":"EthiopianBirr","EUR":"Euro","FJD":"FijiDollar","FKP":"FalklandIslandsPound","GBP":"PoundSterling","GEL":"Lari","GHS":"GhanaCedi","GIP":"GibraltarPound","GMD":"Dalasi","GNF":"GuineanFranc","GTQ":"Quetzal","GYD":"GuyanaDollar","HKD":"HongKongDollar","HNL":"Lempira","HRK":"Kuna","HTG":"Gourde","HUF":"Forint","IDR":"Rupiah","ILS":"NewIsraeliSheqel","INR":"IndianRupee","IQD":"IraqiDinar","IRR":"IranianRial","ISK":"IcelandKrona","JMD":"JamaicanDollar","JOD":"JordanianDinar","JPY":"Yen","KES":"KenyanShilling","KGS":"Som","KHR":"Riel","KMF":"ComorianFranc","KPW":"NorthKoreanWon","KRW":"Won","KWD":"KuwaitiDinar","KYD":"CaymanIslandsDollar","KZT":"Tenge","LAK":"LaoKip","LBP":"LebanesePound","LKR":"SriLankaRupee","LRD":"LiberianDollar","LSL":"Loti","LYD":"LibyanDinar","MAD":"MoroccanDirham","MDL":"MoldovanLeu","MGA":"MalagasyAriary","MKD":"Denar","MMK":"Kyat","MNT":"Tugrik","MOP":"Pataca","MRU":"Ouguiya","MUR":"MauritiusRupee","MVR":"Rufiyaa","MWK":"MalawiKwacha","MXN":"MexicanPeso","MYR":"MalaysianRinggit","MZN":"MozambiqueMetical","NAD":"NamibiaDollar","NGN":"Naira","NIO":"CordobaOro","NOK":"NorwegianKrone","NPR":"NepaleseRupee","NZD":"NewZealandDollar","OMR":"RialOmani","PAB":"Balboa","PEN":"Sol","PGK":"Kina","PHP":"PhilippinePeso","PKR":"PakistanRupee","PLN":"Zloty","PYG":"Guarani","QAR":"QatariRial","RON":"RomanianLeu","RSD":"SerbianDinar","RUB":"RussianRuble","RWF":"RwandaFranc","SAR":"SaudiRiyal","SBD":"SolomonIslandsDollar","SCR":"SeychellesRupee","SDG":"SudanesePound","SEK":"SwedishKrona","SGD":"SingaporeDollar","SHP":"SaintHelenaPound","SLL":"Leone","SOS":"SomaliShilling","SRD":"SurinamDollar","SSP":"SouthSudanesePound","STN":"Dobra","SYP":"SyrianPound","SZL":"Lilangeni","THB":"Baht","TJS":"Somoni","TMT":"TurkmenistanNewManat","TND":"TunisianDinar","TOP":"Pa’anga","TRY":"TurkishLira","TTD":"TrinidadandTobagoDollar","TWD":"NewTaiwanDollar","TZS":"TanzanianShilling","UAH":"Hryvnia","UGX":"UgandaShilling","USD":"USDollar","UYU":"PesoUruguayo","UZS":"UzbekistanSum","VES":"BolívarSoberano","VND":"Dong","VUV":"Vatu","WST":"Tala","XAF":"CFAFrancBEAC","XCD":"EastCaribbeanDollar","XDR":"SDR(SpecialDrawingRight)","XOF":"CFAFrancBCEAO","XPF":"CFPFranc","YER":"YemeniRial","ZAR":"Rand","ZMW":"ZambianKwacha",
};

//All Angle Unit
const Map<String, String> AngleUnitsList = {
  "second":"arcs","minute":"arcm","degree":"deg","radian":"rad",
};

//All Area Unit
const Map<String, String> AreaUnitsList = {
  "acre":"acre","squareCentimeter":"cm²","hectare":"ha","squareFoot":"ft²","squareInch":"inch²","squareKilometer":"km²","squareMeter":"m²","squareMicrometer":"μm²","squareMile":"mile²","squareMillimeter":"mm²","squareNanometer":"nm²","squareYard":"yd²",
};

//All Energy Unit
const Map<String, String> EnergyUnitsList = {
  "attojoule":"aJ","calorie":"cal","electronVolt":"eV","femtojoule":"fJ","gigajoule":"GJ","gigawattHour":"GWh","kilocalorie":"kcal","kiloelectronVolt":"keV","kilojoule":"kJ","kiloton":"kt","kilowattHour":"KWh","megaelectronVolt":"meV","joule":"j","megawattHour":"MWh","microjoule":"µJ","millijoule":"mJ","picojoule":"pJ","ton":"t","wattHour":"Wh",
};

//All Force Unit
const Map<String, String> ForceUnitsList = {
  "attonewton":"aN","centinewton":"cN","decinewton":"dN","dekanewton":"daN","exanewton":"EN","femtonewton":"fN","giganewton":"GN","gramForce":"gf","hectonewton":"hN","kilogramForce":"kgf","kilonewton":"kN","kipForce":"klbf","meganewton":"MN","micronewton":"µN","millinewton":"mN","nanonewton":"nN","newton":"N","ounceForce":"ozf","petanewton":"PN","piconewton":"pN","poundForce":"lbf","teranewton":"TN","tonForce":"tfN",
};

//All Length Unit
const Map<String, String> LengthUnitsList = {
  "centimeter":"cm","foot":"ft","inch":"in","kilometer":"km","meter":"m","micrometer":"µm","mile":"mi","millimeter":"mm","nanometer":"nm","nauticalMile":"nmi","yard":"yd",
};

//All Number Base Unit
const Map<String, String> NumberBaseUnitsList = {
  "binary":"b","decimal":"d","hexadecimal":"h","octal":"o",
};

//All Power Unit
const Map<String, String> PowerUnitsList = {
  "attowatt":"aW","centiwatt":"cW","deciwatt":"dW","dekawatt":"daW","exawatt":"EW","femtowatt":"fW","gigawatt":"GW","hectowatt":"hW","kilowatt":"kW","megawatt":"MW","milliwatt":"mW","petawatt":"PW","picowatt":"pW","terawatt":"TW","watt":"W",
};

//All Pressure Unit
const Map<String, String> PressureUnitsList = {
  "centipascal":"cPa","dekapascal":"daPa","gigapascal":"GPa","hectopascal":"hPa","kilopascal":"kPa","megapascal":"MPa","microbar":"µbar","micropascal":"µPa","millibar":"millibar","millipascal":"mPa","pascal":"Pa","psi":"psi","torr":"torr",
};

//All Speed Unit
const Map<String, String> SpeedUnitsList = {
  "beaufort":"beaufort","centimeterPerHour":"cm/h","centimeterPerMinute":"cm/m","centimeterPerSecond":"cm/s","footPerHour":"ft/h","footPerMinute":"ft/m","footPerSecond":"ft/s","kilometerPerHour":"km/h","kilometerPerMinute":"km/m","kilometerPerSecond":"km/s","knot":"knot","mach":"Ma","meterPerHour":"m/h","meterPerMinute":"m/m","meterPerSecond":"m/s","milePerHour":"mi/h","milePerMinute":"mi/m","milePerSecond":"mi/s","yardPerMinute":"yd/m","yardPerSecond":"yd/s",
};

//All Storage Unit
const Map<String, String> StorageUnitsList = {
  "bit":"bit","byte":"byte","cd74Minute":"char","cd80Minute":"char","character":"char","dvd":"dvd","exabit":"Ebit","exabyte":"Ebyte","gigabit":"Gb","gigabyte":"GB","kilobit":"kb","kilobyte":"kB","megabit":"Mb","megabyte":"MB","nibble":"nibble","petabit":"Pbit","petabyte":"PB","terabit":"Tb","terabyte":"TB","word":"word",
};

//All Temperature Unit
const Map<String, String> TemperatureUnitsList = {
  "celsius":"°C","fahrenheit":"°F","kelvin":"°K",
};

//All Time Unit
const Map<String, String> TimeUnitsList = {
  "second":"s","day":"d","microsecond":"μs","minute":"min","hour":"h","year":"y","month":"M","century":"C","decade":"dec","millisecond":"ms","nanosecond":"ns","picosecond":"ps","week":"w",
};

//All Volume Unit
const Map<String, String> VolumeUnitsList = {
  "attoliter":"aL","barrelOil":"barrel","barrelUK":"barrel-uk","barrelUS":"barrel-us","centiliter":"cL","cubicCentimeter":"cm³","cubicFoot":"ft³","cubicInch":"inc³","cubicKilometer":"km³","cubicMeter":"m³","cubicMile":"mi³","cubicMillimeter":"mm³","cubicYard":"yd³","deciliter":"dl","dekaliter":"dal","exaliter":"El","femtoliter":"fl","gallonUS":"gal-us","gigaliter":"Gl","hectoliter":"hl","kiloliter":"kl","liter":"L","megaliter":"Ml","microliter":"μl","milliliter":"ml","nanoliter":"nl","petaliter":"Pl","picoliter":"pl","teraliter":"Tl",
};

//All Weight Unit
const Map<String, String> WeightUnitsList = {
  "attogram":"ag","tonUK":"ton-uk","ton":"ton","carat":"carat","centigram":"cg","decigram":"dg","dekagram":"dag","exagram":"Eg","femtogram":"fg","gigagram":"Gg","gram":"g","hectogram":"hg","kilogram":"kg","kiloton":"kt","megagram":"Mg","microgram":"μg","milligram":"mg","nanogram":"ng","ounce":"oz","petagram":"Pg","picogram":"pg","pound":"lb","poundal":"pdl","quintal":"q","teragram":"Tg","tonUS":"ton-us",
};
