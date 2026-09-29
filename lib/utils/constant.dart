
// ===========================================================================
// App identity
// ===========================================================================
const String appName = 'Multi-Task Calculator';
const String appNameNewLine = 'Multi-Task\nCalculator';
const String appNameNoSpace = 'MultiTaskCalculator';

const String developerName = 'Md. Imam Hossain';
const String designerName = 'Md. Imam Hossain';

const String feedbackMail = 'mailto:imamagun94@gmail.com';
const String contactMail = 'mailto:imamagun94@gmail.com';

const String appStoreIdentifier = 'com.newagedevs.multicalc';
const String appLink =
    'https://play.google.com/store/apps/details?id=com.newagedevs.multicalc';
const String storeLink =
    'https://play.google.com/store/apps/developer?id=NewAgeDevs';
const String loanAppLink =
    'https://play.google.com/store/apps/details?id=com.newagedevs.mortgage_calculator';
const String privacyPolicyLink =
    'https://play.google.com/store/apps/details?id=com.newagedevs.multicalc';

const String appIconLight = 'assets/images/ic_launcher_light.png';
const String fontAudioWide = 'Audiowide';

// ===========================================================================
// AdMob
//
// AdMob *app* and *unit* ids are public identifiers that ship inside every
// published APK/AAB — they are not secrets. They are still overridable at
// build time so a fork can switch to the official Google test ids without
// touching the source:
//
//   flutter build apk --dart-define=ADMOB_APP_ID=... --dart-define=ADMOB_BANNER_ID=...
// ===========================================================================
const String _admobAppId = String.fromEnvironment(
  'ADMOB_APP_ID',
  defaultValue: 'ca-app-pub-4061500537427923~1513034907',
);
const String _admobBannerId = String.fromEnvironment(
  'ADMOB_BANNER_ID',
  defaultValue: 'ca-app-pub-4061500537427923/1659857645',
);
const String _admobInterstitialId = String.fromEnvironment(
  'ADMOB_INTERSTITIAL_ID',
  defaultValue: 'ca-app-pub-4061500537427923/7088795214',
);

const String idMobAppId = _admobAppId;
const String idMobBanner = _admobBannerId;
const String idMobInterstitial = _admobInterstitialId;

// Google's official *test* ad ids, used automatically in debug builds.
const String testAdApp = 'ca-app-pub-3940256099942544~3347511713';
const String testAdBanner = 'ca-app-pub-3940256099942544/6300978111';
const String testInterstitial = 'ca-app-pub-3940256099942544/1033173712';

/// Number of taps between two interstitials.
const int interstitialTapInterval = 5;

/// Seconds of ad-free time granted by the reward flow.
const int rewardTime = 300;

// ===========================================================================
// Routes
// ===========================================================================
const String homePage = 'home_page';
const String helpPage = 'help_page';
const String aboutPage = 'about_page';
const String feedbackPage = 'feedback_page';
const String updateCheckPage = 'update_check_page';
const String historyPage = 'history_page';
const String premiumPage = 'premium_page';

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

// ===========================================================================
// Theme
// ===========================================================================
const String appTheme = 'Theme';
const String dark = 'Dark';
const String light = 'Light';
const String systemDefault = 'System default';
const List<String> themes = <String>[systemDefault, light, dark];

// ===========================================================================
// Shared preferences keys
// ===========================================================================
const String appVersionKey = 'app_version';
const String appPurchasedStatusKey = 'app_purchase_status';
const String adFreeTimeKey = 'ad_free_time';
const String itemClickKey = 'itemClick';
const String historyKey = 'calculation_history';
const String lastUpdateCheckKey = 'last_update_check';

// ===========================================================================
// App update check
//
// The app no longer depends on Firebase. Point this at any HTTPS endpoint that
// returns a small JSON document:
//
//   { "version": "1.3.0", "forceUpdate": false, "notes": "Bug fixes" }
//
// It is intentionally overridable so the repo can stay public with no
// project-specific URLs baked in.
// ===========================================================================
const String updateManifestUrl = String.fromEnvironment(
  'UPDATE_MANIFEST_URL',
  defaultValue: 'https://raw.githubusercontent.com/imamhossain94/'
      'multi-task-calculator/main/version.json',
);

// ===========================================================================
// Content
// ===========================================================================

