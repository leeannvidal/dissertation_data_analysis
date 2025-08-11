# # Function to compute random effects statistics
# compute_random_effects <- function(model) {
#   # Extract standard deviation of random effects
#   var_corr <- lme4::VarCorr(model)
#   std_dev <- attr(var_corr[[1]], "stddev")
#   
#   # Compute variance
#   variance <- std_dev^2
#   
#   # Residual variance for logistic regression
#   residual_variance <- 3.29
#   
#   # Compute ICC
#   icc <- variance / (variance + residual_variance)
#   
#   # Return results as a named list
#   return(list(Std_Dev = std_dev, Variance = variance, ICC = icc))
# }
# 
create_compact_table <- function(models,
                                 dep_var_labels = NULL,
                                 row_names = NULL,
                                 caption = "",
                                 label = "",
                                 significance_level = 0.05) {
  if (!is.list(models)) {
    stop("`models` must be a list of fitted model objects.")
  }
  
  # Prepare lists for storing results
  fixed_effects <- list()
  random_effects <- list(Std_Dev = numeric(), ICC = numeric())
  model_stats <- list(Observations = numeric(), r2= numeric()) 
  
  # Extract predictors in the order of the first model
  base_model_summary <- model_parameters(models[[1]], ci = 0.95, exponentiate = FALSE, effects = "fixed")
  predictor_order <- base_model_summary$Parameter
  
  # Replace predictor names using the `row_names` argument
  if (!is.null(row_names)) {
    predictor_order <- sapply(predictor_order, function(x) {
      if (x %in% names(row_names)) {
        return(row_names[[x]])
      } else {
        return(x)
      }
    })
  }
  
  for (i in seq_along(models)) {
    model <- models[[i]]
    
    # Extract fixed effects
    model_summary <- model_parameters(model, ci = 0.95, exponentiate = FALSE, effects = "fixed")
    
    # Replace variable names using `row_names`
    model_summary$Parameter <- sapply(model_summary$Parameter, function(x) {
      if (x %in% names(row_names)) {
        return(row_names[[x]])
      } else {
        return(x)
      }
    })
    
    # Match rows to the predictor order
    model_summary <- model_summary[match(predictor_order, model_summary$Parameter), ]
    # Format Beta and SE
    beta <- round(model_summary$Coefficient, 2)
    se <- round(model_summary$SE, 2)
    p_values <- model_summary$p
    
    # Create function to delete leading zeros
    
    remove_leading_zeros_latex <- function(x) {
      # Remove leading zeros using gsub and format to two decimal places
      result <- gsub("^(-?)0\\.", "\\1.", sprintf("%.2f", x))
    }
    
    # Add significance stars to Beta and format with 2 decimal places
    beta <- sapply(seq_along(beta), function(j) {
      b <- remove_leading_zeros_latex(beta[j]) # Use custom formatting to removed leading zeros and keep two decimal places
      p <- p_values[j]
      # formatted_b <- paste0("$", b, "$") # Wrap with $...$
      formatted_b <- paste0("$", b) # Wrap with $...$
      
      if (round(p, 3) < 0.01) {
        return(paste0(formatted_b, "^{***}$"))
      } else if (round(p, 3) < 0.05) {
        return(paste0(formatted_b, "^{**}$"))
      } else if (round(p, 3) < 0.1) {
        return(paste0(formatted_b, "^{*}$"))
      } else {
        # return(formatted_b)
        return(paste0(formatted_b, "$"))
      }
      
      # if (p < 0.001) {
      #   return(paste0(formatted_b, "^{***}$"))
      # } else if (p < 0.01) {
      #   return(paste0(formatted_b, "^{**}$"))
      # } else if (p < 0.05) {
      #   return(paste0(formatted_b, "^{*}$"))
      # } else {
      #   # return(formatted_b)
      #   return(paste0(formatted_b, "$"))
      # }
    })
    
    # Format SE with 2 decimal places & remove leading zeros
    se <- paste0("$(", sapply(se, remove_leading_zeros_latex), ")$")
    # se <- paste0("$(", sprintf("%.2f", se), ")$")
    
    # Store Beta and SE together with predictors
    fixed_effects[[i]] <- data.frame(
      Predictor = predictor_order,
      Beta = beta,
      SE = se
    )
    
    # Compute random effects statistics
    var_corr <- lme4::VarCorr(model)
    # sd_random <- round(attr(var_corr[[1]], "stddev"), 2) # Format SD
    sd_random <- remove_leading_zeros_latex(round(attr(var_corr[[1]], "stddev"), 2)) # Format SD
    variance_random_effect <- (as.numeric(sd_random))^2
    residual_variance <- attr(var_corr, "sc")^2
    # icc <- round(variance_random_effect / (variance_random_effect + residual_variance), 2) # Format ICC
    icc <- remove_leading_zeros_latex(round(variance_random_effect / (variance_random_effect + residual_variance), 2)) # Format ICC
    num_obs <- nobs(model)
    # Extract theoretical R² values with suppressed warnings
    theoretical_r2 <- suppressWarnings(r.squaredGLMM(model)["theoretical", ])
    r2s <- paste0(
      remove_leading_zeros_latex(round(theoretical_r2["R2m"], 2)),
      " / ",
      remove_leading_zeros_latex(round(theoretical_r2["R2c"], 2))
    )
    
    # Append to random effects list
    random_effects$Std_Dev <- c(random_effects$Std_Dev, sd_random)
    random_effects$ICC <- c(random_effects$ICC, icc)
    
    #Append to model_stats <- list(Observations = numeric(), r2= numeric()) 
    model_stats$Observations <- c(model_stats$Observations, num_obs)
    model_stats$r2 <- c(model_stats$r2, r2s)
    
  }
  
  # Combine fixed effects into a single table
  fixed_effects_table <- Reduce(function(x, y) {
    cbind(x, y[-1])
  }, fixed_effects)
  colnames(fixed_effects_table) <- c("Predictor", unlist(dep_var_labels, use.names = FALSE))
  
  # Create a combined table with Beta and SE rows
  combined_rows <- apply(fixed_effects_table, 1, function(row) {
    predictor <- row[1]
    values <- row[-1]
    beta_row <- c(predictor, "\\(\\beta\\)", values[seq(1, length(values), by = 2)]) # No extra wrapping
    se_row <- c("", "$\\textsc{se}$", values[seq(2, length(values), by = 2)]) # No extra wrapping
    list(beta_row, se_row)
  })
  
  # Flatten the combined rows
  combined_rows <- do.call(rbind, unlist(combined_rows, recursive = FALSE))
  
  # Create random effects table
  random_effects_table <- data.frame(
    Row = c("$\\textsc{SD}_\\textsc{ Speakers}$", " \\textsc{ICC}"),
    t(sapply(random_effects, function(re) {
      # Explicitly wrap all values in $...$
      sapply(re, function(val) {
        if (is.numeric(val)) {
          # Check if the value is an integer
          if (val == floor(val)) {
            # Format as integer without decimals and wrap in $...$
            return(paste0("$", as.character(as.integer(val)), "$"))
          }
          # Format as a floating-point number (e.g., SD, ICC) and wrap in $...$
          return(paste0("$", remove_leading_zeros_latex(val), "$"))
        } else {
          # Non-numeric values are returned as-is, wrapped in $...$
          return(paste0("$", val, "$"))
        }
      })
    }))
  )
  
  colnames(random_effects_table) <- c("Row", dep_var_labels)
  
  
  # Create model stats table
  model_stats_table <- data.frame(
    Row = c("Observations", " Marginal R²/ Conditional R²"),
    t(sapply(model_stats, function(re) {
      # Explicitly wrap all values in $...$
      sapply(re, function(val) {
        if (is.numeric(val)) {
          # Check if the value is an integer
          if (val == floor(val)) {
            # Format as integer without decimals and wrap in $...$
            return(paste0("$", as.character(as.integer(val)), "$"))
          }
          # Format as a floating-point number (e.g., SD, ICC) and wrap in $...$
          return(paste0("$", remove_leading_zeros_latex(val), "$"))
        } else {
          # Non-numeric values are returned as-is, wrapped in $...$
          return(paste0("$", val, "$"))
        }
      })
    }))
  )
  
  colnames(model_stats_table) <- c("Row", dep_var_labels)
  
  
  # Generate short-stacked dependent variable labels with small caps
  formatted_dep_var_labels <- sapply(dep_var_labels, function(label) {
    words <- strsplit(label, " ")[[1]]
    shortstack_content <- paste0("\\textsc{", words, "}", collapse = " \\\\ ")
    paste0("\\shortstack{", shortstack_content, "}")
  })
  
  # Build the LaTeX table
  final_output <- c(
    "\\fontsize{10}{8}",
    " \\begin{center} ",
    " \\begin{threeparttable}[!htbp] ",
    paste0("\\caption{", caption, "}"),
    paste0("\\label{", label, "}"),
    "\\begin{tabular}{lc", paste(rep("c", length(models)), collapse = ""), "} ",
    " \\hline \\hline ",
    " \\addlinespace[0.3em] ",
    paste0("\\multicolumn{2}{l}{} & \\multicolumn{", length(models), "}{c}{\\textsc{Dependent Variable:}} \\\\ "),
    " \\addlinespace[0.3em] ",
    paste0("\\shortstack{\\textsc{Predictors} \\\\ \\textsc{}} & \\shortstack{\\textsc{Stat} \\\\ \\textsc{}} & ", paste(formatted_dep_var_labels, collapse = " & ")), 
    " \\\\ \\hline ",
    " \\addlinespace[0.3em] "
  )
  
  # Add combined rows directly
  combined_row_lines <- apply(combined_rows, 1, function(row) {
    paste(row, collapse = " & ")
  })
  final_output <- c(
    final_output,
    paste(combined_row_lines, collapse = " \\\\")
  )
  
  # Add random effects rows directly
  random_effect_lines <- apply(random_effects_table, 1, function(row) {
    paste0(row[1], " &  & ", paste(row[-1], collapse = " & "))
  })
  final_output <- c(
    final_output,
    " \\\\ \\\\",
    "\\textsc{\\textbf{Random Effects}} \\\\",
    " \\addlinespace[0.3em] ",
    paste(random_effect_lines, collapse = " \\\\\n")
  )
  
  # Add model stats rows directly
  model_stats_lines <- apply(model_stats_table, 1, function(row) {
    paste0(row[1], " &  & ", paste(row[-1], collapse = " & "))
  })
  final_output <- c(
    final_output,
    " \\\\ \\hline \\addlinespace[0.3em] ",
    paste(model_stats_lines, collapse = " \\\\\n")
  )
  
  # Add footer and close the table
  final_output <- c(
    final_output,
    "\\\\ \\hline ",
    " \\bottomrule",
    " \\end{tabular}",
    " \\begin{tablenotes}",
    " \\footnotesize",
    " \\singlespacing",
    " \\vspace{-10pt}",
    " \\item[] {$^{*}p<.1$; $^{**}p<.05$; $^{***}p<.01$} \\\\ ",
    " \\vspace{2pt} ",
    " \\end{tablenotes}",
    " \\end{threeparttable}",
    " \\end{center}"
  )
  
  # Return the complete LaTeX table as a single string
  return(paste(final_output, collapse = "\n"))
}


# Example usage
#Create models list
models_list <- list(
  LVC_model_pronouns_present_token_level,
  LVC_model_subject_position_preverbal_token_level,
  LVC_model_fps_token_level
)

# Generate the LaTeX table
latex_table <- create_compact_table(
  models = models_list,
  dep_var_labels = c("Pronouns Present", "Preverbal Subjects", "Centralized FPS"),
  row_names = variable_names,
  caption = "Summary of Model Results Corresponding to Pronoun Presence, Pre-Verbal Subjects, and Centralized Filled Pauses among 22 Spanish-speaking Bostonians",
  label = "tab:regression_random_effects"
)

cat(latex_table)
