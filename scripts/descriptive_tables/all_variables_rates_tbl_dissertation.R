
# # Specify the range of column indices you want
start_col <- 1
end_col <- 36
# 
# # Print the column names within the range
# colnames(rates_all_variables)[start_col:end_col]
colnames(rates_all_variables)
# Loop through the selected range of columns
for (col in colnames(rates_all_variables)[start_col:end_col]) {
  cat("\nColumn:", col, "\n")
  
  if (is.factor(rates_all_variables[[col]])) {
    cat("Levels:", levels(rates_all_variables[[col]]), "\n")
  } else {
    cat("Unique values:", unique(rates_all_variables[[col]]), "\n")
  }
}

##ALL COLUMNS
# (SPEAKER, PSEUDONYM, PLUS, COUNTRY_OF_ORIGIN, REGIONAL_ORIGIN, IMMIGRATION_CATEGORY, PERCENT_INTL_SPAN_ONLY, PERCENT_INTL_ENG_ONLY, COUNT_ALL_LIQUIDS, RATE_MISMATCH_ALL_LIQUIDS, COUNT_FLAP, RATE_MISMATCH_TAP, COUNT_TAP_SUBSET, RATE_MISMATCH_TAP_SUBSET, COUNT_TRILL, RATE_MISMATCH_TRILL, COUNT_TRILL_SUBSET, RATE_MISMATCH_TRILL_SUBSET, COUNT_LATERAL, RATE_MISMATCH_LATERAL, COUNT_LATERAL_SUBSET, RATE_MISMATCH_LATERAL_SUBSET, COUNT_CODA_S_MISMATCH, RATE_MISMATCH_CODA_S, COUNT_CODA_S_DELETION, RATE_DELETION_CODA_S, COUNT_FPS, RATE_CENTRALIZED_FPS, COUNT_PRONOUNS, RATE_PRONOUNS_PRESENT, COUNT_PRONOUNS_POSITION, RATE_PREVERBAL_PRONOUNS, COUNT_GEN_SUBJECT_POSITION, RATE_GEN_PREVERBAL_SUBJECTS, COUNT_ALL_SUBJECT_POSITION, RATE_ALL_PREVERBAL_SUBJECTS)
##ALL BUT COUNT COLUMNS
# (SPEAKER, PSEUDONYM, PLUS, COUNTRY_OF_ORIGIN, REGIONAL_ORIGIN, IMMIGRATION_CATEGORY, PERCENT_INTL_SPAN_ONLY, PERCENT_INTL_ENG_ONLY, RATE_MISMATCH_ALL_LIQUIDS, RATE_MISMATCH_TAP, RATE_MISMATCH_TAP_SUBSET, RATE_MISMATCH_TRILL, RATE_MISMATCH_TRILL_SUBSET, RATE_MISMATCH_LATERAL, RATE_MISMATCH_LATERAL_SUBSET, RATE_MISMATCH_CODA_S, RATE_DELETION_CODA_S, RATE_CENTRALIZED_FPS, RATE_PRONOUNS_PRESENT, RATE_PREVERBAL_PRONOUNS, RATE_GEN_PREVERBAL_SUBJECTS, RATE_ALL_PREVERBAL_SUBJECTS)
## MINUS REGIONAL_ORIGIN RATE_PREVERBAL_PRONOUNS, RATE_GEN_PREVERBAL_SUBJECTS, RATE_ALL_PREVERBAL_SUBJECTS
# (SPEAKER, PSEUDONYM, PLUS, COUNTRY_OF_ORIGIN, IMMIGRATION_CATEGORY, PERCENT_INTL_SPAN_ONLY, PERCENT_INTL_ENG_ONLY, RATE_MISMATCH_ALL_LIQUIDS, RATE_MISMATCH_TAP, RATE_MISMATCH_TAP_SUBSET, RATE_MISMATCH_TRILL, RATE_MISMATCH_TRILL_SUBSET, RATE_MISMATCH_LATERAL, RATE_MISMATCH_LATERAL_SUBSET, RATE_MISMATCH_CODA_S, RATE_CENTRALIZED_FPS, RATE_PRONOUNS_PRESENT, RATE_ALL_PREVERBAL_SUBJECTS)

