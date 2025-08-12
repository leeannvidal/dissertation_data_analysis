# Master Project – Liquid Variation Analysis

![R Version](https://img.shields.io/badge/R-%3E%3D4.0-blue)
![License: MIT](https://img.shields.io/badge/License-MIT-green)
![Last Updated](https://img.shields.io/github/last-commit/leeannvidal/dissertation_data_analysis)

This project analyzes **liquid variation** along with five other linguistic variables to uncover patterns of covariation.  
It includes **data preprocessing**, **exploratory analysis**, **modeling**, and **result visualization**.  

The repo is designed so that:
- A new user (or *future me*) can quickly reproduce the analysis.
- Each stage of the workflow is modular and easy to maintain.
- Sensitive or large data are excluded from version control.

---

## Project Structure
.
├── .gitignore                        # Git ignore rules
├── docs/                              # Documentation & R Markdown
│   ├── Coding_Manual_Liquids.pdf      # Methodology and coding manual
│   ├── project_overview.Rmd           # Orchestrates the full analysis workflow
│   └── README                         # Supporting documentation
├── functions/                         # Custom R functions for analysis & plotting
│   ├── add_name_stat.R
│   ├── basic_custom_theme.R
│   ├── model_summary_labels_for_visuals.R
│   └── ... (other helper functions)
├── scripts/                           # Analysis scripts
│   ├── data_preprocessing/            # Load, clean, and prepare raw data
│   │   ├── clean_fps.R
│   │   ├── clean_liquids.R
│   │   └── ...  
│   ├── descriptive_tables/            # Generate summary & descriptive tables
│   ├── statistical_analysis/          # Statistical models & regression scripts
│   ├── visuals/                        # Plotting scripts by variable type
│   ├── load_packages.R                 # Install & load required packages
│   ├── load_cleaned_dataframes.R       # Load cleaned datasets into the R session
│   └── initialize_fonts.R              # Load fonts for consistent plotting
├── data/                               # (ignored) Raw & processed data
│   ├── cleaned_data/                   # Cleaned .rds dataframes
│   ├── regressions/                    # Saved model objects
│   └── token_counts/                   # LaTeX .tex files with token counts
├── output/                             # (ignored) Generated outputs
│   ├── plots/                          # PDF figures by variable type
│   ├── presentation_visuals/           # Special plots for presentations
│   └── tables/                         # LaTeX tables for descriptive & statistical results
└── LVC_Dissertation_Master.Rproj       # Local RStudio project file (ignored in Git)

> **Note:** `data/` and `output/` are excluded from GitHub for privacy and reproducibility purposes.  
> An anonymized sample dataset can be provided in `data-sample/` for demonstration.

---

## How to Reproduce the Analysis

### Prerequisites
- **R** ≥ 4.0
- **RStudio** (optional, recommended)
- Required R packages are loaded via `scripts/load_packages.R`

### Steps
  1. Clone this repository:
     ```bash
     git clone https://github.com/leeannvidal/dissertation_data_analysis.git
  2. Open the project in RStudio (.Rproj file is local-only and not tracked in Git).
  3. Load required packages:
  - source("scripts/load_packages.R")
  4. Run data preprocessing scripts in scripts/data_preprocessing/ to clean and prepare data.
  5. Optionally, run:
  - source("scripts/generate_counts.R")
  - to create token count .tex files for LaTeX.
  6. Load cleaned data for analysis:
  - source("scripts/load_cleaned_dataframes.R")
  7. Render docs/project_overview.Rmd to reproduce the full analysis and visuals.

# Workflow Overview
  1. Data Loading & Cleaning
  - project_overview.Rmd orchestrates the workflow.
  2. Cleaning scripts standardize and process each dataset.
  - Cleaned .rds files are stored in data/cleaned_data/.
  3. Token Count Generation
  - generate_counts.R calculates counts and saves .tex files in data/token_counts/.
  4. Function Loading
  - All custom functions live in functions/ and are sourced at the start of analysis.
  5. Data Wrangling for Stats/Visuals
  - Wrangling scripts ensure transformations are centralized and reproducible.
  - 6. Descriptive Visuals
  - Includes methodology figures and basic descriptive statistics for each variable.
  7. Data Analysis & Results
  - Chapter-specific visuals and statistical outputs.