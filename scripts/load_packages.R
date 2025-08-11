# scripts/load_packages.R
# citation("package name")
# citation("parameters")

# List of required packages with descriptions

required_packages <- c(
  # Core Data Manipulation and Wrangling
  "tidyverse",   # A collection of R packages for data science, including ggplot2, dplyr, tidyr, readr, purrr, tibble, stringr, and forcats.
  "scales",       # To use comma() function for formatting numbers (for counts and such)
  # "dplyr",      # Part of the tidyverse, provides tools for data manipulation, including filtering, selecting, and summarizing data.
  # "tidyr",      # Part of the tidyverse, used for tidying data, reshaping it into the desired format.
  # "readr",      # Part of the tidyverse, used for eading data
  # "purrr",      # Part of the tidyverse, used for functional programming
  # "stringr",    # Part of the tidyverse, used for string manipulation (ex. str_trim() function for trimming whitespace)
  
  # Statistical Analysis and Modeling
  "psych",       # Tools for psychological research, including descriptive statistics, factor analysis, and more.
  "lme4",        # Provides functions for fitting linear and generalized linear mixed-effects models.
  "broom.mixed", # Tidies up model output from mixed-effects models, making it easier to work with in a tidyverse framework.
  "cAIC4",      # For stepwise model selection process    # library(cAIC4)

  # Data Visualization
  # "ggplot2",     # Included in the tidyverse, ggplot2 is used for creating complex and customizable data visualizations.
  "ggthemes",    # Provides additional themes for ggplot2, including the Economist theme.
  "RColorBrewer",# Provides color palettes, particularly useful for creating colorblind-friendly visualizations.
  "ggrepel",     # Adds labels to ggplot2 plots with repulsion, preventing them from overlapping.
  "ggpubr",      # Extends ggplot2 with functions for publication-ready plots, including adding text annotations.
  "directlabels",# Adds labels directly to the data points in a plot, eliminating the need for separate legends.
  "showtext",    # To add custom fonts like Charis SIL and Charis SIL SmallCaps, which allow for ipa to be used.
  "likert",    # To create visuals from likert like responses
  
  # Report Generation and Table Formatting
  "knitr",       # A tool for dynamic report generation, commonly used in R Markdown files.
  "kableExtra",  # Enhances knitr's kable function to create well-formatted tables in HTML or LaTeX.
  "xtable",      # Converts R objects into LaTeX tables, suitable for use in R Markdown or LaTeX documents.
  "stargazer",   # Generates well-formatted regression tables and summary statistics for LaTeX, HTML, or text.
  "sjPlot",      # Collects of plotting and table out functions for data visualization
  "MuMIn",
  "parameters",
  "car",         # Checks for multicolinearity in between factors using VIF
  
  # Graphics Customization and Text Manipulation
  "RGraphics",   # Contains functions for advanced graphical customization, including text wrapping in plots.
  "latex2exp",   # Allows for the inclusion of LaTeX-style mathematical expressions in plots.
  "R.utils"      # Utility functions, including one to capitalize the first letter of a string.
)

# Function to install and load packages with suppression and error handling
install_and_load <- function(packages) {
  # Install missing packages
  installed_packages <- installed.packages()[, "Package"]
  missing_packages <- packages[!(packages %in% installed_packages)]
  
  if(length(missing_packages)) {
    install.packages(missing_packages)
  }
  
  # Load packages with message suppression and error handling
  lapply(packages, function(pkg) {
    suppressPackageStartupMessages({
      if(!require(pkg, character.only = TRUE)) {
        stop(paste("Package", pkg, "failed to load. Please check if the package is installed correctly."))
      }
    })
  })
}

# Call the function to install (if necessary) and load the packages
install_and_load(required_packages)
