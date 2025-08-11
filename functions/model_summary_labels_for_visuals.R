# model_summary_labels_for_visuals.R

# Function: get_estimate_and_pvalues
# Description: Creates a significance label for regression models based on estimate and p-value.
# Usage: Pass a summary of a linear model to the function.
# # Examples: 
# # # Example where the model is loaded from disk
# # label <- get_estimate_and_pvalues(predictor = "COUNTRY_OF_ORIGINpr", model_path = "path_to_save/model_name.rds")
# # print(label)
# # # Example where the model is passed directly
# # trill_model <- readRDS("data/regressions/best_model_trill.rds")
# # label <- get_estimate_and_pvalues(model = trill_model, predictor = "COUNTRY_OF_ORIGINpr")
# # print(label)

# library(dplyr)
# library(parameters)

# Function to load or run a model and extract beta/p-values for a predictor
get_estimate_and_pvalues <- function(model = NULL, predictor, model_path = NULL) {
  
  # Load model if the path is provided
  if (!is.null(model_path)) {
    model <- readRDS(model_path)
  } 
  
  # Check if the model is provided either directly or by loading
  if (is.null(model)) {
    stop("Model is not provided or cannot be loaded.")
  }
  
  # Extract summary of the model
  model_summary <- model_parameters(model, ci = 0.95, exponentiate = FALSE, effects = "fixed")
  
  # Filter for the specific predictor
  predictor_summary <- model_summary %>%
    filter(Parameter == predictor)
  
  # Check if predictor exists in model summary
  if (nrow(predictor_summary) == 0) {
    stop("Predictor variable not found in the model.")
  }
  
  # Extract the estimate and p-value
  estimate <- as.numeric(predictor_summary$Coefficient)
  p_value <- as.numeric(predictor_summary$p)
  
  # Print values to check if they're correctly extracted
  print(paste("Estimate:", estimate))
  print(paste("P-value:", p_value))
  
  # Helper function to remove leading zeros AFTER rounding
  remove_leading_zeros <- function(x) {
    result <- gsub("^(-?)0\\.", "\\1.", x)
    return(result)
  }
  
  # Format estimate and p-value without leading zeros
  formatted_estimate <- round(estimate, 2)  # round first
  formatted_p_value <- round(p_value, 2)    # round first
  
  # Convert to character with leading zeros removed
  formatted_p_value <- remove_leading_zeros(as.character(formatted_p_value))
  
  # Construct the label based on significance level
  if (p_value < 0.001) {
    label <- sprintf("\u03B2 = %.2f \n p < .001 ***", formatted_estimate)
  } else if (p_value < .001) {
    label <- sprintf("\u03B2 = %.2f \n p < .001 ***", formatted_estimate)
  } else if (p_value < 0.05) {
    label <- sprintf("\u03B2 = %.2f \n p < .05 **", formatted_estimate)
  } else if (p_value < .05) {
    label <- sprintf("\u03B2 = %.2f \n p < .05 **", formatted_estimate)
  } else if (p_value < 0.1) {
    label <- sprintf("\u03B2 = %.2f \n p < .1 *", formatted_estimate)
  } else if (p_value < .1) {
    label <- sprintf("\u03B2 = %.2f \n p < .1 *", formatted_estimate)
  } else {
    # Here use %s to format the p-value string since it has leading zeros removed
    label <- sprintf("\u03B2 = %.2f \n p = %s", formatted_estimate, formatted_p_value)
  }
  
  return(label)
}
