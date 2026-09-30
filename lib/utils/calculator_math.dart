/// Pure-math helpers for every calculator.
///
/// Deliberately free of any Flutter dependency so the layer can be unit-tested
/// directly (see `test/calculator_math_test.dart`).
///
/// Every entry point returns `0` (or an explicitly documented value) rather
/// than `Infinity`/`NaN` for degenerate input, which was the source of the
/// "Infinity" results the old UI used to render.
library;

/// Monthly payment for an amortising loan.
///
/// [principal] loan amount, [annualRatePercent] nominal annual rate,
/// [years] loan length. A 0% rate is handled as simple division instead of
/// dividing by `pow(1 + 0, n) - 1 == 0`.
double loanMonthlyPayment({
  required double principal,
  required double annualRatePercent,
  required int years,
}) {
  if (principal <= 0 || years <= 0) return 0;
  final int months = years * 12;
  final double r = annualRatePercent / 100 / 12;
  if (r == 0) return principal / months;
  final double growth = _pow(1 + r, months);
  return principal * (r * growth) / (growth - 1);
}

/// Principal you can borrow for a given monthly budget.
double loanMaxBorrow({
  required double monthlyPayment,
  required double annualRatePercent,
  required int years,
}) {
  if (monthlyPayment <= 0 || years <= 0) return 0;
  final int months = years * 12;
  final double r = annualRatePercent / 100 / 12;
  if (r == 0) return monthlyPayment * months;
  final double growth = _pow(1 + r, months);
  return monthlyPayment * (growth - 1) / (r * growth);
}

/// Total amount repaid over the life of the loan.
double loanTotalCost({
  required double principal,
  required double annualRatePercent,
  required int years,
}) =>
    loanMonthlyPayment(
      principal: principal,
      annualRatePercent: annualRatePercent,
      years: years,
    ) *
    years *
    12;

/// Interest paid over the life of the loan.
double loanTotalInterest({
  required double principal,
  required double annualRatePercent,
  required int years,
}) {
  final double total = loanTotalCost(
    principal: principal,
    annualRatePercent: annualRatePercent,
    years: years,
  );
  final double interest = total - principal;
  return interest < 0 ? 0 : interest;
}

/// A calendar-aware `from` -> `to` breakdown.
///
/// The old implementation divided by 30.417 in one picker and by 12 in the
/// other, so the two halves of the screen disagreed. This walks real calendar
/// months instead, so 1 Mar -> 1 Mar is exactly one year.
({int years, int months, int days, int totalDays}) dateBreakdown({
  required DateTime from,
  required DateTime to,
}) {
  // Work with date-only values so time-of-day never shifts the result.
  final DateTime start = DateTime(from.year, from.month, from.day);
  final DateTime end = DateTime(to.year, to.month, to.day);

  if (end.isBefore(start)) {
    return (years: 0, months: 0, days: 0, totalDays: 0);
  }

  int years = end.year - start.year;
  int months = end.month - start.month;
  int days = end.day - start.day;

  if (days < 0) {
    months -= 1;
    // The borrow must come from the month *before* `end`. Deriving it from
    // `end` gives the wrong length for month pairs like Jan -> Mar.
    final DateTime borrowMonth =
        months >= 0 ? end : DateTime(end.year, end.month - 1);
    final int daysInPreviousMonth =
        DateTime(borrowMonth.year, borrowMonth.month + 1, 0).day;
    days += daysInPreviousMonth;
  }
  if (months < 0) {
    years -= 1;
    months += 12;
  }

  return (
    years: years,
    months: months,
    days: days,
    totalDays: end.difference(start).inDays,
  );
}

/// Compound growth of [principal] compounded [times] times at [ratePercent].
///
/// When [contribution] is non-zero it is added once per compounding period
/// (an ordinary annuity payment).
double compound({
  required double principal,
  required double ratePercent,
  required int times,
  double contribution = 0,
}) {
  if (times <= 0) return principal;
  final double r = ratePercent / 100;
  if (r == 0) return principal + contribution * times;
  return principal * _pow(1 + r, times) +
      contribution * ((_pow(1 + r, times) - 1) / r);
}

/// Sales tax amount and tax-inclusive total.
({double tax, double total}) salesTax({
  required double price,
  required double ratePercent,
}) {
  final double tax = price * (ratePercent / 100);
  return (tax: tax, total: price + tax);
}

/// Discount applied *after* tax has been added — the usual retail behaviour.
({double saved, double finalPrice}) discount({
  required double originalPrice,
  required double taxPercent,
  required double discountPercent,
}) {
  final double taxed = originalPrice + originalPrice * (taxPercent / 100);
  final double saved = taxed * (discountPercent / 100);
  return (saved: saved, finalPrice: taxed - saved);
}

