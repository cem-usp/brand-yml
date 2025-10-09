# Load Packages -----

library(here)
library(magrittr)
library(readr)
library(stringr)

# Update `brand.yml` File in `index.qmd` -----

start_pattern <- "%:::% brand.yml begin %:::%"
end_pattern <- "%:::% brand.yml end %:::%"

lines <- here("index.qmd") |> read_lines()

start_pattern_index <- str_which(lines, start_pattern)
end_pattern_index <- str_which(lines, end_pattern)

c(
  lines |> extract(seq(1, start_pattern_index)),
  '``` {.yml filename="brand.yml"}',
  read_lines(here("_brand.yml")),
  '```',
  lines |> extract(seq(end_pattern_index, length(lines)))
) |>
  write_lines(here("index.qmd"))
