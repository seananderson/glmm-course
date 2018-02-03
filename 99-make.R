files <- list.files(".", pattern = "*.Rmd")
dir.create("exercises", showWarnings = FALSE)
remove_exercises <- function(x) {
  f <- readLines(x)
  i <- grep("```", f)[[1]] - 1
  f <- c(f[seq(1, i)],
    "```{r, include=FALSE, eval=TRUE}",
    "knitr::opts_chunk$set(root.dir = '..')",
    "```",
    "",
    f[seq(i+1, length(f))])
  f_ex <- ifelse(grepl("# exercise", f), "# exercise", f)
  f_ex <- ifelse(grepl("<!-- exercise -->", f_ex), "<!-- exercise -->", f_ex)
  writeLines(as.character(f_ex), con = file.path("exercises", x))
}
files <- files[!files == "05-random-intercepts.Rmd"] # temporary 2018-02-03
purrr::walk(files, remove_exercises)

## knit all exercises (slow)
# purrr::walk(files, rmarkdown::render)
