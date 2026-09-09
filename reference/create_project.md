# Scaffold a new research project

Creates a project of one of two archetypes:

- `"analysis"` - builds the `code/` + `data/` + `output/` skeleton via
  [`make_file_dirs()`](https://imbroglio-dc.github.io/dctools/reference/make_file_dirs.md)
  and writes the project mechanics directly (a PHI-aware `.gitignore`,
  an `renv`-activation `.Rprofile`, `<name>.Rproj`, a README stub, the
  `memos/` state stack, and an optional `targets` pipeline stub). No
  per-project feedback log is written: feedback about a reusable
  capability (a skill, plugin, or command) belongs in the repo that owns
  that capability (e.g. this package's own `workflow-feedback.md`, or
  `biostat-support`'s), not scattered across every analysis project that
  happens to use it. It writes **no** `CLAUDE.md` and **no** `.claude/`:
  the `project-setup` skill (biostat plugin) writes both the router and
  the traveling `.claude/hooks/` guard set, copied from the plugin's own
  canonical copy (`plugins/biostat/hooks/`) — not from an installed
  kernel. PHI protection that must travel with the repo regardless lives
  in the `.gitignore` (raw/derived data and data extensions are
  ignored).

- `"package"` - wraps
  [`usethis::create_package()`](https://usethis.r-lib.org/reference/create_package.html)
  and layers the package best-practices set (MIT license, testthat 3,
  roxygen markdown, pkgdown, R-CMD-check + coverage + pkgdown GitHub
  Actions, NEWS, self-contained `.claude/`).

## Usage

``` r
create_project(
  name,
  path = ".",
  type = c("analysis", "package"),
  targets = FALSE,
  git = TRUE
)
```

## Arguments

- name:

  Project name (also the new directory name).

- path:

  Parent directory in which to create the project (default ".").

- type:

  `"analysis"` or `"package"`.

- targets:

  Logical; for analysis projects, scaffold a `_targets.R` stub.

- git:

  Logical; initialise a fresh git repository (default `TRUE`).

## Value

The created project path, invisibly.

## See also

The `project-setup` skill (biostat marketplace), which calls this to
scaffold mechanics and then generates the project router.