/// Shown on the About screen. Keep the list short and specific.
const List<String> appFeature = <String>[
  'Works fully offline — no account, no sign-in, no data collection.',
  'Saves every calculation so you can look it up later.',
  '16 purpose-built calculators and 17 unit-conversion categories.',
  'Light, dark and system themes with a custom font.',
];

const Map<String, String> appHelp = <String, String>{
  'What is a General Calculator?':
      'The general calculator evaluates full expressions with + − × ÷, powers, '
      'percentages and brackets. Press the ⋯ key for scientific functions.',
  'How is the BMI calculated?':
      'BMI = weight (kg) ÷ height² (m). Below 18.5 is underweight, 18.5–24.9 is '
      'healthy, 25–29.9 is overweight and 30+ is obese. It is a rough screen, '
      'not a diagnosis.',
  'What is BMR?':
      'Basal Metabolic Rate is the energy your body uses at rest, using the '
      'Mifflin–St Jeor equation. Multiply it by your activity level to estimate '
      'your daily calorie needs.',
  'How is the Loan / Mortgage payment calculated?':
      'The monthly payment uses the standard amortisation formula '
      'P × r(1+r)ⁿ / ((1+r)ⁿ − 1) where r is the monthly interest rate and n is '
      'the number of months. Switch to "Maximum Loan" to work backwards from a '
      'monthly budget instead.',
  'How does the Savings calculator work?':
      'It compounds daily at your annual rate and adds your contribution on the '
      'interval you pick (weekly, bi-weekly, monthly, quarterly, annually).',
  'How is the Tip split between people?':
      'Final amount = bill + tax + tip, split evenly across the number of '
      'people. Tap the dollar or percent chip to switch the tip and tax inputs '
      'between an amount and a percentage.',
  'Why is my Fuel Efficiency result 0?':
      'Fuel efficiency needs both a non-zero amount of fuel and a distance '
      'greater than the starting odometer reading. Results are blanked until '
      'both are provided.',
  'How does the Date calculator split the difference?':
      'It uses a calendar-aware breakdown, so 1 Mar → 1 Mar next year is exactly '
      '1 year rather than 365 days. Tap the ⇄ chip to swap the two dates.',
  'Where do the exchange rates come from?':
      'Live rates are fetched from exchangerate-api.com and refreshed on open. '
      'Use the ⇄ chip to swap the two currencies instantly.',
};

