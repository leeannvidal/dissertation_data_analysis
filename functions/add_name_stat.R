# functions/add_name_stat.R

# Function: AddNameStat
# Description: This function updates facet labels with a selected statistic (standard deviation, mean, or count) for a specified category.
# Usage: Pass a data frame, the category to facet by, the column to calculate statistics on, and the desired statistic ("sd", "mean", or "count").
# Example: facet_labels <- AddNameStat(df, "CategoryColumn", "ValueColumn", stat = "mean", dp = 2)

AddNameStat <- function(df, category, count_col, stat = c("sd","mean","count"), dp = 0) {
  
  # Convert count_col to numeric
  df[[count_col]] <- as.numeric(as.character(df[[count_col]]))
  
  # Create temporary data frame for analysis
  temp <- data.frame(ref = df[[category]], comp = df[[count_col]])
  
  # Aggregate the variables and calculate statistics
  agg_stats <- plyr::ddply(temp, "ref", summarize,
                           sd = sd(comp),
                           mean = mean(comp),
                           count = length(comp))
  
  # Dictionary used to replace stat name with correct symbol for plot
  labelName <- plyr::mapvalues(stat, 
                               from = c("sd", "mean", "count"), 
                               to = c("\u03C3", "x", "n"))
  
  # Updates the name based on the selected variable
  agg_stats$join <- paste0(agg_stats$ref, ": ", labelName, " = ",
                           round(agg_stats[[stat]], dp))
  
  # Map the names
  name_map <- setNames(agg_stats$join, as.factor(agg_stats$ref))
  return(name_map[as.character(df[[category]])])
}
