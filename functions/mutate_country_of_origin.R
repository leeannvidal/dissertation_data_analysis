# mutate_country_of_origin.R

# Function: mutate_country_of_origin
# Description: Mutates the COUNTRY_OF_ORIGIN column, combining "dr" and "el_dr" into "dr".
# Usage: Pass a data frame containing a COUNTRY_OF_ORIGIN column to the function.
# Example: s <- mutate_country_of_origin(s)

mutate_country_of_origin <- function(df) {
  df <- df %>%
    mutate(COUNTRY_OF_ORIGIN = case_when(
      COUNTRY_OF_ORIGIN %in% c("dr", "el_dr") ~ "dr",
      TRUE ~ COUNTRY_OF_ORIGIN
    ))
  return(df)
}
