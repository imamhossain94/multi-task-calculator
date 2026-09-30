import 'package:units_converter/units_converter.dart';

/// One converter family (length, mass, temperature, ...).
///
/// A declarative table replaces the 17-branch `if/else` chain that used to live
/// in `unit_converter_child_page.dart`. That chain is where the **Volume** and
/// **Fuel Consumption** buttons were wired to the *Weight* converter.
class UnitCategory {
  const UnitCategory({
    required this.label,
    required this.iconKey,
    required this.prefix,
    required this.units,
    required this.build,
  });

  /// Human readable name, also used as the screen title.
  final String label;

  /// Stable key used by the UI to pick an icon for this category.
  final String iconKey;

  /// The `units_converter` enum prefix (e.g. `LENGTH.`) stripped for display.
  final String prefix;

  /// Unit label -> `units_converter` enum value.
  final Map<String, dynamic> units;

  /// Builds a fresh converter. A new instance is required for each conversion
  /// because `units_converter` mutates the object in place.
  final dynamic Function() build;

  /// Strips the enum prefix from a raw unit name.
  String pretty(dynamic raw) {
    final String name = raw.toString();
    return name.startsWith(prefix) ? name.substring(prefix.length) : name;
  }

  /// Human-friendly label: `square_kilometers` -> `Square Kilometers`.
  static String labelFor(String key) =>
      key.replaceAll('_', ' ').replaceAllMapped(
            RegExp(r'\b[a-z]'),
            (Match m) => m.group(0)!.toUpperCase(),
          );
}

/// Builds a converter with the settings the app uses everywhere.
dynamic _make<T>(
  T Function({int significantFigures, bool removeTrailingZeros}) builder,
) =>
    builder(significantFigures: 7, removeTrailingZeros: false);

