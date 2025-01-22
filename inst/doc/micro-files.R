## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----include = FALSE----------------------------------------------------------
set.seed(0)
micro_dir <- file.path("micro_files")
unlink(micro_dir, recursive = TRUE)

## -----------------------------------------------------------------------------
library(pxmake)

greenlanders |> dplyr::sample_n(10) |> dplyr::arrange_all()

## -----------------------------------------------------------------------------
# Create px object
x <- px(greenlanders)

# Create folder for micro files
micro_dir <- file.path("micro_files")
dir.create(micro_dir)

# Write micro files to folder
px_micro(x, out_dir = micro_dir)

## -----------------------------------------------------------------------------
list.files(micro_dir)

## -----------------------------------------------------------------------------
# Print HEADING variables
px_heading(x)

# Print non-HEADING variables
c(px_stub(x), px_figures(x))

## -----------------------------------------------------------------------------
x2 <-
  x |>
  px_stub('age') |>    # Change age to STUB
  px_heading('cohort') # Change cohort to HEADING

## -----------------------------------------------------------------------------
# Clear folder
unlink(file.path(micro_dir, "*.px"))

px_micro(x2, out_dir = micro_dir)

## -----------------------------------------------------------------------------
list.files(micro_dir)

## -----------------------------------------------------------------------------
px(file.path(micro_dir, 'age.px'))$data

px(file.path(micro_dir, 'gender.px'))$data

px(file.path(micro_dir, 'municipality.px'))$data

## ----eval = FALSE-------------------------------------------------------------
#  # Change CONTACT in all micro files
#  x2 |>
#    px_contact("Johan Ejstrud") |>
#    px_micro(out_dir = micro_dir)

## -----------------------------------------------------------------------------
individual_keywords <- tibble::tribble(~variable     ,      ~px_description,
                                       "age"         ,    "Age count 18-99",
                                       "gender"      ,       "Gender count",
                                       "municipality",  "Municipality 2024"
                                       )

## -----------------------------------------------------------------------------
px_micro(x2, out_dir = micro_dir, keyword_values = individual_keywords)

## -----------------------------------------------------------------------------
px(file.path(micro_dir, 'age.px')) %>% px_description()
px(file.path(micro_dir, 'gender.px')) %>% px_description()
px(file.path(micro_dir, 'municipality.px')) %>% px_description()

## -----------------------------------------------------------------------------
x3 <-
  x2 |>
  px_language("en") |>
  px_languages(c("en", "kl"))


individual_keywords_ml <- 
  tibble::tribble(
       ~variable, ~language,     ~px_description, ~px_matrix,
           "age",      "en",   "Age count 18-99",      "AGE",
           "age",      "kl",       "Ukiut 18-99",         NA,
        "gender",      "en",      "Gender count",      "GEN",
        "gender",      "kl",      " Suiaassuseq",         NA,
  "municipality",      "en", "Municipality 2024",      "MUN",
  "municipality",      "kl",      "Kommuni 2024",         NA
  )

px_micro(x3, out_dir = micro_dir, keyword_values = individual_keywords_ml)

## -----------------------------------------------------------------------------
individual_keywords2 <- 
  individual_keywords |>
  dplyr::mutate(filename = paste0(variable, "_2024", ".px"))

# Clear folder
unlink(file.path(micro_dir, "*.px"))

px_micro(x2, out_dir = micro_dir, keyword_values = individual_keywords2)

list.files(micro_dir)

