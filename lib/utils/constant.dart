import 'package:flutter/material.dart';
import 'package:units_converter/units_converter.dart';


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
const String numberBaseConverterPage = 'number_base_converter_page';
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
const String premiumPage = 'premium_page';


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
const Map<String, dynamic> AngleUnitsList = {
  'degree': ANGLE.degree,
  'minutes': ANGLE.minutes,
  'seconds': ANGLE.seconds,
  'radians': ANGLE.radians,
};
//All Area Unit
const Map<String, dynamic> AreaUnitsList = {
  'are': AREA.are,
  'acres': AREA.acres,
  'hectares': AREA.hectares,
  'square_kilometers': AREA.square_kilometers,
  'square_millimeters': AREA.square_millimeters,
  'square_yard': AREA.square_yard,
  'square_miles': AREA.square_miles,
  'square_feet': AREA.square_feet,
  'square_inches': AREA.square_inches,
  'square_centimeters': AREA.square_centimeters,
  'square_meters': AREA.square_meters,
};
//All Energy Unit
const Map<String, dynamic> EnergyUnitsList = {
  'joules': ENERGY.joules,
  'calories': ENERGY.calories,
  'kilowatt_hours': ENERGY.kilowatt_hours,
  'electronvolts': ENERGY.electronvolts,
};
//All Force Unit
const Map<String, dynamic> ForceUnitsList = {
  'newton': FORCE.newton,
  'dyne': FORCE.dyne,
  'pound_force': FORCE.pound_force,
  'kilogram_force': FORCE.kilogram_force,
  'poundal': FORCE.poundal,
};
//All Length Unit
const Map<String, dynamic> LengthUnitsList = {
  'meters': LENGTH.meters,
  'centimeters': LENGTH.centimeters,
  'inches': LENGTH.inches,
  'feet': LENGTH.feet,
  'nautical_miles': LENGTH.nautical_miles,
  'yards': LENGTH.yards,
  'miles': LENGTH.miles,
  'millimeters': LENGTH.millimeters,
  'micrometers': LENGTH.micrometers,
  'nanometers': LENGTH.nanometers,
  'angstroms': LENGTH.angstroms,
  'picometers': LENGTH.picometers,
  'kilometers': LENGTH.kilometers,
  'astronomical_units': LENGTH.astronomical_units,
  'light_years': LENGTH.light_years,
  'parsec': LENGTH.parsec,
};
//All Number Base Unit
const Map<String, dynamic> NumberBaseUnitsList = {
  'decimal': NUMERAL_SYSTEMS.decimal,
  'hexadecimal': NUMERAL_SYSTEMS.hexadecimal,
  'octal': NUMERAL_SYSTEMS.octal,
  'binary': NUMERAL_SYSTEMS.binary,
};
//All Power Unit
const Map<String, dynamic> PowerUnitsList = {
  'watt': POWER.watt,
  'milliwatt': POWER.milliwatt,
  'kilowatt': POWER.kilowatt,
  'megawatt': POWER.megawatt,
  'gigawatt': POWER.gigawatt,
  'european_horse_power': POWER.european_horse_power,
  'imperial_horse_power': POWER.imperial_horse_power,
};
//All Pressure Unit
const Map<String, dynamic> PressureUnitsList = {
  'pascal': PRESSURE.pascal,
  'atmosphere': PRESSURE.atmosphere,
  'bar': PRESSURE.bar,
  'millibar': PRESSURE.millibar,
  'psi': PRESSURE.psi,
  'torr': PRESSURE.torr,
};
//All Speed Unit
const Map<String, dynamic> SpeedUnitsList = {
  'meters_per_second': SPEED.meters_per_second,
  'kilometers_per_hour': SPEED.kilometers_per_hour,
  'miles_per_hour': SPEED.miles_per_hour,
  'knots': SPEED.knots,
  'feets_per_second': SPEED.feets_per_second,
};
//All Temperature Unit
const Map<String, dynamic> TemperatureUnitsList = {
  'fahrenheit': TEMPERATURE.fahrenheit,
  'celsius': TEMPERATURE.celsius,
  'kelvin': TEMPERATURE.kelvin,
  'reamur': TEMPERATURE.reamur,
  'romer': TEMPERATURE.romer,
  'delisle': TEMPERATURE.delisle,
  'rankine': TEMPERATURE.rankine,
};
//All Storage Unit
const Map<String, dynamic> StorageUnitsList = {
  'bit': DIGITAL_DATA.bit,
  'kilobit': DIGITAL_DATA.kilobit,
  'megabit': DIGITAL_DATA.megabit,
  'gigabit': DIGITAL_DATA.gigabit,
  'terabit': DIGITAL_DATA.terabit,
  'petabit': DIGITAL_DATA.petabit,
  'exabit': DIGITAL_DATA.exabit,
  'kibibit': DIGITAL_DATA.kibibit,
  'mebibit': DIGITAL_DATA.mebibit,
  'gibibit': DIGITAL_DATA.gibibit,
  'tebibit': DIGITAL_DATA.tebibit,
  'pebibit': DIGITAL_DATA.pebibit,
  'exbibit': DIGITAL_DATA.exbibit,
  'byte': DIGITAL_DATA.byte,
  'kilobyte': DIGITAL_DATA.kilobyte,
  'megabyte': DIGITAL_DATA.megabyte,
  'gigabyte': DIGITAL_DATA.gigabyte,
  'terabyte': DIGITAL_DATA.terabyte,
  'petabyte': DIGITAL_DATA.petabyte,
  'exabyte': DIGITAL_DATA.exabyte,
  'kibibyte': DIGITAL_DATA.kibibyte,
  'mebibyte': DIGITAL_DATA.mebibyte,
  'gibibyte': DIGITAL_DATA.gibibyte,
  'tebibyte': DIGITAL_DATA.tebibyte,
  'pebibyte': DIGITAL_DATA.pebibyte,
  'exbibyte': DIGITAL_DATA.exbibyte,
};
//All Time Unit
const Map<String, dynamic> TimeUnitsList = {
  'seconds': TIME.seconds,
  'deciseconds': TIME.deciseconds,
  'centiseconds': TIME.centiseconds,
  'milliseconds': TIME.milliseconds,
  'microseconds': TIME.microseconds,
  'nanoseconds': TIME.nanoseconds,
  'minutes': TIME.minutes,
  'hours': TIME.hours,
  'days': TIME.days,
  'weeks': TIME.weeks,
  'years_365': TIME.years_365,
  'lustrum': TIME.lustrum,
  'decades': TIME.decades,
  'centuries': TIME.centuries,
  'millennium': TIME.millennium,
};
//All Volume Unit
const Map<String, dynamic> VolumeUnitsList = {
  'seconds': VOLUME.cubic_meters,
  'liters': VOLUME.liters,
  'imperial_gallons': VOLUME.imperial_gallons,
  'us_gallons': VOLUME.us_gallons,
  'imperial_pints': VOLUME.imperial_pints,
  'us_pints': VOLUME.us_pints,
  'milliliters': VOLUME.milliliters,
  'tablespoons_us': VOLUME.tablespoons_us,
  'australian_tablespoons': VOLUME.australian_tablespoons,
  'cups': VOLUME.cups,
  'cubic_centimeters': VOLUME.cubic_centimeters,
  'cubic_feet': VOLUME.cubic_feet,
  'cubic_inches': VOLUME.cubic_inches,
  'cubic_millimeters': VOLUME.cubic_millimeters,
  'imperial_fluid_ounces': VOLUME.imperial_fluid_ounces,
  'us_fluid_ounces': VOLUME.us_fluid_ounces,
  'imperial_gill': VOLUME.imperial_gill,
  'us_gill': VOLUME.us_gill,
};
//All Weight Unit
const Map<String, dynamic> WeightUnitsList = {
  'grams': MASS.grams,
  'ettograms': MASS.ettograms,
  'kilograms': MASS.kilograms,
  'pounds': MASS.pounds,
  'ounces': MASS.ounces,
  'quintals': MASS.quintals,
  'tons': MASS.tons,
  'milligrams': MASS.milligrams,
  'uma': MASS.uma,
  'carats': MASS.carats,
  'centigrams': MASS.centigrams,
  'pennyweights': MASS.pennyweights,
  'troy_ounces': MASS.troy_ounces,
  'stones': MASS.stones,
};
//All FuelConsumption Unit
const Map<String, dynamic> FuelUnitsList = {
  'kilometers_per_liter': FUEL_CONSUMPTION.kilometers_per_liter,
  'liters_per_100_km': FUEL_CONSUMPTION.liters_per_100_km,
  'miles_per_US_gallon': FUEL_CONSUMPTION.miles_per_US_gallon,
  'miles_per_imperial_gallon': FUEL_CONSUMPTION.miles_per_imperial_gallon,
};
//All Torque Unit
const Map<String, dynamic> TorqueUnitsList = {
  'newton_meter': TORQUE.newton_meter,
  'dyne_meter': TORQUE.dyne_meter,
  'pound_force_feet': TORQUE.pound_force_feet,
  'kilogram_force_meter': TORQUE.kilogram_force_meter,
  'poundal_meter': TORQUE.poundal_meter,
};
//All ShoeSize Unit
const Map<String, dynamic> ShoeSizeUnitsList = {
  'centimeters': SHOE_SIZE.centimeters,
  'inches': SHOE_SIZE.inches,
  'eu_china': SHOE_SIZE.eu_china,
  'uk_india_child': SHOE_SIZE.uk_india_child,
  'uk_india_man': SHOE_SIZE.uk_india_man,
  'uk_india_woman': SHOE_SIZE.uk_india_woman,
  'usa_canada_child': SHOE_SIZE.usa_canada_child,
  'usa_canada_man': SHOE_SIZE.usa_canada_man,
  'usa_canada_woman': SHOE_SIZE.usa_canada_woman,
  'japan': SHOE_SIZE.japan,
};
