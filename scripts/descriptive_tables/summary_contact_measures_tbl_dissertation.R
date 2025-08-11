
# # Specify the range of column indices you want
start_col <- 1
end_col <- 112
# 
# # Print the column names within the range
# colnames(rates_all_variables)[start_col:end_col]
colnames(socio_df_diss)
# Loop through the selected range of columns
for (col in colnames(socio_df_diss)[start_col:end_col]) {
  cat("\nColumn:", col, "\n")
  
  if (is.factor(socio_df_diss[[col]])) {
    cat("Levels:", levels(socio_df_diss[[col]]), "\n")
  } else {
    cat("Unique values:", unique(socio_df_diss[[col]]), "\n")
  }
}

# (SPEAKER, PSEUDONYM, SEX, AGE, COUNTRY_OF_ORIGIN, AOA, N_YRS_US, N_YRS_BOS, PLUS, SOCIAL_CLASS, EDUCATION_LEVEL, IMMIGRATION_CATEGORY, PERCENT_INTL_BOTH, PERCENT_INTL_SPAN_ONLY, PERCENT_INTL_ENG_ONLY)

# Wrangle the data
summary_demographics_contact_measures_tbl_dissertation <- socio_df_diss %>%
  # Select relevant columns and filter unique speakers
  distinct(SPEAKER, PSEUDONYM, SEX, AGE, COUNTRY_OF_ORIGIN, AOA, N_YRS_US, N_YRS_BOS, PLUS, SOCIAL_CLASS, EDUCATION_LEVEL, IMMIGRATION_CATEGORY, PERCENT_INTL_BOTH, PERCENT_INTL_SPAN_ONLY, PERCENT_INTL_ENG_ONLY) %>%
  # Rename 'SEX' and 'COUNTRY_OF_ORIGIN' columns for consistency
  mutate(
    COUNTRY_OF_ORIGIN = ifelse(COUNTRY_OF_ORIGIN == "pr", "Puerto Rico", "Dominican Republic"),
    PSEUDONYM = str_to_title(PSEUDONYM), # Capitalize Pseudonym
    SEX = ifelse(SEX == "female", "F", "M"),
    IMMIGRATION_CATEGORY = case_when(
      IMMIGRATION_CATEGORY == "est_immigrant" ~ "established",
      IMMIGRATION_CATEGORY == "recent_arrival" ~ "recent arrival",
      IMMIGRATION_CATEGORY == "us_born" ~ "US born",
      TRUE ~ IMMIGRATION_CATEGORY # Keep original if no match
    )
  ) %>%
  # Arrange by COUNTRY_OF_ORIGIN and then by PLUS within each group
  group_by(COUNTRY_OF_ORIGIN) %>%
  arrange(PLUS, .by_group = TRUE) %>%
  ungroup() %>%
  # # Select relevant columns for the table
  # select(PSEUDONYM, SEX, AGE, COUNTRY_OF_ORIGIN, PLUS, IMMIGRATION_CATEGORY, PERCENT_INTL_BOTH, PERCENT_INTL_SPAN_ONLY, PERCENT_INTL_ENG_ONLY)
select(PSEUDONYM, SEX, AGE, COUNTRY_OF_ORIGIN, AOA, PLUS, IMMIGRATION_CATEGORY, PERCENT_INTL_BOTH, PERCENT_INTL_SPAN_ONLY, PERCENT_INTL_ENG_ONLY)


# Apply the function to rename columns
col_names <- replace_column_names(summary_demographics_contact_measures_tbl_dissertation, variable_names_summary_tables_latex_shortstack)

# Remove COUNTRY_OF_ORIGIN from the table but store its values for pack_rows
table_grouping <- summary_demographics_contact_measures_tbl_dissertation$COUNTRY_OF_ORIGIN

# Properly round numbers UP and remove extra spaces before wrapping them in $$
summary_demographics_contact_measures_tbl_dissertation <- summary_demographics_contact_measures_tbl_dissertation %>%
  mutate(across(where(is.numeric), ~ paste0("$", str_trim(format(ceiling(.), nsmall = 0)), "$")))

# Generate the LaTeX table
summary_demographics_contact_measures_tbl_dissertation %>%
  select(-COUNTRY_OF_ORIGIN) %>%  # Remove column but keep its grouping
  kbl("latex", booktabs = TRUE, escape = FALSE, align = "lccccccccc",
      col.names = col_names[col_names != "\\shortstack{\\textsc{Country} \\\\ \\textsc{of Origin}}"]) %>%  # Exclude COUNTRY_OF_ORIGIN from headers
  kable_styling(latex_options = c("hold_position")) %>%
  column_spec(1, width = "8em") %>%
  pack_rows(index = table(table_grouping), bold = TRUE) %>%  # Use stored country grouping
  footnote(threeparttable = TRUE,
           fixed_small_size = FALSE, 
           number = c("\\% values indicate the percentage of time participants reported speaking each language with their interlocutors.", "AOA = Age of Arrival")) %>%
  as.character() -> latex_table


# Print the LaTeX code
cat(latex_table)