/// Every convertible category, in the order the menu shows them.
final List<UnitCategory> unitCategories = <UnitCategory>[
  UnitCategory(
    label: 'Angle',
    iconKey: 'angle',
    prefix: 'ANGLE.',
    units: const <String, dynamic>{
      'degrees': ANGLE.degree,
      'minutes': ANGLE.minutes,
      'seconds': ANGLE.seconds,
      'radians': ANGLE.radians,
    },
    build: () => _make(Angle.new),
  ),
  UnitCategory(
    label: 'Area',
    iconKey: 'area',
    prefix: 'AREA.',
    units: const <String, dynamic>{
      'square_meters': AREA.squareMeters,
      'square_centimeters': AREA.squareCentimeters,
      'square_millimeters': AREA.squareMillimeters,
      'square_kilometers': AREA.squareKilometers,
      'square_inches': AREA.squareInches,
      'square_feet': AREA.squareFeet,
      'square_yards': AREA.squareYard,
      'square_miles': AREA.squareMiles,
      'hectares': AREA.hectares,
      'acres': AREA.acres,
      'are': AREA.are,
    },
    build: () => _make(Area.new),
  ),
  UnitCategory(
    label: 'Energy',
    iconKey: 'energy',
    prefix: 'ENERGY.',
    units: const <String, dynamic>{
      'joules': ENERGY.joules,
      'kilojoules': ENERGY.kilojoules,
      'calories': ENERGY.calories,
      'kilocalories': ENERGY.kilocalories,
      'watt_hours': ENERGY.wattHours,
      'kilowatt_hours': ENERGY.kilowattHours,
      'electronvolts': ENERGY.electronvolts,
    },
    build: () => _make(Energy.new),
  ),
  UnitCategory(
    label: 'Force',
    iconKey: 'force',
    prefix: 'FORCE.',
    units: const <String, dynamic>{
      'newtons': FORCE.newton,
      'dynes': FORCE.dyne,
      'pound_force': FORCE.poundForce,
      'kilogram_force': FORCE.kilogramForce,
      'poundals': FORCE.poundal,
    },
    build: () => _make(Force.new),
  ),
  UnitCategory(
    label: 'Length',
    iconKey: 'length',
    prefix: 'LENGTH.',
    units: const <String, dynamic>{
      'meters': LENGTH.meters,
      'centimeters': LENGTH.centimeters,
      'millimeters': LENGTH.millimeters,
      'micrometers': LENGTH.micrometers,
      'nanometers': LENGTH.nanometers,
      'kilometers': LENGTH.kilometers,
      'inches': LENGTH.inches,
      'feet': LENGTH.feet,
      'yards': LENGTH.yards,
      'miles': LENGTH.miles,
      'nautical_miles': LENGTH.nauticalMiles,
      'angstroms': LENGTH.angstroms,
      'picometers': LENGTH.picometers,
      'astronomical_units': LENGTH.astronomicalUnits,
      'light_years': LENGTH.lightYears,
      'parsecs': LENGTH.parsec,
    },
    build: () => _make(Length.new),
  ),
  UnitCategory(
    label: 'Power',
    iconKey: 'power',
    prefix: 'POWER.',
    units: const <String, dynamic>{
      'watts': POWER.watt,
      'milliwatts': POWER.milliwatt,
      'kilowatts': POWER.kilowatt,
      'megawatts': POWER.megawatt,
      'gigawatts': POWER.gigawatt,
      'european_horse_power': POWER.europeanHorsePower,
      'imperial_horse_power': POWER.imperialHorsePower,
    },
    build: () => _make(Power.new),
  ),
  UnitCategory(
    label: 'Pressure',
    iconKey: 'pressure',
    prefix: 'PRESSURE.',
    units: const <String, dynamic>{
      'pascals': PRESSURE.pascal,
      'hectopascals': PRESSURE.hectoPascal,
      'kilopascals': PRESSURE.kiloPascal,
      'megapascals': PRESSURE.megaPascal,
      'gigapascals': PRESSURE.gigaPascal,
      'bars': PRESSURE.bar,
      'millibars': PRESSURE.millibar,
      'atmospheres': PRESSURE.atmosphere,
      'psi': PRESSURE.psi,
      'ksi': PRESSURE.ksi,
      'torr': PRESSURE.torr,
      'inches_of_mercury': PRESSURE.inchOfMercury,
    },
    build: () => _make(Pressure.new),
  ),
  UnitCategory(
    label: 'Speed',
    iconKey: 'speed',
    prefix: 'SPEED.',
    units: const <String, dynamic>{
      'meters_per_second': SPEED.metersPerSecond,
      'kilometers_per_hour': SPEED.kilometersPerHour,
      'miles_per_hour': SPEED.milesPerHour,
      'knots': SPEED.knots,
      'feet_per_second': SPEED.feetsPerSecond,
      'minutes_per_kilometer': SPEED.minutesPerKilometer,
      'minutes_per_mile': SPEED.minutesPerMile,
    },
    build: () => _make(Speed.new),
  ),
  UnitCategory(
    label: 'Shoe Size',
    iconKey: 'shoe',
    prefix: 'SHOE_SIZE.',
    units: const <String, dynamic>{
      'centimeters': SHOE_SIZE.centimeters,
      'inches': SHOE_SIZE.inches,
      'eu_china': SHOE_SIZE.euChina,
      'uk_india_child': SHOE_SIZE.ukIndiaChild,
      'uk_india_man': SHOE_SIZE.ukIndiaMan,
      'uk_india_woman': SHOE_SIZE.ukIndiaWoman,
      'usa_canada_child': SHOE_SIZE.usaCanadaChild,
      'usa_canada_man': SHOE_SIZE.usaCanadaMan,
      'usa_canada_woman': SHOE_SIZE.usaCanadaWoman,
      'japan': SHOE_SIZE.japan,
    },
    build: () => _make(ShoeSize.new),
  ),
  UnitCategory(
    label: 'Temperature',
    iconKey: 'temperature',
    prefix: 'TEMPERATURE.',
    units: const <String, dynamic>{
      'celsius': TEMPERATURE.celsius,
      'fahrenheit': TEMPERATURE.fahrenheit,
      'kelvin': TEMPERATURE.kelvin,
      'reamur': TEMPERATURE.reamur,
      'romer': TEMPERATURE.romer,
      'delisle': TEMPERATURE.delisle,
      'rankine': TEMPERATURE.rankine,
    },
    build: () => _make(Temperature.new),
  ),
  UnitCategory(
    label: 'Storage',
    iconKey: 'storage',
    prefix: 'DIGITAL_DATA.',
    units: const <String, dynamic>{
      'bits': DIGITAL_DATA.bit,
      'nibbles': DIGITAL_DATA.nibble,
      'kilobits': DIGITAL_DATA.kilobit,
      'megabits': DIGITAL_DATA.megabit,
      'gigabits': DIGITAL_DATA.gigabit,
      'terabits': DIGITAL_DATA.terabit,
      'petabits': DIGITAL_DATA.petabit,
      'exabits': DIGITAL_DATA.exabit,
      'kibibits': DIGITAL_DATA.kibibit,
      'mebibits': DIGITAL_DATA.mebibit,
      'gibibits': DIGITAL_DATA.gibibit,
      'tebibits': DIGITAL_DATA.tebibit,
      'pebibits': DIGITAL_DATA.pebibit,
      'exbibits': DIGITAL_DATA.exbibit,
      'bytes': DIGITAL_DATA.byte,
      'kilobytes': DIGITAL_DATA.kilobyte,
      'megabytes': DIGITAL_DATA.megabyte,
      'gigabytes': DIGITAL_DATA.gigabyte,
      'terabytes': DIGITAL_DATA.terabyte,
      'petabytes': DIGITAL_DATA.petabyte,
      'exabytes': DIGITAL_DATA.exabyte,
      'kibibytes': DIGITAL_DATA.kibibyte,
      'mebibytes': DIGITAL_DATA.mebibyte,
      'gibibytes': DIGITAL_DATA.gibibyte,
      'tebibytes': DIGITAL_DATA.tebibyte,
      'pebibytes': DIGITAL_DATA.pebibyte,
      'exbibytes': DIGITAL_DATA.exbibyte,
    },
    build: () => _make(DigitalData.new),
  ),
  UnitCategory(
    label: 'Weight',
    iconKey: 'weight',
    prefix: 'MASS.',
    units: const <String, dynamic>{
      'grams': MASS.grams,
      'ettograms': MASS.ettograms,
      'kilograms': MASS.kilograms,
      'milligrams': MASS.milligrams,
      'micrograms': MASS.micrograms,
      'tonnes': MASS.tonnes,
      'quintals': MASS.quintals,
      'pounds': MASS.pounds,
      'ounces': MASS.ounces,
      'stones': MASS.stones,
      'carats': MASS.carats,
      'grains': MASS.grains,
      'pennyweights': MASS.pennyweights,
      'troy_ounces': MASS.troyOunces,
      'short_tons': MASS.shortTon,
      'long_tons': MASS.longTon,
      'atomic_mass_units': MASS.uma,
    },
    build: () => _make(Mass.new),
  ),
  UnitCategory(
    label: 'Time',
    iconKey: 'time',
    prefix: 'TIME.',
    units: const <String, dynamic>{
      'nanoseconds': TIME.nanoseconds,
      'microseconds': TIME.microseconds,
      'milliseconds': TIME.milliseconds,
      'centiseconds': TIME.centiseconds,
      'deciseconds': TIME.deciseconds,
      'seconds': TIME.seconds,
      'minutes': TIME.minutes,
      'hours': TIME.hours,
      'days': TIME.days,
      'weeks': TIME.weeks,
      'years_365': TIME.years365,
      'average_months': TIME.averageMonth,
      'lustrums': TIME.lustrum,
      'decades': TIME.decades,
      'centuries': TIME.centuries,
      'millenniums': TIME.millennium,
    },
    build: () => _make(Time.new),
  ),
  UnitCategory(
    label: 'Volume',
    iconKey: 'volume',
    prefix: 'VOLUME.',
    units: const <String, dynamic>{
      'cubic_meters': VOLUME.cubicMeters,
      'cubic_centimeters': VOLUME.cubicCentimeters,
      'cubic_millimeters': VOLUME.cubicMillimeters,
      'cubic_inches': VOLUME.cubicInches,
      'cubic_feet': VOLUME.cubicFeet,
      'cubic_yards': VOLUME.cubicYard,
      'liters': VOLUME.liters,
      'milliliters': VOLUME.milliliters,
      'deciliters': VOLUME.deciliters,
      'centiliters': VOLUME.centiliters,
      'microliters': VOLUME.microliters,
      'us_gallons': VOLUME.usGallons,
      'imperial_gallons': VOLUME.imperialGallons,
      'us_pints': VOLUME.usPints,
      'imperial_pints': VOLUME.imperialPints,
      'us_quarts': VOLUME.usQuarts,
      'imperial_quarts': VOLUME.imperialQuarts,
      'us_cups': VOLUME.usCups,
      'metric_cups': VOLUME.metricCup,
      'imperial_cups': VOLUME.imperialCup,
      'us_fluid_ounces': VOLUME.usFluidOunces,
      'imperial_fluid_ounces': VOLUME.imperialFluidOunces,
      'us_tablespoons': VOLUME.tablespoonsUs,
      'australian_tablespoons': VOLUME.australianTablespoons,
      'us_teaspoons': VOLUME.teaspoonsUs,
      'metric_teaspoons': VOLUME.teaspoonsMetric,
      'us_gills': VOLUME.usGill,
      'imperial_gills': VOLUME.imperialGill,
      'us_barrels': VOLUME.usBarrel,
    },
    build: () => _make(Volume.new),
  ),
  UnitCategory(
    label: 'Fuel Consumption',
    iconKey: 'fuel',
    prefix: 'FUEL_CONSUMPTION.',
    units: const <String, dynamic>{
      'kilometers_per_liter': FUEL_CONSUMPTION.kilometersPerLiter,
      'liters_per_100_km': FUEL_CONSUMPTION.litersPer100km,
      'miles_per_liter': FUEL_CONSUMPTION.milesPerLiter,
      'miles_per_us_gallon': FUEL_CONSUMPTION.milesPerUsGallon,
      'miles_per_imperial_gallon': FUEL_CONSUMPTION.milesPerImperialGallon,
    },
    build: () => _make(FuelConsumption.new),
  ),
  UnitCategory(
    label: 'Torque',
    iconKey: 'torque',
    prefix: 'TORQUE.',
    units: const <String, dynamic>{
      'newton_meters': TORQUE.newtonMeter,
      'dyne_meters': TORQUE.dyneMeter,
      'kilogram_force_meters': TORQUE.kilogramForceMeter,
      'pound_force_feet': TORQUE.poundForceFeet,
      'pound_force_inches': TORQUE.poundForceInch,
      'poundal_meters': TORQUE.poundalMeter,
    },
    build: () => _make(Torque.new),
  ),
];

/// Looks up a category by its display label. Returns `null` when unknown.
UnitCategory? unitCategoryByLabel(String label) {
  for (final UnitCategory c in unitCategories) {
    if (c.label == label) return c;
  }
  return null;
}
