# Function to replace row names based on the defined variable_names vector
replace_row_names <- function(rownames) {
  # Replace names using the named vector, if no match is found, keep the original name
  sapply(rownames, function(x) {
    if (x %in% names(variable_names)) {
      return(variable_names[[x]])
    } else {
      return(x)
    }
  })
}