# Wrangle the data
rates_all_variables_tbl_dissertation <- rates_all_variables %>%
  # Select relevant columns and filter unique speakers
  distinct(SPEAKER, PSEUDONYM, COUNTRY_OF_ORIGIN, PLUS, IMMIGRATION_CATEGORY, PERCENT_INTL_SPAN_ONLY, PERCENT_INTL_ENG_ONLY, RATE_MISMATCH_ALL_LIQUIDS, RATE_MISMATCH_TAP, RATE_MISMATCH_TAP_SUBSET, RATE_MISMATCH_TRILL, RATE_MISMATCH_TRILL_SUBSET, RATE_MISMATCH_LATERAL, RATE_MISMATCH_LATERAL_SUBSET, RATE_MISMATCH_CODA_S, RATE_CENTRALIZED_FPS, RATE_PRONOUNS_PRESENT, RATE_ALL_PREVERBAL_SUBJECTS) %>%
  # Rename 'SEX' and 'COUNTRY_OF_ORIGIN' columns for consistency
  mutate(
    COUNTRY_OF_ORIGIN = ifelse(COUNTRY_OF_ORIGIN == "pr", "Puerto Rico", "Dominican Republic"),
    PSEUDONYM = str_to_title(PSEUDONYM), # Capitalize Pseudonym
    IMMIGRATION_CATEGORY = case_when(
      IMMIGRATION_CATEGORY == "est_immigrant" ~ "Established Immigrant",
      IMMIGRATION_CATEGORY == "recent_arrival" ~ "Recent Arrival",
      IMMIGRATION_CATEGORY == "us_born" ~ "US Born",
      TRUE ~ IMMIGRATION_CATEGORY # Keep original if no match
    )
  ) %>%
  # Arrange by COUNTRY_OF_ORIGIN and then by PLUS within each group
  group_by(COUNTRY_OF_ORIGIN) %>%
  arrange(PLUS, .by_group = TRUE) %>%
  ungroup() %>%
  # # Select relevant columns for the table
  select(PSEUDONYM, COUNTRY_OF_ORIGIN, RATE_MISMATCH_TAP, RATE_MISMATCH_TAP_SUBSET, RATE_MISMATCH_TRILL, RATE_MISMATCH_TRILL_SUBSET, RATE_MISMATCH_LATERAL, RATE_MISMATCH_LATERAL_SUBSET, RATE_MISMATCH_CODA_S, RATE_CENTRALIZED_FPS, RATE_PRONOUNS_PRESENT, RATE_ALL_PREVERBAL_SUBJECTS)
# select(PSEUDONYM, PLUS, COUNTRY_OF_ORIGIN, IMMIGRATION_CATEGORY, PERCENT_INTL_SPAN_ONLY, PERCENT_INTL_ENG_ONLY, RATE_MISMATCH_TAP, RATE_MISMATCH_TAP_SUBSET, RATE_MISMATCH_TRILL, RATE_MISMATCH_TRILL_SUBSET, RATE_MISMATCH_LATERAL, RATE_MISMATCH_LATERAL_SUBSET, RATE_MISMATCH_CODA_S, RATE_CENTRALIZED_FPS, RATE_PRONOUNS_PRESENT, RATE_ALL_PREVERBAL_SUBJECTS)

# Apply the function to rename columns
col_names <- replace_column_names(rates_all_variables_tbl_dissertation, variable_names_summary_tables_latex_shortstack)

# Remove COUNTRY_OF_ORIGIN from the table but store its values for pack_rows
table_grouping <- rates_all_variables_tbl_dissertation$COUNTRY_OF_ORIGIN

# Reorder the dataset so "Dominican Republic" is on top and "Puerto Rico" is at the bottom
# rates_all_variables_tbl_dissertation <- rates_all_variables_tbl_dissertation %>%
  # arrange(desc(COUNTRY_OF_ORIGIN))  # Sorting so "Dominican Republic" comes first

# # Properly round numbers and remove extra spaces before wrapping them in $$ with two decimal points
# rates_all_variables_tbl_dissertation <- rates_all_variables_tbl_dissertation %>%
#   mutate(across(where(is.numeric), ~ paste0("$", str_trim(format(round(., 2), nsmall = 2)), "$")))

# Properly round numbers UP and remove extra spaces before wrapping them in $$
rates_all_variables_tbl_dissertation <- rates_all_variables_tbl_dissertation %>%
  mutate(across(where(is.numeric), ~ paste0("$", str_trim(format(ceiling(.), nsmall = 0)), "$")))




# Generate the LaTeX table
rates_all_variables_tbl_dissertation %>%
  select(-COUNTRY_OF_ORIGIN) %>%  # Remove column but keep its grouping
  kbl("latex", booktabs = TRUE, digits = 2, escape = FALSE, align = "lcccccccccc",
      col.names = col_names[col_names != "\\shortstack{\\textsc{Country} \\\\ \\textsc{of Origin}}"]) %>%  # Exclude COUNTRY_OF_ORIGIN from headers
  kable_styling(latex_options = c("hold_position")) %>%
  column_spec(1, width = "9em") %>%
  pack_rows(index = table(table_grouping), bold = TRUE) %>%  # Use stored country grouping
  # add_header_above(c("Rates of Usage for Linguistic Variables by Speaker" = ncol(rates_all_variables_tbl_dissertation) - 1)) %>%  # Adjust for removed column
  footnote(threeparttable = TRUE,
           fixed_small_size = FALSE, 
           number = c("Rates indicate the proportion of usage per speaker")) %>%
  as.character() -> latex_table

# Wrap with custom LaTeX formatting
latex_table <- paste0(
  "\\begingroup
  \\fontsize{9}{10}\\selectfont
  \\rowcolors{2}{}{tablegray}
  \\renewcommand{\\arraystretch}{0.65}",
  latex_table,
  "\\endgroup"
)

# Print the LaTeX code
cat(latex_table)
