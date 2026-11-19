# examly 0.5

* Added Classic, Academic, and Dark themes with a remembered selection.
* Corrected the upper/lower 27% item discrimination column heading in the item statistics table and report.

# examly 0.4

* Updated the Shiny interface with modern cards, clearer tables, and scrollable panels.
* Redesigned item type selection into a card-based layout.
* Added optional item learning outcomes and displayed them in the most missed items ranking.
* Kept student-level weak item output focused on item names for readability.
* Added corrected item-total discrimination labeling, KR-20 display for all multiple-choice/binary forms, and total-score skewness/kurtosis to the summary.
* Added optional school and class fields to the upload screen and included them in Word reports.
* Moved package, developer, version update, and citation information into a dedicated About button next to Reports.

# examly 0.2.0

* **New Feature:** Added "Select All" / "Deselect All" links for faster item type classification in the Shiny interface.
* **New Feature:** Added a "Distribute Weights" button to automatically equalize item weights out of 100.
* **Enhancement:** Split discrimination statistics into two distinct columns: Correlation-based ($r_{jx}$) and Upper/Lower 27% difference ($D$).
* **Enhancement:** Added literature-based interpretation tables and color-coded comments for item difficulty and discrimination values.
* **Bug Fix:** Improved the text parsing logic for pasted answer keys to better handle spaces and separators.

# examly 0.1.2

* Fixed a critical bug (present in v0.1.1) that prevented key analysis outputs from rendering in the Shiny interface. This fix restores the following components:
    * Summary tables (most correct, incorrect, and skipped items).
    * Student count for scores 50 and above.
    * Bar chart for student score ranges.

# examly 0.1.1

* Initial release to CRAN.
