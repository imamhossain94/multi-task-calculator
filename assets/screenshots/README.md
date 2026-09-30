# Screenshots

Drop the app screenshots in this folder. `README.md` references them by the
filenames listed below, in that order.

| File | Screen | In top-level README |
| --- | --- | :---: |
| `01-home.png` | Home screen with the calculator grid | yes |
| `02-general-calculator.png` | General calculator (expression + result) | yes |
| `03-scientific-functions.png` | General calculator with the scientific row open | yes |
| `04-history.png` | Saved calculation history | yes |
| `05-currency-converter.png` | Currency converter with the rate list | yes |
| `06-unit-converter.png` | Unit converter category grid | yes |
| `07-unit-converter-child.png` | A unit category, e.g. Length | yes |
| `08-number-base.png` | Number base converter | yes |
| `09-tip-calculator.png` | Tip calculator with tax and split | yes |
| `10-discount-calculator.png` | Discount calculator | yes |
| `11-sales-tax.png` | Sales tax calculator | yes |
| `12-loan-calculator.png` | Loan calculator, Monthly Cost mode | yes |
| `14-savings.png` | Savings calculator | yes |
| `15-health.png` | Health calculator (BMI + BMR) | yes |
| `16-fuel-cost.png` | Fuel cost calculator | yes |
| `17-fuel-efficiency.png` | Fuel efficiency calculator | yes |
| `18-date-calculator.png` | Date calculator | yes |
| `19-unit-price.png` | Unit price comparison table | yes |
| `22-about.png` | About screen | no |
| `24-update-check.png` | Software update screen | no |

The numbering has gaps (no 13, 20, 21 or 23) because those captures were
dropped when the README gallery was trimmed. Renumber them if you would rather
the sequence were contiguous.

## Tips for good screenshots

- Capture at 1080 × 2340 (or any 9:19.5 ratio) so the phone frames line up.
- Fill the inputs with realistic values — a screenshot full of `0.00` does not
  sell the app. Tap the fields rather than guessing coordinates; `adb shell
  uiautomator dump` reports the exact bounds of every Flutter `TextField`.
- Watch out for the soft keyboard: it covers the lower half of the screen and
  the layout shifts when it opens. Dismiss it (only when
  `dumpsys input_method` reports `mInputShown=true`, or BACK pops the route)
  before capturing.

## Status

All 20 images are committed. The 18 marked "yes" above are referenced from the
top-level `README.md`; `22-about` and `24-update-check` are kept here only.
