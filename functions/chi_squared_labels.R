# chi_squared_labels.R

# Function: create_chi_label
# Description: Creates a significance label for chi-squared tests using the Greek letter chi (χ²).
# Usage: Pass the result of a chi-squared test (e.g., from chisq.test()) to the function.
# Example:
# Step 1 - Perform chi-square test
#   chi_test_result <- chisq.test(your_data_here)
# Step 2 - Run function
#   label_for_plot <- create_chi_label(chi_test_result)
# Step 3 - Check to see that the function worked
#   print(label_for_plot)
# 
# #Calculate chi-square to include in plot COUNTRY_OF_ORIGIN
# ## Create a Contingency Table
# trill_COUNTRY_OF_ORIGIN_match <- table(trill$PHONETIC_PHONOLOGICAL_AGREEMENT, trill$COUNTRY_OF_ORIGIN)
# # 
# # # Run χ² function -
# chi_label_COUNTRY_OF_ORIGIN_trill_match <- create_chi_label(chisq.test(trill_COUNTRY_OF_ORIGIN_match))
# # 
# # 
# create_chi_label <- function(chi_test_result) {
#   # Determine the significance level
#   if (chi_test_result$p.value < 0.001) {
#     label <- sprintf("χ² = %.2f,\n df = %d,\n p-value < 0.001 ***",
#                      chi_test_result$statistic,
#                      chi_test_result$parameter)
#   } else if (chi_test_result$p.value < 0.05) {
#     label <- sprintf("χ² = %.2f, \n df = %d, \n p-value < 0.05 **",
#                      chi_test_result$statistic,
#                      chi_test_result$parameter)
#   } else if (chi_test_result$p.value < 0.1) {
#     label <- sprintf("χ² = %.2f, \n df = %d, \n p-value < 0.1 *",
#                      chi_test_result$statistic,
#                      chi_test_result$parameter)
#   } else {
#     label <- sprintf("χ² = %.2f, \n df = %d, \n p-value = %.2f",
#                      chi_test_result$statistic,
#                      chi_test_result$parameter,
#                      chi_test_result$p.value)
#   }
#   
#   return(label)
# }

create_chi_label <- function(chi_test_result) {
  # Check if p-value is NA
  if (is.na(chi_test_result$p.value)) {
    label <- sprintf("χ² = %.2f, \n df = %d, \n p-value = NA",
                     chi_test_result$statistic,
                     chi_test_result$parameter)
  } else if (chi_test_result$p.value < 0.001) {
    label <- sprintf("χ² = %.2f,\n df = %d,\n p-value < 0.001 ***",
                     chi_test_result$statistic,
                     chi_test_result$parameter)
  } else if (chi_test_result$p.value < 0.05) {
    label <- sprintf("χ² = %.2f, \n df = %d, \n p-value < 0.05 **",
                     chi_test_result$statistic,
                     chi_test_result$parameter)
  } else if (chi_test_result$p.value < 0.1) {
    label <- sprintf("χ² = %.2f, \n df = %d, \n p-value < 0.1 *",
                     chi_test_result$statistic,
                     chi_test_result$parameter)
  } else {
    label <- sprintf("χ² = %.2f, \n df = %d, \n p-value = %.2f",
                     chi_test_result$statistic,
                     chi_test_result$parameter,
                     chi_test_result$p.value)
  }
  
  return(label)
}

