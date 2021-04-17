//import 'package:unit_convert/unit_convert.dart';

class UnitConversionHelper {

  static const String angleUnit = 'Angle Unit';
  static const String areaUnit = 'Area Unit';
  static const String energyUnit = 'Energy Unit';
  static const String forceUnit = 'Force Unit';
  static const String lengthUnit = 'Length Unit';
  static const String numberBaseUnit = 'Number Base Unit';
  static const String powerUnit = 'Power Unit';
  static const String pressureUnit = 'Pressure Unit';
  static const String speedUnit = 'Speed Unit';
  static const String storageUnit = 'Storage Unit';
  static const String temperatureUnit = 'Temperature Unit';
  static const String timeUnit = 'Time Unit';
  static const String volumeUnit = 'Volume Unit';
  static const String weightUnit = 'Weight Unit';
  static const String fuelUnit = 'Fuel Unit';
  static const String torqueUnit = 'Torque Unit';
  static const String shoeSizeUnit = 'Shoe Size Unit';

}

class UnitConversion{
  final String unitCode;
  dynamic unitName;
  dynamic unitValue;
  UnitConversion({this.unitCode, this.unitName, this.unitValue});
}
