# functions/ttest_labels.R

# Remember that t-tests are for when comparing two groups of a categorical variable with  with a continuous variable

create_ttest_label <- function(ttest_result) {
  # Extract the relevant values from the t-test result
  t_statistic <- ttest_result$statistic
  df <- ttest_result$parameter
  p_value <- ttest_result$p.value
  
  # Determine the significance level
  if (p_value < 0.001) {
    label <- sprintf("t = %.2f,\n df = %.2f,\n p-value < 0.001 ***",
                     t_statistic, df)
  } else if (p_value < 0.01) {
    label <- sprintf("t = %.2f,\n df = %.2f,\n p-value < 0.01 **",
                     t_statistic, df)
  } else if (p_value < 0.05) {
    label <- sprintf("t = %.2f,\n df = %.2f,\n p-value < 0.05 *",
                     t_statistic, df)
  } else if (p_value < 0.1) {
    label <- sprintf("t = %.2f,\n df = %.2f,\n p-value < 0.1 .",
                     t_statistic, df)
  } else {
    label <- sprintf("t = %.2f,\n df = %.2f,\n p-value = %.2f",
                     t_statistic, df, p_value)
  }
  
  return(label)
}
