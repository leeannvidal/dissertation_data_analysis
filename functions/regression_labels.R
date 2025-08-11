# regression_labels.R

# Function: create_regression_label
# Description: Creates a significance label for regression models based on R-squared and p-value.
# Usage: Pass a summary of a linear model to the function.
# Example: create_regression_label(summary(lm_model))

create_regression_label <- function(model_summary) {
  # Extract R-squared and p-value
  r_squared <- model_summary$r.squared
  p_value <- model_summary$coefficients[2, 4]  # p-value for the slope (PLUS)
  
  # Determine the significance level
  if (p_value < 0.001) {
    label <- sprintf("R² = %.2f \n p-value < 0.001 ***", r_squared)
  } else if (p_value < 0.05) {
    label <- sprintf("R² = %.2f,\n p-value < 0.05 **", r_squared)
  } else if (p_value < 0.1) {
    label <- sprintf("R² = %.2f, \n p-value < 0.1 *", r_squared)
  } else {
    label <- sprintf("R² = %.2f, \n p-value = %.2f", r_squared, p_value)
  }
  
  return(label)
}

# Function: create_adjusted_regression_label
# Description: Creates and formats R² and p-value label for ggplot annotations, tailored for ggarrange.
# Usage: Pass a summary of a linear model and optional size parameter to adjust label size.
# Example: create_adjusted_regression_label(summary(lm_model), size = 3)

create_adjusted_regression_label <- function(model_summary, size = 2.5) {
  r_squared <- model_summary$r.squared
  p_value <- model_summary$coefficients[2, 4]  # Assuming index 2, 4 is correct for p-value
  
  label_text <- if (p_value < 0.001) {
    sprintf("R² = %.2f, p < 0.001***", r_squared)
  } else if (p_value < 0.05) {
    sprintf("R² = %.2f, p < 0.05**", r_squared)
  } else if (p_value < 0.1) {
    sprintf("R² = %.2f, p < 0.1*", r_squared)
  } else {
    sprintf("R² = %.2f, p = %.2f", r_squared, p_value)
  }
  
  # Add annotate with custom size
  annotate("label", x = 0, y = Inf, label = label_text,
           hjust = -0.005, vjust = 1, size = size, color = "black",
           label.size = NA, fill = "lightblue", fontface = "bold", 
           label.padding = unit(1, "lines"))
}