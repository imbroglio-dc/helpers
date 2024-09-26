make_file_dirs <- function(wd = NULL, data = TRUE, R = TRUE, output = TRUE,
                           docs = TRUE, scratch = TRUE, ...) {
  args <- list(...)
  if (!is.null(wd)) {
    setwd(wd)
  } else {
    wd <- getwd()
  }
  if (data & !dir.exists(paste0(wd, "/data/")))
    dir.create(paste0(wd, "/data/"))
  if (R & !dir.exists(paste0(wd, "/R/")))
    dir.create(paste0(wd, "/R/"))
  if (output & !dir.exists(paste0(wd, "/output/")))
    dir.create(paste0(wd, "/output/"))
  if (docs & !dir.exists(paste0(wd, "/docs/")))
    dir.create(paste0(wd, "/docs/"))
  if (scratch & !dir.exists(paste0(wd, "/scratch/"))){
    dir.create(paste0(wd, "/scratch/"))
    if (!file.exists(".gitignore") | 
        !any(grepl("scratch", try(readLines(".gitignore")), ignore.case = TRUE)))
      write(x = "\n # Scratch folder \n scratch/ \n", file = ".gitignore", append = TRUE)
  }

  if (!is.null(args)) {
    sapply(args, function(x) {
      if (docs & !dir.exists(paste0(wd, x, "/")))
        dir.create(paste0(wd, x, "/"))
      NULL
    })
  }
  NULL
}
