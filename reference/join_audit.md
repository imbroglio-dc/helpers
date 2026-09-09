# Join with a declared contract and an audit trail

A strict-join wrapper: runs a dplyr join with the `relationship` /
`unmatched` / `na_matches` contract set explicitly, and returns the
joined data with a before/after row-count and match-rate audit trail
attached. It turns the merge-time failure
[`check_unique_id()`](https://imbroglio-dc.github.io/dctools/reference/check_unique_id.md)
cannot see — a join that should be 1:1 but silently inflates rows — into
a reported number, or, if you declare `relationship`, an immediate
error.

## Usage

``` r
join_audit(
  left,
  right,
  by,
  type = c("left", "inner", "right", "full"),
  relationship = NULL,
  unmatched = "drop",
  na_matches = "never",
  quiet = FALSE
)
```

## Arguments

- left, right:

  Data frames to join.

- by:

  Character vector of key column name(s), present in both frames.

- type:

  Join type: `"left"` (default), `"inner"`, `"right"`, or `"full"`.

- relationship, unmatched, na_matches:

  Passed to the underlying dplyr join. `relationship` (e.g.
  `"one-to-one"`, `"many-to-one"`) errors on violation; `unmatched`
  defaults to `"drop"`; `na_matches` defaults to `"never"`.

- quiet:

  Logical; suppress the audit message (the trail is still attached).

## Value

The joined data frame, with a one-row audit data frame attached as
`attr(x, "join_audit")` (columns `type`, `by`, `left_n`, `right_n`,
`joined_n`, `matched_left`, `unmatched_left`, `unmatched_right`,
`match_rate`).

## Details

`na_matches` defaults to `"never"` (safer than dplyr's `"na"`): two rows
with `NA` keys are not the same entity. For a `left`/`inner` join, a
grown row count is flagged as a warning — the usual sign of duplicate
keys on the right.

## See also

[`check_unique_id()`](https://imbroglio-dc.github.io/dctools/reference/check_unique_id.md)
for the single-table key check.

## Examples

``` r
left <- data.frame(id = 1:3, x = c("a", "b", "c"))
right <- data.frame(id = 1:2, y = c(10, 20))
j <- join_audit(left, right, by = "id")
#> ℹ join_audit (left): 3 rows; 66.7% left match (2/3); 1 left / 0 right unmatched.
attr(j, "join_audit")
#>   type by left_n right_n joined_n matched_left unmatched_left unmatched_right
#> 1 left id      3       2        3            2              1               0
#>   match_rate
#> 1  0.6666667
```
