####Version that allows for Random Effects and Extra Model Information
# Function: create_table_w_random_effects
# Description:
# This function takes a fitted model object and generates a LaTeX-formatted table
# displaying the fixed effects estimates, standard errors, z-statistics (or t-statistics),
# and p-values, including significance stars and bold formatting for significant p-values.
# It also includes random effects information (number of groups and standard deviation)
# and model statistics (number of observations, R-squared values, AIC).
# If column names are not provided, the function extracts them from the model.
# Optional parameters allow users to customize row names, table caption, label, and 
# dependent variable name.

### The following function allows for the creating of nice latEX
### Uses library(lme4), library(MuMIn), and library(parameters) packages 

create_table_w_random_effects <- function(model, 
                                          # col_names = NULL,  # Allow col_names to be NULL OR if all the models have the same column names, use the one below
                                          col_names = c("Predictors", "\\beta", "SE", "CI 95 \\%", "z-stat", "p-value"),
                                          row_names = NULL,  
                                          significance_level = 0.05,
                                          caption = "",   
                                          label = "",     
                                          dep_var_name = "Dependent Variable") {  
  
  # Extract summary of the model that includes CI (using parameter package)
  
  model_summary <- model_parameters(model,ci = 0.95, exponentiate = FALSE, effects = "fixed")
  
  # Create function to delete leading zeros
  
  remove_leading_zeros <- function(leading_zeros){
    result <- gsub("^(-?)0\\.", "\\1.", leading_zeros)
    return(result)
  }

  remove_leading_zeros_latex <- function(x) {
    # Remove leading zeros using gsub and format to two decimal places
    result <- gsub("^(-?)0\\.", "\\1.", sprintf("%.2f", x))
    
    # Use sapply to apply this logic to each element of the vector
    result <- sapply(result, function(y) {
      if (grepl("-", y)) {
        return(paste0("$$-$", gsub("-", "", y), "$"))  # Format negative numbers
      } else {
        return(paste0("$", y, "$"))  # Format positive numbers
      }
    })
    
    return(result)
  }
  
  # Applying the function to the "Coefficient" and "SE" columns
  estimates <- remove_leading_zeros_latex(round(model_summary[, "Coefficient"], 2))
  standard_errors <- remove_leading_zeros_latex(round(model_summary[, "SE"], 2))
  
  # Combine CI_lower and CI_upper as intervals
  CI <- paste0("$[$", remove_leading_zeros_latex(round(model_summary[, "CI_low"], 2)), "$-$", remove_leading_zeros_latex(round(model_summary[, "CI_high"], 2)), "$]$")

  
  # Use "z value" for logistic models, instead of "t value"
  if ("z" %in% colnames(model_summary)) {
    test_stat <- remove_leading_zeros_latex(round(model_summary[, "z"], 2))
  } else if ("t" %in% colnames(model_summary)) {
    test_stat <- remove_leading_zeros_latex(round(model_summary[, "t"], 2))
  } else {
    stop("Neither z value nor t value found in the model summary.")
  }
  
# Extract and format p-values with significance stars
p_value <- model_summary[, "p"]

# Apply function within sapply loop for p-values
p_value <- sapply(p_value, function(x) {
  # Use sprintf to format p-values to three decimal places
  formatted_value <- sprintf("%.3f", x)
  
  # Apply the remove_leading_zeros_for_pvalues function to remove leading zeros
  formatted_value <- remove_leading_zeros(formatted_value)
  
  # # Add significance stars based on p-value thresholds
  # if (round(x, 3) < 0.01) { 
  #   return(paste0("$", formatted_value, "$", "***")) 
  # } else if (round(x, 3) < 0.05) { 
  #   return(paste0("$", formatted_value, "$", "**")) 
  # } else if (round(x, 3) < 0.1) { 
  #   return(paste0("$", formatted_value, "$", "*")) 
  # } else { 
  #   return(paste0("$", formatted_value, "$")) 
  # }
  
  # Add significance stars based on p-value thresholds
  if (round(x, 3) < 0.01) { 
    return(paste0("$", formatted_value, "^{***}$")) 
  } else if (round(x, 3) < 0.05) { 
    return(paste0("$", formatted_value, "^{**}$")) 
  } else if (round(x, 3) < 0.1) { 
    return(paste0("$", formatted_value, "^{*}$")) 
  } else { 
    return(paste0("$", formatted_value, "$")) 
  }
})


  # Use default column names if none are provided
  if (is.null(col_names)) {
    col_names <- c("Predictors", colnames(model_summary))  # Extract column names from model_summary
  }

# If row_names are not provided, use the 'Parameter' column from the model_summary
# Replace using the variable_names vector
if (is.null(row_names)) {
  row_names <- model_summary$Parameter
  row_names <- sapply(row_names, function(x) {
    if (x %in% names(variable_names)) {
      return(variable_names[[x]])  # Replace with the mapped value
    } else {
      return(x)  # Leave as is if no mapping exists
    }
  })
}

  # # Set row names from model summary or use custom row names ### this was before I added the call to the vector to easily change the labels
  # if (!is.null(row_names) && length(row_names) == nrow(model_summary)) {
  #   rownames(model_summary) <- row_names
  # }
  

  # Combine fixed effect results (row names separately)
  # output <- cbind(rownames(model_summary), estimates, standard_errors, test_stat, p_value) ### without CI column
  # output <- cbind(rownames(model_summary), estimates, standard_errors, CI, p_value) ### with CI column, dropped z stat (for now)
  # output <- cbind(rownames(model_summary), estimates, standard_errors, CI, test_stat, p_value) ### with CI column AND z stat
  output <- cbind(row_names, estimates, standard_errors, CI, test_stat, p_value) ### NEEDED IF USING THE AUTOMATIC ROW NAME FUNCTION
  
  colnames(output) <- col_names
  
  # Apply \textsc{} to column names
  col_names_latex <- sapply(col_names, function(name) paste0("\\textsc{", name, "}"))
  
  # Convert fixed effects to LaTeX format dynamically, regardless of the number of columns
  fixed_effects_lines <- apply(output, 1, function(row) {
    paste(row, collapse = " & ")  # Combines all columns dynamically with ' & '
  })
  
  # Add LaTeX line breaks
  fixed_effects_lines <- paste(fixed_effects_lines, "\\\\ ")
  
  # Extract the standard deviation for the speakers' random effect
  sd_speakers <- round(attr(VarCorr(model)[[1]], "stddev"), 2)
  
  # Get the random effects parameters (using parameters package)
  random_effects <- random_parameters(model)
  
  # Extract the "Within-Group Variance" value or residual variance
  residual_variance <- round(random_effects[random_effects$Description == "Within-Group Variance", "Value"], 2)
  
  # Extract the "Between-Group Variance" value or random effect variance
  variance_random_effect <- round(random_effects[random_effects$Description == "Between-Group Variance", "Value"], 2)
  
  # Calculate Intraclass Correlation Coefficient (ICC) - 
  # The ICC is a measure of how much of the variation in the outcome variable 
  # can be attributed to differences between groups or clusters, rather than to individual differences
  ICC = remove_leading_zeros_latex(round(variance_random_effect / (variance_random_effect + residual_variance), 2))
  
  # Extract the number of speakers
  num_speakers <- random_effects[random_effects$Description == "N", "Value"]
  
  # Add random effects lines to the table
  random_effects_lines <- paste(
    " \\textsc{\\textbf{Random Effects}} \\\\ ",
    " \\addlinespace[0.3em] ",
    " $\\sigma$$^{2}$ &", "$", residual_variance,"$", "\\\\",
    " $\\tau$$_{00 \\textsc{ Speakers}}$ &", "$", variance_random_effect, "$", "\\\\ ",
    " \\textsc{ICC} &", ICC, "\\\\",
    " $\\textsc{N}_\\textsc{ Speakers}$ &", "$", num_speakers, "$", "\\\\ ",
    " $\\textsc{SD}_\\textsc{ Speakers}$ &", "$", sd_speakers, "$", "\\\\ "
  )
  
  # Extract theoretical R² values with suppressed warnings
  theoretical_r2 <- suppressWarnings(r.squaredGLMM(model)["theoretical", ])
  
  # Create model stats section
  model_stats_lines <- paste(
    "Observations &", "$", nobs(model), "$", "\\\\ ",
    "Marginal R²/ Conditional R² &", remove_leading_zeros_latex(round(theoretical_r2["R2m"], 2)), "$/$", remove_leading_zeros_latex(round(theoretical_r2["R2c"], 2)), " \\\\",
    "AIC &", "$", round(AIC(model), 2), "$", "\\\\ "
  )
  
  ### Extract model call to include as a note
  model_call <- model@call
  
  # Extract the formula part from the call and collapse into one line
  model_formula <- paste(deparse(model_call$formula), collapse = "")
  
  # Remove any excess whitespace from the formula
  model_formula_clean <- gsub("\\s+", " ", model_formula)  # Replace multiple spaces with a single space
  
  # Construct the simplified string
  simplified_model_call <- paste("glmer(", trimws(model_formula_clean), ")")
  
  # Print the simplified model call
  simplified_model_call
  
  # Use gsub or stringr to replace all occurrences of old names with new ones
  for (old_name in names(variable_names)) {
    new_name <- variable_names[[old_name]]
    simplified_model_call <- gsub(old_name, new_name, simplified_model_call)
  }
  
  # Combine all lines into LaTeX output
  final_output <- c(
    " \\begin{center} ",
    "\\fontsize{10}{8} ",
    " \\setlength{\\tabcolsep}{5pt} ",
    " \\begin{threeparttable}[!htbp] ",
    paste0("\\caption{", caption, "} "),   # Add caption
    paste0("\\label{", label, "} "),       # Add label
    "\\begin{tabular}{lrrcrl} ",
    " \\hline \\hline ",
    " \\addlinespace[0.3em] ",
    paste0("\\multicolumn{1}{l}{} & \\multicolumn{4}{c}{\\textsc{", dep_var_name, "}} \\\\ "),  # Add row with dependent variable spanning last 4 columns
    " \\addlinespace[0.3em] ",
    paste(col_names_latex, collapse = " & "), 
    # " \\\\ \\hline \\\\ ",
    "\\\\ \\hline \\addlinespace[0.3em] ",
    fixed_effects_lines,
    " \\\\ ",
    # " \\addlinespace[0.3em] ",
    random_effects_lines,
    # "\\\\ \\hline \\\\ ",
    " \\hline \\addlinespace[0.3em] ",
    model_stats_lines,
    # " \\\\ ",
    "\\hline ",
    " \\bottomrule",
    " \\end{tabular}",
    " \\begin{tablenotes}",
    " \\footnotesize",
    " \\singlespacing",
    " \\vspace{-10pt}",
    " \\item[] {$^{*}p<.1$; $^{**}p<.05$; $^{***}p<.01$} \\\\ ",
    " \\vspace{2pt} ",
    # " \\item[Model Call:] ", simplified_model_call, ## Can include later if I want
    # " \\\\ ",
    " \\end{tablenotes}",
    " \\end{threeparttable}",
    " \\end{center}"
  )
  
  # Return the complete LaTeX table as a string
  return(paste(final_output, collapse = "\n"))
}

# # Test the function with custom row names, caption, label, and dependent variable name
# cat(create_table_w_random_effects(model))
# custom_row_names <- c("Intercept", "Variable 1", "Variable 2")
# # custom_col_names = c("Predictors", "Estimate", "SE", "z-stat", "p-value")
# cat(create_table_w_random_effects(model, row_names = custom_row_names, caption = "Sample Model Results", label = "tab:sample_results", dep_var_name = "Mismatch"))