import 'package:unit_convert/unit_convert.dart';

class UnitConversionHelper {
  
  //Angle Conversion List
  List<UnitConversion> getAngleConversionList(double conversionValue, var conversionFromUnit) {
    List<UnitConversion> unitConversion = [];

    unitConversion.add(UnitConversion(unitCode:'arcs', unitName:'second',
        unitValue: from(conversionFromUnit).to(second, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'arcm', unitName:'minute',
        unitValue: from(conversionFromUnit).to(minute, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'deg', unitName:'degree',
        unitValue: from(conversionFromUnit).to(degree, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'rad', unitName:'radian',
        unitValue: from(conversionFromUnit).to(radian, conversionValue)
    ));
    return unitConversion;
  }
  //Area Conversion List
  List<UnitConversion> getAreaConversionList(double conversionValue, var conversionFromUnit){
    List<UnitConversion> unitConversion = [];
    unitConversion.add(UnitConversion(unitCode:'acre', unitName:'acre',
        unitValue: from(conversionFromUnit).to(acre, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'cm²', unitName:'squareCentimeter',
        unitValue: from(conversionFromUnit).to(squareCentimeter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'ha', unitName:'hectare',
        unitValue: from(conversionFromUnit).to(hectare, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'ft²', unitName:'squareFoot',
        unitValue: from(conversionFromUnit).to(squareFoot, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'inch²', unitName:'squareInch',
        unitValue: from(conversionFromUnit).to(squareInch, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'km²', unitName:'squareKilometer',
        unitValue: from(conversionFromUnit).to(squareKilometer, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'m²', unitName:'squareMeter',
        unitValue: from(conversionFromUnit).to(squareMeter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'μm²', unitName:'squareMicrometer',
        unitValue: from(conversionFromUnit).to(squareMicrometer, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'mi²', unitName:'squareMile',
        unitValue: from(conversionFromUnit).to(squareMile, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'mm²', unitName:'squareMillimeter',
        unitValue: from(conversionFromUnit).to(squareMillimeter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'nm²', unitName:'squareNanometer',
        unitValue: from(conversionFromUnit).to(squareNanometer, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'yd²', unitName:'squareYard',
        unitValue: from(conversionFromUnit).to(squareYard, conversionValue)
    ));
    return unitConversion;
  }
  //Energy Conversion List
  List<UnitConversion> getEnergyConversionList(double conversionValue, var conversionFromUnit){
    List<UnitConversion> unitConversion = [];

    unitConversion.add(UnitConversion(unitCode:'aJ', unitName:'attojoule',
        unitValue: from(conversionFromUnit).to(attojoule, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'cal', unitName:'calorie',
        unitValue: from(conversionFromUnit).to(calorie, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'eV', unitName:'electronVolt',
        unitValue: from(conversionFromUnit).to(electronVolt, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'fj', unitName:'femtojoule',
        unitValue: from(conversionFromUnit).to(femtojoule, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Gj', unitName:'gigajoule',
        unitValue: from(conversionFromUnit).to(gigajoule, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'GWh', unitName:'gigawattHour',
        unitValue: from(conversionFromUnit).to(gigawattHour, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'kcal', unitName:'kilocalorie',
        unitValue: from(conversionFromUnit).to(kilocalorie, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'keV', unitName:'kiloelectronVolt',
        unitValue: from(conversionFromUnit).to(kiloelectronVolt, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'kJ', unitName:'kilojoule',
        unitValue: from(conversionFromUnit).to(kilojoule, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'kt', unitName:'kiloton',
        unitValue: from(conversionFromUnit).to(kiloton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'KWh', unitName:'kilowattHour',
        unitValue: from(conversionFromUnit).to(kilowattHour, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'meV', unitName:'megaelectronVolt',
        unitValue: from(conversionFromUnit).to(megaelectronVolt, conversionValue)
    ));

    unitConversion.add(UnitConversion(unitCode:'J', unitName:'joule',
        unitValue: from(conversionFromUnit).to(joule, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'MWh', unitName:'megawattHour',
        unitValue: from(conversionFromUnit).to(megawattHour, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'µJ', unitName:'microjoule',
        unitValue: from(conversionFromUnit).to(microjoule, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'mJ', unitName:'millijoule',
        unitValue: from(conversionFromUnit).to(millijoule, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'pJ', unitName:'picojoule',
        unitValue: from(conversionFromUnit).to(picojoule, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'t', unitName:'ton',
        unitValue: from(conversionFromUnit).to(ton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Wh', unitName:'wattHour',
        unitValue: from(conversionFromUnit).to(wattHour, conversionValue)
    ));
    return unitConversion;
  }
  //Force Conversion List
  List<UnitConversion> getForceConversionList(double conversionValue, var conversionFromUnit) {
    List<UnitConversion> unitConversion = [];
    unitConversion.add(UnitConversion(unitCode:'aN', unitName:'attonewton',
        unitValue: from(conversionFromUnit).to(attonewton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'cN', unitName:'centinewton',
        unitValue: from(conversionFromUnit).to(centinewton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'dN', unitName:'decinewton',
        unitValue: from(conversionFromUnit).to(decinewton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'daN', unitName:'dekanewton',
        unitValue: from(conversionFromUnit).to(dekanewton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'EN', unitName:'exanewton',
        unitValue: from(conversionFromUnit).to(exanewton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'fN', unitName:'femtonewton',
        unitValue: from(conversionFromUnit).to(femtonewton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'GN', unitName:'giganewton',
        unitValue: from(conversionFromUnit).to(giganewton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'gf', unitName:'gramForce',
        unitValue: from(conversionFromUnit).to(gramForce, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'hN', unitName:'hectonewton',
        unitValue: from(conversionFromUnit).to(hectonewton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'kgf', unitName:'kilogramForce',
        unitValue: from(conversionFromUnit).to(kilogramForce, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'kN', unitName:'kilonewton',
        unitValue: from(conversionFromUnit).to(kilonewton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'klbf', unitName:'kipForce',
      unitValue: from(conversionFromUnit).to(kipForce, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'MN', unitName:'meganewton',
        unitValue: from(conversionFromUnit).to(meganewton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'µN', unitName:'micronewton',
        unitValue: from(conversionFromUnit).to(micronewton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'mN', unitName:'millinewton',
        unitValue: from(conversionFromUnit).to(millinewton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'nN', unitName:'nanonewton',
        unitValue: from(conversionFromUnit).to(nanonewton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'N', unitName:'newton',
        unitValue: from(conversionFromUnit).to(newton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'ozf', unitName:'ounceForce',
        unitValue: from(conversionFromUnit).to(ounceForce, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'PN', unitName:'petanewton',
        unitValue: from(conversionFromUnit).to(petanewton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'pN', unitName:'piconewton',
        unitValue: from(conversionFromUnit).to(piconewton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'lbf', unitName:'poundForce',
        unitValue: from(conversionFromUnit).to(poundForce, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'TN', unitName:'teranewton',
        unitValue: from(conversionFromUnit).to(teranewton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'tfN', unitName:'tonForce',
        unitValue: from(conversionFromUnit).to(tonForce, conversionValue)
    ));
    return unitConversion;
  }
  //Length Conversion List
  List<UnitConversion> getLengthConversionList(double conversionValue, var conversionFromUnit) {
    List<UnitConversion> unitConversion = [];

    unitConversion.add(UnitConversion(unitCode:'cm', unitName:'centimeter',
        unitValue: from(conversionFromUnit).to(centimeter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'ft', unitName:'foot',
        unitValue: from(conversionFromUnit).to(foot, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'in', unitName:'inch',
        unitValue: from(conversionFromUnit).to(inch, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'km', unitName:'kilometer',
        unitValue: from(conversionFromUnit).to(kilometer, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'m', unitName:'meter',
        unitValue: from(conversionFromUnit).to(meter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'µm', unitName:'micrometer',
        unitValue: from(conversionFromUnit).to(micrometer, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'mi', unitName:'mile',
        unitValue: from(conversionFromUnit).to(mile, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'mm', unitName:'millimeter',
        unitValue: from(conversionFromUnit).to(millimeter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'nm', unitName:'nanometer',
        unitValue: from(conversionFromUnit).to(nanometer, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'nmi', unitName:'nauticalMile',
        unitValue: from(conversionFromUnit).to(nauticalMile, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'yd', unitName:'yard',
        unitValue: from(conversionFromUnit).to(yard, conversionValue)
    ));
    return unitConversion;
  }
  //Number Base Conversion List
  List<UnitConversion> getNumberBaseConversionList(double conversionValue, var conversionFromUnit) {
    List<UnitConversion> unitConversion = [];
    unitConversion.add(UnitConversion(unitCode:'b', unitName:'binary',
        unitValue: from(conversionFromUnit).to(binary, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'d', unitName:'decimal',
        unitValue: from(conversionFromUnit).to(decimal, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'h', unitName:'hexadecimal',
        unitValue: from(conversionFromUnit).to(hexadecimal, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'o', unitName:'octal',
        unitValue: from(conversionFromUnit).to(octal, conversionValue)
    ));
    return unitConversion;
  }
  //Power Conversion List
  List<UnitConversion> getPowerConversionList(double conversionValue, var conversionFromUnit) {
    List<UnitConversion> unitConversion = [];
    unitConversion.add(UnitConversion(unitCode:'aW', unitName:'attowatt',
        unitValue: from(conversionFromUnit).to(attowatt, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'cW', unitName:'centiwatt',
        unitValue: from(conversionFromUnit).to(centiwatt, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'dW', unitName:'deciwatt',
        unitValue: from(conversionFromUnit).to(deciwatt, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'daW', unitName:'dekawatt',
        unitValue: from(conversionFromUnit).to(dekawatt, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'EW', unitName:'exawatt',
        unitValue: from(conversionFromUnit).to(exawatt, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'fW', unitName:'femtowatt',
        unitValue: from(conversionFromUnit).to(femtowatt, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'GW', unitName:'gigawatt',
        unitValue: from(conversionFromUnit).to(gigawatt, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'hW', unitName:'hectowatt',
        unitValue: from(conversionFromUnit).to(hectowatt, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'kW', unitName:'kilowatt',
        unitValue: from(conversionFromUnit).to(kilowatt, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'MW', unitName:'megawatt',
        unitValue: from(conversionFromUnit).to(megawatt, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'mW', unitName:'milliwatt',
        unitValue: from(conversionFromUnit).to(milliwatt, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'PW', unitName:'petawatt',
        unitValue: from(conversionFromUnit).to(petawatt, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'pW', unitName:'picowatt',
        unitValue: from(conversionFromUnit).to(picowatt, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'TW', unitName:'terawatt',
        unitValue: from(conversionFromUnit).to(terawatt, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'W', unitName:'watt',
      unitValue: from(conversionFromUnit).to(watt, conversionValue)
    ));
    return unitConversion;
  }
  //Pressure Conversion List
  List<UnitConversion> getPressureConversionList(double conversionValue, var conversionFromUnit) {
    List<UnitConversion> unitConversion = [];
    unitConversion.add(UnitConversion(unitCode:'cPa', unitName:'centipascal',
        unitValue: from(conversionFromUnit).to(centipascal, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'daPa', unitName:'dekapascal',
        unitValue: from(conversionFromUnit).to(dekapascal, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'h', unitName:'gigapascal',
        unitValue: from(conversionFromUnit).to(gigapascal, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'hPa', unitName:'hectopascal',
        unitValue: from(conversionFromUnit).to(hectopascal, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'kPa', unitName:'kilopascal',
        unitValue: from(conversionFromUnit).to(kilopascal, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'MPa', unitName:'megapascal',
        unitValue: from(conversionFromUnit).to(megapascal, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'µbar', unitName:'microbar',
        unitValue: from(conversionFromUnit).to(gigapascal, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'µPa', unitName:'micropascal',
        unitValue: from(conversionFromUnit).to(micropascal, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'millibar', unitName:'millibar',
        unitValue: from(conversionFromUnit).to(millibar, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'mPa', unitName:'millipascal',
        unitValue: from(conversionFromUnit).to(millipascal, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Pa', unitName:'pascal',
        unitValue: from(conversionFromUnit).to(pascal, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'psi', unitName:'psi',
        unitValue: from(conversionFromUnit).to(psi, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'torr', unitName:'torr',
        unitValue: from(conversionFromUnit).to(torr, conversionValue)
    ));
    return unitConversion;
  }
  //Speed Conversion List
  List<UnitConversion> getSpeedConversionList(double conversionValue, var conversionFromUnit) {
    List<UnitConversion> unitConversion = [];
    unitConversion.add(UnitConversion(unitCode:'beaufort', unitName:'beaufort',
        unitValue: from(conversionFromUnit).to(beaufort, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'cm/h', unitName:'centimeterPerHour',
        unitValue: from(conversionFromUnit).to(centimeterPerHour, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'cm/m', unitName:'centimeterPerMinute',
        unitValue: from(conversionFromUnit).to(centimeterPerMinute, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'cm/s', unitName:'centimeterPerSecond',
        unitValue: from(conversionFromUnit).to(centimeterPerSecond, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'ft/h', unitName:'footPerHour',
        unitValue: from(conversionFromUnit).to(footPerHour, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'ft/m', unitName:'footPerMinute',
        unitValue: from(conversionFromUnit).to(footPerMinute, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'ft/s', unitName:'footPerSecond',
        unitValue: from(conversionFromUnit).to(footPerSecond, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'km/h', unitName:'kilometerPerHour',
        unitValue: from(conversionFromUnit).to(kilometerPerHour, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'km/m', unitName:'kilometerPerMinute',
        unitValue: from(conversionFromUnit).to(kilometerPerMinute, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'km/s', unitName:'kilometerPerSecond',
        unitValue: from(conversionFromUnit).to(kilometerPerSecond, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'knot', unitName:'knot',
        unitValue: from(conversionFromUnit).to(knot, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Ma', unitName:'mach',
        unitValue: from(conversionFromUnit).to(mach, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'m/h', unitName:'meterPerHour',
        unitValue: from(conversionFromUnit).to(meterPerHour, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'m/m', unitName:'meterPerMinute',
        unitValue: from(conversionFromUnit).to(meterPerMinute, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'m/s', unitName:'meterPerSecond',
        unitValue: from(conversionFromUnit).to(meterPerSecond, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'mi/h', unitName:'milePerHour',
        unitValue: from(conversionFromUnit).to(milePerHour, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'mi/m', unitName:'milePerMinute',
        unitValue: from(conversionFromUnit).to(milePerMinute, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'mi/s', unitName:'milePerSecond',
        unitValue: from(conversionFromUnit).to(milePerSecond, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'yd/m', unitName:'yardPerMinute',
        unitValue: from(conversionFromUnit).to(yardPerMinute, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'yd/s', unitName:'yardPerSecond',
        unitValue: from(conversionFromUnit).to(yardPerSecond, conversionValue)
    ));
    return unitConversion;
  }
  //Storage Conversion List
  List<UnitConversion> getStorageConversionList(double conversionValue, var conversionFromUnit) {
    List<UnitConversion> unitConversion = [];
    unitConversion.add(UnitConversion(unitCode:'bit', unitName:'bit',
        unitValue: from(conversionFromUnit).to(bit, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'byte', unitName:'byte',
        unitValue: from(conversionFromUnit).to(byte, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'char', unitName:'cd74Minute',
        unitValue: from(conversionFromUnit).to(cd74Minute, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'char', unitName:'cd80Minute',
        unitValue: from(conversionFromUnit).to(cd80Minute, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'char', unitName:'character',
        unitValue: from(conversionFromUnit).to(character, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'dvd', unitName:'dvd',
        unitValue: from(conversionFromUnit).to(dvd, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Ebit', unitName:'exabit',
        unitValue: from(conversionFromUnit).to(exabit, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Ebyte', unitName:'exabyte',
        unitValue: from(conversionFromUnit).to(exabyte, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Gb', unitName:'gigabit',
        unitValue: from(conversionFromUnit).to(gigabit, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'GB', unitName:'gigabyte',
        unitValue: from(conversionFromUnit).to(gigabyte, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'kb', unitName:'kilobit',
        unitValue: from(conversionFromUnit).to(kilobit, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'kB', unitName:'kilobyte',
        unitValue: from(conversionFromUnit).to(kilobyte, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Mb', unitName:'megabit',
        unitValue: from(conversionFromUnit).to(megabit, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'MB', unitName:'megabyte',
        unitValue: from(conversionFromUnit).to(megabyte, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'nibble', unitName:'nibble',
        unitValue: from(conversionFromUnit).to(nibble, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Pbit', unitName:'petabit',
        unitValue: from(conversionFromUnit).to(petabit, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'PB', unitName:'petabyte',
        unitValue: from(conversionFromUnit).to(petabyte, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Tb', unitName:'terabit',
        unitValue: from(conversionFromUnit).to(terabit, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'TB', unitName:'terabyte',
        unitValue: from(conversionFromUnit).to(terabyte, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'word', unitName:'word',
        unitValue: from(conversionFromUnit).to(word, conversionValue)
    ));
    return unitConversion;
  }
  //Temperature Conversion List
  List<UnitConversion> getTemperatureConversionList(double conversionValue, var conversionFromUnit) {
    List<UnitConversion> unitConversion = [];
    unitConversion.add(UnitConversion(unitCode:'°C', unitName:'celsius',
        unitValue: from(conversionFromUnit).to(celsius, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'°F', unitName:'fahrenheit',
        unitValue: from(conversionFromUnit).to(fahrenheit, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'°K', unitName:'kelvin',
        unitValue: from(conversionFromUnit).to(kelvin, conversionValue)
    ));
    return unitConversion;
  }
  //Time Conversion List
  List<UnitConversion> getTimeConversionList(double conversionValue, var conversionFromUnit) {
    List<UnitConversion> unitConversion = [];
    unitConversion.add(UnitConversion(unitCode:'s', unitName:'second',
        unitValue: from(conversionFromUnit).to(second, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'d', unitName:'day',
        unitValue: from(conversionFromUnit).to(day, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'μs', unitName:'microsecond',
        unitValue: from(conversionFromUnit).to(microsecond, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'min', unitName:'minute',
        unitValue: from(conversionFromUnit).to(minute, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'h', unitName:'hour',
        unitValue: from(conversionFromUnit).to(hour, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'y', unitName:'year',
        unitValue: from(conversionFromUnit).to(year, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'M', unitName:'month',
        unitValue: from(conversionFromUnit).to(month, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'C', unitName:'century',
        unitValue: from(conversionFromUnit).to(century, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'dec', unitName:'decade',
        unitValue: from(conversionFromUnit).to(decade, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'ms', unitName:'millisecond',
        unitValue: from(conversionFromUnit).to(millisecond, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'ns', unitName:'nanosecond',
        unitValue: from(conversionFromUnit).to(nanosecond, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'ps', unitName:'picosecond',
        unitValue: from(conversionFromUnit).to(picosecond, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'w', unitName:'week',
        unitValue: from(conversionFromUnit).to(week, conversionValue)
    ));
    return unitConversion;
  }
  //Volume Conversion List
  List<UnitConversion> getVolumeConversionList(double conversionValue, var conversionFromUnit) {
    List<UnitConversion> unitConversion = [];
    unitConversion.add(UnitConversion(unitCode:'aL', unitName:'attoliter',
        unitValue: from(conversionFromUnit).to(attoliter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'barrel', unitName:'barrelOil',
        unitValue: from(conversionFromUnit).to(barrelOil, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'barrel-uk', unitName:'barrelUK',
        unitValue: from(conversionFromUnit).to(barrelUK, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'barrel-us', unitName:'barrelUS',
        unitValue: from(conversionFromUnit).to(barrelUS, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'cL', unitName:'centiliter',
        unitValue: from(conversionFromUnit).to(centiliter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'cm³', unitName:'cubicCentimeter',
        unitValue: from(conversionFromUnit).to(cubicCentimeter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'ft³', unitName:'cubicFoot',
        unitValue: from(conversionFromUnit).to(cubicFoot, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'km³', unitName:'cubicInch',
        unitValue: from(conversionFromUnit).to(cubicInch, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'m³', unitName:'cubicMeter',
        unitValue: from(conversionFromUnit).to(cubicMeter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'mi³', unitName:'cubicMile',
        unitValue: from(conversionFromUnit).to(cubicMile, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'mm³', unitName:'cubicMillimeter',
        unitValue: from(conversionFromUnit).to(cubicMillimeter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'yd³', unitName:'cubicYard',
        unitValue: from(conversionFromUnit).to(cubicYard, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'dl', unitName:'deciliter',
        unitValue: from(conversionFromUnit).to(deciliter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'dal', unitName:'dekaliter',
        unitValue: from(conversionFromUnit).to(dekaliter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'El', unitName:'exaliter',
        unitValue: from(conversionFromUnit).to(exaliter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'fl', unitName:'femtoliter',
        unitValue: from(conversionFromUnit).to(femtoliter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'gal-us', unitName:'gallonUS',
        unitValue: from(conversionFromUnit).to(gallonUS, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Gl', unitName:'gigaliter',
        unitValue: from(conversionFromUnit).to(gigaliter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'hl', unitName:'hectoliter',
        unitValue: from(conversionFromUnit).to(hectoliter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'kl', unitName:'kiloliter',
        unitValue: from(conversionFromUnit).to(kiloliter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'L', unitName:'liter',
        unitValue: from(conversionFromUnit).to(liter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Ml', unitName:'megaliter',
        unitValue: from(conversionFromUnit).to(megaliter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'μl', unitName:'microliter',
        unitValue: from(conversionFromUnit).to(microliter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'ml', unitName:'milliliter',
        unitValue: from(conversionFromUnit).to(milliliter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'nl', unitName:'nanoliter',
        unitValue: from(conversionFromUnit).to(nanoliter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Pl', unitName:'petaliter',
        unitValue: from(conversionFromUnit).to(petaliter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'pl', unitName:'picoliter',
        unitValue: from(conversionFromUnit).to(picoliter, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Tl', unitName:'teraliter',
        unitValue: from(conversionFromUnit).to(teraliter, conversionValue)
    ));
    return unitConversion;
  }
  //Weight Conversion List
  List<UnitConversion> getWeightConversionList(double conversionValue, var conversionFromUnit) {
    List<UnitConversion> unitConversion = [];
    unitConversion.add(UnitConversion(unitCode:'ag', unitName:'attogram',
        unitValue: from(conversionFromUnit).to(attogram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'ton-uk', unitName:'tonUK',
        unitValue: from(conversionFromUnit).to(tonUK, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'ton', unitName:'ton',
        unitValue: from(conversionFromUnit).to(ton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'carat', unitName:'carat',
        unitValue: from(conversionFromUnit).to(carat, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'cg', unitName:'centigram',
        unitValue: from(conversionFromUnit).to(centigram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'dg', unitName:'decigram',
        unitValue: from(conversionFromUnit).to(decigram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'dag', unitName:'dekagram',
        unitValue: from(conversionFromUnit).to(dekagram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Eg', unitName:'exagram',
        unitValue: from(conversionFromUnit).to(exagram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'fg', unitName:'femtogram',
        unitValue: from(conversionFromUnit).to(femtogram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Gg', unitName:'gigagram',
        unitValue: from(conversionFromUnit).to(gigagram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'g', unitName:'gram',
        unitValue: from(conversionFromUnit).to(gram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'hg', unitName:'hectogram',
        unitValue: from(conversionFromUnit).to(hectogram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'kg', unitName:'kilogram',
        unitValue: from(conversionFromUnit).to(kilogram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'kt', unitName:'kiloton',
        unitValue: from(conversionFromUnit).to(kiloton, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Mg', unitName:'megagram',
        unitValue: from(conversionFromUnit).to(megagram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'μg', unitName:'microgram',
        unitValue: from(conversionFromUnit).to(microgram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'mg', unitName:'milligram',
        unitValue: from(conversionFromUnit).to(milligram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'ng', unitName:'nanogram',
        unitValue: from(conversionFromUnit).to(nanogram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'oz', unitName:'ounce',
        unitValue: from(conversionFromUnit).to(ounce, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Pg', unitName:'petagram',
        unitValue: from(conversionFromUnit).to(petagram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'pg', unitName:'picogram',
        unitValue: from(conversionFromUnit).to(picogram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'lb', unitName:'pound',
        unitValue: from(conversionFromUnit).to(pound, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'pdl', unitName:'poundal',
        unitValue: from(conversionFromUnit).to(poundal, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'q', unitName:'quintal',
        unitValue: from(conversionFromUnit).to(quintal, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'Tg', unitName:'teragram',
        unitValue: from(conversionFromUnit).to(teragram, conversionValue)
    ));
    unitConversion.add(UnitConversion(unitCode:'ton-us', unitName:'tonUS',
        unitValue: from(conversionFromUnit).to(tonUS, conversionValue)
    ));
    return unitConversion;
  }
}

class UnitConversion{
  final String unitCode, unitName;
  final double unitValue;
  UnitConversion({this.unitCode, this.unitName, this.unitValue});
}
