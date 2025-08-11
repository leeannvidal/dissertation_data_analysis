#scripts/descriptive_tables/dem_tbl_dissertation.R

# Table: dem_tbl_dissertation
# Description: This table summarizes demographic information for the speakers included in the study.
#              The table lists the pseudonym, sex, age, and percent life in the US (PLUS) of each speaker.
#              The data is grouped by the country of origin (Dominican Republic and Puerto Rico) and 
#              arranged by PLUS within each group.
# Usage: The table is created by selecting unique speakers from the cleaned dataset, applying necessary
#        transformations to standardize the data, and then generating a formatted LaTeX table. While the result
#        is almost exactly what I want the output to be in LaTeX, I still made some minor changes in LaTeX, However,
#        this provides the most accurate output needed to re-produce the table.


# # Load necessary libraries
# library(dplyr)
# library(kableExtra)
# library(readr)
# library(stringr)
# 
# # Load cleaned data from liquids_cleaned.rds
# liquids <- readRDS("data/cleaned_data/liquids_cleaned.rds")

# Wrangle the data
dem_tbl <- liquids %>%
  # Select relevant columns and filter unique speakers
  distinct(PSEUDONYM, SEX, AGE, PLUS, COUNTRY_OF_ORIGIN) %>%
  # Rename 'SEX' and 'COUNTRY_OF_ORIGIN' columns for consistency
  mutate(
    COUNTRY_OF_ORIGIN = ifelse(COUNTRY_OF_ORIGIN == "pr", "Puerto Rico", "Dominican Republic"),
    SEX = ifelse(SEX == "female", "F", "M"),
    PSEUDONYM = str_to_title(PSEUDONYM) # Capitalize Pseudonym
  ) %>%
  # Arrange by COUNTRY_OF_ORIGIN and then by PLUS within each group
  group_by(COUNTRY_OF_ORIGIN) %>%
  arrange(PLUS, .by_group = TRUE) %>%
  ungroup() %>%
  # # Select relevant columns for the table
  select(PSEUDONYM, SEX, AGE, PLUS)

# Create the LaTeX table
dem_tbl %>%
  kbl("latex", booktabs = TRUE, digits = 2, escape = FALSE, align = c("l", "c", "c", "c"),
      col.names = c("\\textsc{Pseudonym}", "\\textsc{Sex}", "\\textsc{Age}", "\\textsc{PLUS}")) %>%
  kable_styling(latex_options = c("striped", "hold_position")) %>%
  column_spec(1, width = "9em") %>%
  pack_rows(index = c("Dominican Republic"= 11, "Puerto Rico" = 11), 
            bold = TRUE) %>%
  footnote(threeparttable = TRUE,
           fixed_small_size = FALSE, 
           number = c("PLUS = Percent Life in US", "Ernesto's parents are from the Dominican Republic and El Salvador")) %>%
  save_kable(file = "output/tables/descriptive/dem_tbl_dissertation.tex")

# Modify LaTeX code for font size and fix any spacing issues
latex_output <- read_lines("output/tables/descriptive/dem_tbl_dissertation.tex")
latex_output <- str_replace(latex_output, "\\\\centering", "\\\\centering\n\\\\fontsize{10}{11}\\\\selectfont")
write_lines(latex_output, "output/tables/descriptive/dem_tbl_dissertation.tex")