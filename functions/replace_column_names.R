
# Function to conditionally replace column labels
replace_column_names <- function(df, col_labels) {
  current_cols <- colnames(df)
  sapply(current_cols, function(col) {
    if (col %in% names(col_labels)) {
      return(col_labels[[col]])
    } else {
      return(col) # Keep the original column name if no replacement
    }
  })
}