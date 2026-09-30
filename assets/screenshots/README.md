# Screenshots

Drop the app screenshots in this folder. `README.md` references them by the
filenames listed below, in that order.

| File | Screen |
| --- | --- |
| `01-home.png` | Home screen with the calculator grid |
| `02-general-calculator.png` | General calculator (expression + result) |
| `03-scientific-functions.png` | General calculator with the scientific row open |
| `04-history.png` | Saved calculation history |
| `05-currency-converter.png` | Currency converter with the rate list |
| `06-unit-converter.png` | Unit converter category grid |
| `07-unit-converter-child.png` | A unit category, e.g. Length |
| `08-number-base.png` | Number base converter |
| `09-tip-calculator.png` | Tip calculator with tax and split |
| `10-discount-calculator.png` | Discount calculator |
| `11-sales-tax.png` | Sales tax calculator |
| `12-loan-calculator.png` | Loan calculator, Monthly Cost mode |
| `13-loan-maximum.png` | Loan calculator, Maximum Loan mode |
| `14-savings.png` | Savings calculator |
| `15-health.png` | Health calculator (BMI + BMR) |
| `16-fuel-cost.png` | Fuel cost calculator |
| `17-fuel-efficiency.png` | Fuel efficiency calculator |
| `18-date-calculator.png` | Date calculator |
| `19-unit-price.png` | Unit price comparison table |
| `20-theme-dark.png` | Any screen in dark mode |
| `21-drawer.png` | Navigation drawer |
| `22-about.png` | About screen |
| `23-help.png` | Help & FAQ |
| `24-update-check.png` | Software update screen |

## Tips for good screenshots

- Capture at 1080 × 2340 (or any 9:19.5 ratio) so the phone frames line up.
- Use a light-mode capture for the numbered sequence; add one dark-mode shot
  (`20-theme-dark.png`) to show the theme support.
- Fill the inputs with realistic values — a screenshot full of `0.00` does not
  sell the app. Tap the fields rather than guessing coordinates; `adb shell
  uiautomator dump` reports the exact bounds of every Flutter `TextField`.
- Watch out for the soft keyboard: it covers the lower half of the screen and
  the layout shifts when it opens. Dismiss it (only when
  `dumpsys input_method` reports `mInputShown=true`, or BACK pops the route)
  before capturing.

## Status

All 24 images are committed and referenced from the top-level `README.md`
except `13-loan-maximum`, `22-about` and `24-update-check`, which are kept here
for completeness.