const Map<String, String> currencyCodeList = <String, String>{
  'AED': 'UAEDirham', 'AFN': 'Afghani', 'ALL': 'Lek', 'AMD': 'ArmenianDram',
  'ANG': 'NetherlandsAntilleanGuilder', 'AOA': 'Kwanza', 'ARS': 'ArgentinePeso',
  'AUD': 'AustralianDollar', 'AWG': 'ArubanFlorin', 'AZN': 'AzerbaijanManat',
  'BAM': 'ConvertibleMark', 'BBD': 'BarbadosDollar', 'BDT': 'Taka',
  'BGN': 'BulgarianLev', 'BHD': 'BahrainiDinar', 'BIF': 'BurundiFranc',
  'BMD': 'BermudianDollar', 'BND': 'BruneiDollar', 'BOB': 'Boliviano',
  'BOP': 'BolivianoMvdol', 'BRL': 'BrazilianReal', 'BSD': 'BahamianDollar',
  'BTN': 'Ngultrum', 'BWP': 'Pula', 'BYN': 'BelarusianRuble',
  'BZD': 'BelizeDollar', 'CAD': 'CanadianDollar', 'CDF': 'CongoleseFranc',
  'CHF': 'SwissFranc', 'CLP': 'ChileanPeso', 'CNY': 'YuanRenminbi',
  'COP': 'ColombianPeso', 'CRC': 'CostaRicanColon', 'CUC': 'PesoConvertible',
  'CUP': 'CubanPeso', 'CVE': 'CaboVerdeEscudo', 'CZK': 'CzechKoruna',
  'DJF': 'DjiboutiFranc', 'DKK': 'DanishKrone', 'DOP': 'DominicanPeso',
  'DZD': 'AlgeriaDinar', 'EGP': 'EgyptianPound', 'ERN': 'Nakfa',
  'ETB': 'EthiopianBirr', 'EUR': 'Euro', 'FJD': 'FijiDollar',
  'FKP': 'FalklandIslandsPound', 'GBP': 'PoundSterling', 'GEL': 'Lari',
  'GGP': 'GuernseyPound', 'GHS': 'GhanaCedi', 'GIP': 'GibraltarPound',
  'GMD': 'Dalasi', 'GNF': 'GuineanFranc', 'GTQ': 'Quetzal', 'GYD': 'GuyanaDollar',
  'HKD': 'HongKongDollar', 'HNL': 'Lempira', 'HRK': 'Kuna', 'HTG': 'Gourde',
  'HUF': 'Forint', 'IDR': 'Rupiah', 'ILS': 'NewIsraeliSheqel',
  'INR': 'IndianRupee', 'IQD': 'IraqiDinar', 'IRR': 'IranianRial',
  'ISK': 'IcelandKrona', 'JEP': 'JerseyPound', 'JMD': 'JamaicanDollar',
  'JOD': 'JordanianDinar', 'JPY': 'Yen', 'KES': 'KenyanShilling',
  'KGS': 'Som', 'KHR': 'Riel', 'KMF': 'ComorianFranc', 'KPW': 'NorthKoreanWon',
  'KRW': 'Won', 'KWD': 'KuwaitiDinar', 'KYD': 'CaymanIslandsDollar',
  'KZT': 'Tenge', 'LAK': 'LaoKip', 'LBP': 'LebanesePound', 'LKR': 'SriLankaRupee',
  'LRD': 'LiberianDollar', 'LSL': 'Loti', 'LYD': 'LibyanDinar',
  'MAD': 'MoroccanDirham', 'MDL': 'MoldovanLeu', 'MGA': 'MalagasyAriary',
  'MKD': 'Denar', 'MMK': 'Kyat', 'MNT': 'Tugrik', 'MOP': 'Pataca',
  'MRU': 'Ouguiya', 'MUR': 'MauritiusRupee', 'MVR': 'Rufiyaa',
  'MWK': 'MalawiKwacha', 'MXN': 'MexicanPeso', 'MYR': 'MalaysianRinggit',
  'MZN': 'MozambiqueMetical', 'NAD': 'NamibiaDollar', 'NGN': 'Naira',
  'NIO': 'CordobaOro', 'NOK': 'NorwegianKrone', 'NPR': 'NepaleseRupee',
  'NZD': 'NewZealandDollar', 'OMR': 'RialOmani', 'PAB': 'PanamanianBalboa',
  'PEN': 'Sol', 'PGK': 'Kina', 'PHP': 'PhilippinePeso', 'PKR': 'PakistanRupee',
  'PLN': 'Zloty', 'PYG': 'Guarani', 'QAR': 'QatariRial', 'RON': 'RomanianLeu',
  'RSD': 'SerbianDinar', 'RUB': 'RussianRuble', 'RWF': 'RwandaFranc',
  'SAR': 'SaudiRiyal', 'SBD': 'SolomonIslandsDollar', 'SCR': 'SeychelloisRupee',
  'SDG': 'SudanesePound', 'SEK': 'SwedishKrona', 'SGD': 'SingaporeDollar',
  'SHP': 'SaintHelenaPound', 'SLL': 'Leone', 'SOS': 'SomaliShilling',
  'SRD': 'SurinamDollar', 'SSP': 'SouthSudanesePound', 'STN': 'Dobra',
  'SVC': 'SalvadorColon', 'SYP': 'SyrianPound', 'SZL': 'Lilangeni',
  'THB': 'Baht', 'TJS': 'Somoni', 'TMT': 'TurkmenistanManat', 'TND': 'TunisianDinar',
  'TOP': 'Paanga', 'TRY': 'TurkishLira', 'TTD': 'TrinidadAndTobagoDollar',
  'TWD': 'NewTaiwanDollar', 'TZS': 'TanzanianShilling', 'UAH': 'Hryvnia',
  'UGX': 'UgandaShilling', 'USD': 'UnitedStatesDollar', 'UYU': 'PesoUruguayo',
  'UZS': 'UzbekistanSum', 'VES': 'BolivarSoberano', 'VND': 'Dong',
  'VUV': 'Vatu', 'WST': 'Tala', 'XAF': 'CFAFrancBEAC', 'XCD': 'EastCaribbeanDollar',
  'XOF': 'CFAFrancBCEAO', 'XPF': 'CFPFranc', 'YER': 'YemeniRial',
  'ZAR': 'Rand', 'ZMW': 'ZambianKwacha', 'ZWL': 'ZimbabweDollar',
};


