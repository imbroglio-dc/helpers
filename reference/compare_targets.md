# Compare computed results against documented targets at their tolerances

The mechanical half of a replication or reproducibility check: join each
computed value onto its target, take the signed difference, and mark
`PASS` / `FAIL` / `UNMATCHED` against the tolerance for that target's
`kind`. It returns the comparison *facts* only — the overall verdict
vocabulary (e.g. REPLICATED / PARTIAL / FAILED for a replication, PASS /
FAIL for a manuscript audit) is the calling skill's judgment, not this
function's.

## Usage

``` r
compare_targets(results, targets, tolerances = NULL, by = "target")
```

## Arguments

- results:

  Computed values: a data frame with the key column (`by`) and a `value`
  column, or a named numeric vector (names are keys).

- targets:

  Documented targets: a data frame with the key column (`by`), `value`
  (the reported value), `kind` (tolerance class), and optionally a
  per-row `tolerance` override.

- tolerances:

  Optional named list/vector mapping `kind` to a numeric tolerance;
  merged over (and so can extend or override) the defaults above.

- by:

  Name of the key column joining `results` to `targets` (default
  `"target"`).

## Value

A data frame, one row per target (in `targets` order), with columns
`<by>`, `kind`, `reported`, `computed`, `diff`, `tolerance`, and
`status` (`"PASS"`, `"FAIL"`, or `"UNMATCHED"`). `diff` and `tolerance`
are `NA` for p-value rows.

## Details

Tolerance for a row is resolved in order: an explicit non-`NA`
`tolerance` column on `targets` (absolute:
`abs(computed - reported) <= tolerance`); otherwise the entry in
`tolerances` for the row's `kind`. A `kind` of `"p_value"` is compared
by significance level (same bucket across the conventional 0.001 / 0.01
/ 0.05 cutpoints), not by numeric difference — encode p-values as their
actual value where known.

Defaults mirror the replication tolerance table (integers exact;
estimates `< 0.01`; SEs `< 0.05`; percentages `< 0.1` pp): `count = 0`,
`estimate = 0.01`, `se = 0.05`, `percentage = 0.1`,
`summary_stat = 0.01`.

## See also

The `estimation-diagnostics` skill (its `references/replication.md`),
which homes this helper, and the `audit-reproducibility` skill, which
uses it to check manuscript claims against pipeline outputs.

## Examples

``` r
targets <- data.frame(
  target = c("att", "N"), value = c(-1.632, 2847),
  kind = c("estimate", "count")
)
compare_targets(c(att = -1.628, N = 2847), targets)
#> ✔ compare_targets: 2 PASS, 0 FAIL, 0 unmatched.
#>   target     kind reported computed  diff tolerance status
#> 1    att estimate   -1.632   -1.628 0.004      0.01   PASS
#> 2      N    count 2847.000 2847.000 0.000      0.00   PASS
```
