## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(pxmake)

population_gl |>
  head(10) |>
  print()

## -----------------------------------------------------------------------------
x <- px(population_gl)

## -----------------------------------------------------------------------------
px_save(x, "population_gl.px")

## ----comment="", echo = FALSE-------------------------------------------------
readLines('population_gl.px') |> cat(sep = '\n')

## -----------------------------------------------------------------------------
x2 <- px("population_gl.px")

## -----------------------------------------------------------------------------
x3 <- px_title(x, "Population in Greenland")

## -----------------------------------------------------------------------------
x3 |>
  px_codepage("UTF-8") |> # Change file encoding  
  px_matrix("pop") |>
  px_contact("Johan Ejstrud") |>
  px_subject_code("GL") |>
  px_subject_area("Greenland") |>
  px_timeval("year") |>
  px_contents("Population in Greenland") |>
  px_units("People") |>
  px_note("See information about data: ?population_gl") |>
  px_last_updated(format(Sys.time(), "%Y%m%d %H:%M")) |>
  px_stub(c("age", "gender")) |> # Change order of STUB variables
  px_save("population_gl_modified.px")

## ----comment="", echo = FALSE-------------------------------------------------
readLines('population_gl_modified.px') |> cat(sep = '\n')

