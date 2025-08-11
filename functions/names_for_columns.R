# Define a named vector with the new column labels
names_for_columns <- c(
  "Predictors" = "Predictor Variable",
  "df" = "Degrees of Freedom",
  "AIC_incr_if_drop" = "AIC Increase if Dropped",
  "LRT" = "Likelihood Ratio Test",
  "p_value" = "p-value",
  "p.value" = "p-value")

names_for_columns_latex <- c( ### Use this with the kable tables with Drop1/AIC info
  "Predictors" = "\\shortstack{\\textsc{Predictor} \\\\ \\textsc{Variable}}",
  # "df" = "\\shortstack{\\textsc{Degrees} \\\\ \\textsc{of Freedom}}",
  "AIC Increase if Dropped" = "\\shortstack{\\textsc{AIC Increase} \\\\ \\textsc{if Dropped}}",
  # "LRT" = "\\shortstack{\\textsc{Likelihood} \\\\ \\textsc{Ratio Test}}",
  "p-value" = "\\shortstack{\\textsc{p-value} \\\\ \\textsc{}}")





