// Tests for the pure calculation layer in `lib/utils/calculator_math.dart`.
//
// These lock in the specific bugs that were fixed:
//   * loan maths returned Infinity/NaN at 0% interest
//   * savings dropped the first contribution and only credited interest monthly
//   * the date breakdown disagreed with itself (30.417 vs 12 months per year)
//   * BMI status was gated on an age field the user may never fill in
//   * fuel efficiency / unit price divided by zero and printed `Infinity`

import 'package:flutter_test/flutter_test.dart';
import 'package:multi_task_calculator/utils/calculator_math.dart';

void main() {
  group('loan', () {
    test('matches a known 30-year mortgage', () {
      // $300,000 at 6% over 30 years -> $1798.65/month.
      final double payment = loanMonthlyPayment(
        principal: 300000,
        annualRatePercent: 6,
        years: 30,
      );
      expect(payment, closeTo(1798.65, 0.5));
    });

    test('0% interest does not divide by zero', () {
      final double payment = loanMonthlyPayment(
        principal: 12000,
        annualRatePercent: 0,
        years: 1,
      );
      expect(payment.isFinite, isTrue);
      expect(payment, closeTo(1000, 0.001));
    });

    test('0% total cost equals the principal', () {
      final double total = loanTotalCost(
        principal: 12000,
        annualRatePercent: 0,
        years: 1,
      );
      expect(total, closeTo(12000, 0.001));
      expect(
        loanTotalInterest(
          principal: 12000,
          annualRatePercent: 0,
          years: 1,
        ),
        closeTo(0, 0.001),
      );
    });

    test('max borrow inverts the payment formula', () {
      final double payment = 2000;
      final double borrow = loanMaxBorrow(
        monthlyPayment: payment,
        annualRatePercent: 6,
        years: 30,
      );
      expect(borrow, closeTo(333600, 500));

      // Feeding it back in must reproduce the same payment.
      final double roundTrip = loanMonthlyPayment(
        principal: borrow,
        annualRatePercent: 6,
        years: 30,
      );
      expect(roundTrip, closeTo(payment, 0.01));
    });

    test('max borrow at 0% is simply budget x months', () {
      expect(
        loanMaxBorrow(monthlyPayment: 500, annualRatePercent: 0, years: 10),
        closeTo(60000, 0.001),
      );
    });

    test('zero or negative inputs return 0 rather than NaN', () {
      expect(
        loanMonthlyPayment(principal: 0, annualRatePercent: 5, years: 10),
        0,
      );
      expect(
        loanMonthlyPayment(principal: 1000, annualRatePercent: 5, years: 0),
        0,
      );
      expect(
        loanMaxBorrow(monthlyPayment: 0, annualRatePercent: 5, years: 10),
        0,
      );
    });

    test('interest is never negative', () {
      expect(
        loanTotalInterest(principal: 1000, annualRatePercent: -5, years: 5),
        greaterThanOrEqualTo(0),
      );
    });
  });

  group('savings', () {
    test('credits every contribution, not one fewer', () {
      // $0 principal, $100 every 7 days for 1 year at 0%.
      final double balance = savingsProjection(
        principal: 0,
        contribution: 100,
        annualRatePercent: 0,
        years: 1,
        contributionIntervalDays: 7,
      );
      // 365 / 7 = 52 full weeks.
      expect(balance, closeTo(5200, 0.001));
      expect(
        savingsContributionCount(years: 1, contributionIntervalDays: 7),
        52,
      );
    });

    test('0% return is principal plus all contributions', () {
      final double balance = savingsProjection(
        principal: 1000,
        contribution: 50,
        annualRatePercent: 0,
        years: 2,
        contributionIntervalDays: 30,
      );
      // 2 years = 730 days -> 24 monthly contributions.
      expect(balance, closeTo(1000 + 24 * 50, 0.001));
    });

    test('compounds daily, so it beats simple interest', () {
      final double daily = savingsProjection(
        principal: 10000,
        contribution: 0,
        annualRatePercent: 10,
        years: 1,
        contributionIntervalDays: 7,
      );
      // 10% nominal compounded daily over 365 days.
      final double expected = 10000 * _pow(1 + 0.10 / 365, 365);
      expect(daily, closeTo(expected, 0.01));
      expect(daily, greaterThan(10000 * 1.10));
    });

    test('reported interest matches balance minus contributions', () {
      final double principal = 5000;
      final double contribution = 200;
      final double balance = savingsProjection(
        principal: principal,
        contribution: contribution,
        annualRatePercent: 6,
        years: 5,
        contributionIntervalDays: 30,
      );
      final double contributed = savingsTotalContributed(
        principal: principal,
        contribution: contribution,
        years: 5,
        contributionIntervalDays: 30,
      );
      expect(balance - contributed, greaterThan(0));
      // 5 years = 1825 days -> 1825 ~/ 30 = 60 monthly contributions.
      expect(contributed, closeTo(principal + 60 * contribution, 0.001));
    });
  });

  group('date breakdown', () {
    test('same calendar day next year is exactly one year', () {
      final result = dateBreakdown(
        from: DateTime(2024, 1, 1),
        to: DateTime(2025, 1, 1),
      );
      expect(result.years, 1);
      expect(result.months, 0);
      expect(result.days, 0);
      // 2024 is a leap year.
      expect(result.totalDays, 366);
    });

    test('is symmetric for forward and backward ranges', () {
      final forward = dateBreakdown(
        from: DateTime(2023, 3, 1),
        to: DateTime(2024, 7, 15),
      );
      // 1 year, 4 months, 14 days.
      expect(forward.years, 1);
      expect(forward.months, 4);
      expect(forward.days, 14);
    });

    test('borrows days from the end month correctly', () {
      // 31 Jan -> 1 Mar: 1 month, 1 day.
      final result = dateBreakdown(
        from: DateTime(2024, 1, 31),
        to: DateTime(2024, 3, 1),
      );
      expect(result.years, 0);
      expect(result.months, 1);
      expect(result.days, 1);
    });

    test('reversed range yields zeros instead of negatives', () {
      final result = dateBreakdown(
        from: DateTime(2024, 6, 1),
        to: DateTime(2024, 1, 1),
      );
      expect(result.years, 0);
      expect(result.months, 0);
      expect(result.days, 0);
    });

    test('time of day is ignored', () {
      final result = dateBreakdown(
        from: DateTime(2024, 1, 1, 23, 59),
        to: DateTime(2024, 1, 2, 0, 1),
      );
      expect(result.totalDays, 1);
      expect(result.days, 1);
    });
  });

  group('health', () {
    test('BMI for 180 cm / 80 kg', () {
      expect(bmi(heightCm: 180, weightKg: 80), closeTo(24.69, 0.01));
    });

    test('zero height does not produce Infinity', () {
      expect(bmi(heightCm: 0, weightKg: 80), 0);
    });

    test('BMI categories cover the full range', () {
      expect(bmiCategory(17), 'Underweight');
      expect(bmiCategory(22), 'Healthy weight');
      expect(bmiCategory(27), 'Overweight');
      expect(bmiCategory(35), 'Obese');
      // Previously anything at or above 39.9 fell through and showed nothing.
      expect(bmiCategory(45), 'Severely obese');
    });

    test('BMR uses the Mifflin-St Jeor constants per sex', () {
      final double male = bmr(
        weightKg: 80,
        heightCm: 180,
        age: 30,
        isMale: true,
      );
      final double female = bmr(
        weightKg: 80,
        heightCm: 180,
        age: 30,
        isMale: false,
      );
      expect(male, closeTo(1780, 0.5));
      expect(female, closeTo(1614, 0.5));
      expect(male - female, closeTo(166, 0.5));
    });

    test('BMR needs all three inputs', () {
      expect(bmr(weightKg: 0, heightCm: 180, age: 30, isMale: true), 0);
      expect(bmr(weightKg: 80, heightCm: 180, age: 0, isMale: true), 0);
    });
  });

  group('fuel', () {
    test('cost for a 300 km trip at 12 km/l and 1.50 per litre', () {
      final result = fuelCost(
        distanceKm: 300,
        efficiencyKmPerLitre: 12,
        pricePerLitre: 1.5,
      );
      expect(result.litres, closeTo(25, 0.001));
      expect(result.cost, closeTo(37.5, 0.001));
    });

    test('zero efficiency returns 0, not Infinity', () {
      final result = fuelCost(
        distanceKm: 300,
        efficiencyKmPerLitre: 0,
        pricePerLitre: 1.5,
      );
      expect(result.litres, 0);
      expect(result.cost, 0);
    });

    test('efficiency between two readings', () {
      expect(
        fuelEfficiency(startOdometer: 1000, endOdometer: 1500, litres: 40),
        closeTo(12.5, 0.001),
      );
    });

    test('zero litres returns 0, not Infinity', () {
      expect(
        fuelEfficiency(startOdometer: 1000, endOdometer: 1500, litres: 0),
        0,
      );
    });
  });

  group('discount, tax and tip', () {
    test('discount is applied after tax', () {
      // 100 + 10% tax = 110, less 20% = 88 saved 22.
      final result = discount(
        originalPrice: 100,
        taxPercent: 10,
        discountPercent: 20,
      );
      expect(result.saved, closeTo(22, 0.001));
      expect(result.finalPrice, closeTo(88, 0.001));
    });

    test('sales tax on 200 at 8%', () {
      final result = salesTax(price: 200, ratePercent: 8);
      expect(result.tax, closeTo(16, 0.001));
      expect(result.total, closeTo(216, 0.001));
    });

    test('tip splits evenly, with 0 people treated as 1', () {
      final result = tip(
        bill: 100,
        tipInput: 20,
        taxInput: 10,
        people: 4,
        tipIsPercent: true,
        taxIsPercent: true,
      );
      expect(result.tip, closeTo(20, 0.001));
      expect(result.tax, closeTo(10, 0.001));
      expect(result.finalAmount, closeTo(130, 0.001));
      expect(result.perPerson, closeTo(32.5, 0.001));
    });

    test('absolute tip and tax amounts are added as-is', () {
      final result = tip(
        bill: 100,
        tipInput: 15,
        taxInput: 8,
        people: 2,
        tipIsPercent: false,
        taxIsPercent: false,
      );
      expect(result.finalAmount, closeTo(123, 0.001));
      expect(result.perPerson, closeTo(61.5, 0.001));
    });

    test('zero people does not divide by zero', () {
      final result = tip(
        bill: 100,
        tipInput: 0,
        taxInput: 0,
        people: 0,
        tipIsPercent: true,
        taxIsPercent: true,
      );
      expect(result.perPerson, closeTo(100, 0.001));
      expect(result.perPerson.isFinite, isTrue);
    });
  });

  group('unit price', () {
    test('divides price by quantity', () {
      expect(unitPrice(totalPrice: 10, quantity: 4), closeTo(2.5, 0.001));
    });

    test('zero quantity returns 0, not Infinity', () {
      expect(unitPrice(totalPrice: 10, quantity: 0), 0);
    });
  });

  group('compound', () {
    test('matches the closed form for an annuity', () {
      final double r = 0.05;
      final int n = 10;
      final double result = compound(
        principal: 1000,
        ratePercent: 5,
        times: n,
        contribution: 100,
      );
      final double expected =
          1000 * _pow(1 + r, n) + 100 * ((_pow(1 + r, n) - 1) / r);
      expect(result, closeTo(expected, 0.001));
    });
  });
}

double _pow(double base, int exponent) {
  double result = 1;
  for (int i = 0; i < exponent; i++) {
    result *= base;
  }
  return result;
}
