help(stargazer)
library(dplyr)

# distinct(SPEAKER, PSEUDONYM, SEX, AGE, COUNTRY_OF_ORIGIN, AOA, PLUS, PERCENT_INTL_BOTH, PERCENT_INTL_SPAN_ONLY, PERCENT_INTL_ENG_ONLY) %>%
  

# Wrangle the data
summary_statistics_demographics_tbl_dissertation <- socio_df_diss %>%
  select(AGE, AOA, PLUS, PERCENT_INTL_BOTH, PERCENT_INTL_SPAN_ONLY, PERCENT_INTL_ENG_ONLY)
  
  
variable_names_summary_tables_stargazer <- c(
  "AGE" = "Age", 
  "AOA" = "AOA", 
  "PLUS" = "PLUS", 
  "PERCENT_INTL_BOTH" = "\\% English \\& Spanish", 
  "PERCENT_INTL_SPAN_ONLY" = "\\% Spanish Only", 
  "PERCENT_INTL_ENG_ONLY" = "\\% English Only"
)

summary_statistics_demographics_tbl_dissertation <- summary_statistics_demographics_tbl_dissertation %>%
  mutate(across(where(is.numeric), ~round(.x, 0)))  # Rounds all numeric columns to no decimal places


stargazer(summary_statistics_demographics_tbl_dissertation,
          summary.stat=c("mean","sd", "median", "max", "min"), 
          digits = 2,
          title = "Summary Statistics for Age, AOA, and Language Use Variables", 
          label = "tab:summary_statistics",
          covariate.labels = variable_names_summary_tables_stargazer
          )

stargazer(summary_statistics_demographics_tbl_dissertation)

# "\\% values indicate the percentage of time participants reported speaking each language with their interlocutors.", "AOA = Age of Arrival"

# \textsc{Age} & \textsc{AOA} & \textsc{PLUS} & \shortstack{\textsc{\% English} \\ \textsc{\& Spanish}} & \shortstack{\textsc{\% Spanish} \\ \textsc{Only}} & \shortstack{\textsc{\% English} \\ \textsc{Only}}\\

# \begin{tablenotes}
# \item[1] AOA = Age of Arrival
# \item[2] PLUS = Percent Life in the US
# \item[3] \% values indicate the percentage of time participants reported speaking each language with their interlocutors.
# \end{tablenotes}
