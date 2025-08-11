
create_correlation_label <- function(cor_test_result) {
  # Extract correlation coefficient, p-value, and degrees of freedom
  correlation <- cor_test_result$estimate  # Pearson's r
  p_value <- cor_test_result$p.value
  df <- cor_test_result$parameter  # Degrees of freedom
  
  # Determine the significance level and format the label
  if (p_value < 0.001) {
    label <- sprintf("r(%d) = %.2f\np < .001 ***", df, correlation)
  } else if (p_value < 0.05) {
    label <- sprintf("r(%d) = %.2f\np < .05 **", df, correlation)
  } else if (p_value < 0.1) {
    label <- sprintf("r(%d) = %.2f\np < .1 *", df, correlation)
  } else {
    label <- sprintf("r(%d) = %.2f\np = %.2f", df, correlation, p_value)
  }
  
  return(label)
}
# 
# ### Italic r and p - didnt work. fix later
# 
# create_correlation_label <- function(cor_test_result, format = "markdown") {
#   # Extract correlation coefficient, p-value, and degrees of freedom
#   correlation <- cor_test_result$estimate  # Pearson's r
#   p_value <- cor_test_result$p.value
#   df <- cor_test_result$parameter  # Degrees of freedom
#   
#   # Prepare LaTeX/Markdown formatting for italics
#   italic_r <- if (format == "latex") "\\textit{r}" else "*r*"
#   italic_p <- if (format == "latex") "\\textit{p}" else "*p*"
#   
#   # Determine the significance level and format the label
#   if (p_value < 0.001) {
#     label <- sprintf("%s(%d) = %.2f\n%s < .001 ***", italic_r, df, correlation, italic_p)
#   } else if (p_value < 0.05) {
#     label <- sprintf("%s(%d) = %.2f\n%s < .05 **", italic_r, df, correlation, italic_p)
#   } else if (p_value < 0.1) {
#     label <- sprintf("%s(%d) = %.2f\n%s < .1 *", italic_r, df, correlation, italic_p)
#   } else {
#     label <- sprintf("%s(%d) = %.2f\n%s = %.2f", italic_r, df, correlation, italic_p, p_value)
#   }
#   
#   return(label)
# }
# 