/// Tip calculator.
///
/// [tipIsPercent] / [taxIsPercent] select whether the corresponding input is an
/// absolute amount or a percentage of the bill. Returns `0` for [people] `<= 0`
/// instead of dividing by zero.
({double tip, double tax, double finalAmount, double perPerson}) tip({
  required double bill,
  required double tipInput,
  required double taxInput,
  required int people,
  required bool tipIsPercent,
  required bool taxIsPercent,
}) {
  final int headCount = people < 1 ? 1 : people;
  final double tipAmount = tipIsPercent ? bill * (tipInput / 100) : tipInput;
  final double taxAmount = taxIsPercent ? bill * (taxInput / 100) : taxInput;
  final double finalAmount = bill + tipAmount + taxAmount;
  return (
    tip: tipAmount,
    tax: taxAmount,
    finalAmount: finalAmount,
    perPerson: finalAmount / headCount,
  );
}

/// Fuel cost for a trip.
({double litres, double cost}) fuelCost({
  required double distanceKm,
  required double efficiencyKmPerLitre,
  required double pricePerLitre,
}) {
  if (efficiencyKmPerLitre <= 0) return (litres: 0, cost: 0);
  final double litres = distanceKm / efficiencyKmPerLitre;
  return (litres: litres, cost: litres * pricePerLitre);
}

/// Actual fuel efficiency between two odometer readings.
double fuelEfficiency({
  required double startOdometer,
  required double endOdometer,
  required double litres,
}) {
  if (litres <= 0) return 0;
  return (endOdometer - startOdometer) / litres;
}

/// Body Mass Index.
double bmi({required double heightCm, required double weightKg}) {
  if (heightCm <= 0) return 0;
  final double m = heightCm / 100;
  return weightKg / (m * m);
}

/// WHO BMI category for [value].
String bmiCategory(double value) {
  if (value <= 0) return '—';
  if (value < 18.5) return 'Underweight';
  if (value < 25) return 'Healthy weight';
  if (value < 30) return 'Overweight';
  if (value < 40) return 'Obese';
  return 'Severely obese';
}

/// Basal Metabolic Rate, Mifflin–St Jeor.
double bmr({
  required double weightKg,
  required double heightCm,
  required int age,
  required bool isMale,
}) {
  if (weightKg <= 0 || heightCm <= 0 || age <= 0) return 0;
  final double base = 10 * weightKg + 6.25 * heightCm - 5 * age;
  return isMale ? base + 5 : base - 161;
}

/// Unit price for a line item.
double unitPrice({required double totalPrice, required double quantity}) {
  if (quantity == 0) return 0;
  return totalPrice / quantity;
}

/// Final balance of a savings plan.
///
/// Interest accrues daily at the nominal annual rate / 365, and a
/// [contribution] is added every [contributionIntervalDays] days.
///
/// The old implementation skipped the *first* contribution (`initialDeposit`)
/// and only credited interest once per calendar month, both of which
/// under-reported the result. This version credits every contribution and
/// compounds daily.
double savingsProjection({
  required double principal,
  required double contribution,
  required double annualRatePercent,
  required int years,
  required int contributionIntervalDays,
}) {
  if (years <= 0) return principal;
  final int days = years * 365;
  final double r = annualRatePercent / 100 / 365;
  final int interval =
      contributionIntervalDays < 1 ? 1 : contributionIntervalDays;

  double balance = principal;
  for (int day = 1; day <= days; day++) {
    if (day % interval == 0) balance += contribution;
    if (r != 0) balance += balance * r;
  }
  return balance;
}

/// How many contributions a savings plan of [years] makes at
/// [contributionIntervalDays] per contribution.
int savingsContributionCount({
  required int years,
  required int contributionIntervalDays,
}) {
  if (years <= 0) return 0;
  final int interval =
      contributionIntervalDays < 1 ? 1 : contributionIntervalDays;
  return (years * 365) ~/ interval;
}

/// Total amount contributed (principal + every periodic contribution).
double savingsTotalContributed({
  required double principal,
  required double contribution,
  required int years,
  required int contributionIntervalDays,
}) =>
    principal +
    contribution *
        savingsContributionCount(
          years: years,
          contributionIntervalDays: contributionIntervalDays,
        );

double _pow(double base, int exponent) {
  if (exponent <= 0) return 1;
  var result = 1.0;
  for (int i = 0; i < exponent; i++) {
    result *= base;
  }
  return result;
}
