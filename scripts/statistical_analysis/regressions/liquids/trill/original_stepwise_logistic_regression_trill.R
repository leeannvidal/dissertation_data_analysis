# Load necessary package
# library(MASS) ### DIDNT USE Stepwise Model Selection (stepAIC()): A function for stepwise model selection based on the Akaike Information Criterion (AIC), commonly used for linear and generalized linear models.

# factors_to_include <- c("MISMATCH","SPEAKER", "LOG_LEX_FREQ_DF_N","MS_PER_SYLL",
#                         "POS_SYL", "POS_WORD", "PREV_SOUND_CATEGORY", "FOLL_SOUND_CATEGORY", 
#                         "SYL_TYPE", "WORD_CLASS", "STRESS", "SEX", "COUNTRY_OF_ORIGIN",
#                         "PLUS", "IMMIGRATION_CATEGORY", "PERCENT_INTL_ENG_ONLY", "PERCENT_INTL_SPAN_ONLY")

# 
# factors_to_include_trill <- c("MISMATCH","SPEAKER", "LOG_LEX_FREQ_DF_N","MS_PER_SYLL",
#                               "POS_WORD", "PREV_SOUND_CATEGORY", "FOLL_SOUND_CATEGORY", 
#                               "SYL_TYPE", "WORD_CLASS", "STRESS", "SEX", "COUNTRY_OF_ORIGIN",
#                               "PLUS", "IMMIGRATION_CATEGORY", "PERCENT_INTL_ENG_ONLY", "PERCENT_INTL_SPAN_ONLY")
# 
# # Subset the dataset to include only the specified factors and variables
# trill_stepwise_model_df <- trill[, factors_to_include_trill]
# 
# # List all factors in the dataset
# factor_vars <- names(trill_stepwise_model_df)[sapply(trill_stepwise_model_df, is.factor)]
# 
# # Print the list of factor variables
# print(factor_vars)

# # Loop through each factor variable and print its levels
# for (var in factor_vars) {
#   cat("Factor variable:", var, "\n")
#   print(levels(trill_stepwise_model_df[[var]]))
#   cat("\n")
# }

# # Drop unused factor levels
# trill_stepwise_model_df <- droplevels(trill_stepwise_model_df)
# 
# # Identify factors with only one level
# single_level_factors <- names(trill_stepwise_model_df)[sapply(trill_stepwise_model_df, function(x) is.factor(x) && length(levels(x)) == 1)]
# 
# # Print the problematic factors
# print(single_level_factors)

# Check pairwise correlations between numeric variables
# cor(trill_stepwise_model_df[, sapply(trill_stepwise_model_df, is.numeric)])


# trill_stepwise_model_df$LOG_LEX_FREQ_DF_N <- scale(trill_stepwise_model_df$LOG_LEX_FREQ_DF_N)
# trill_stepwise_model_df$MS_PER_SYLL <- scale(trill_stepwise_model_df$MS_PER_SYLL)

# Rescale continuous variables
# trill$LOG_LEX_FREQ_DF_N_SCALED <- scale(trill$LOG_LEX_FREQ_DF_N)
trill$MS_PER_SYLL_SCALED <- scale(trill$MS_PER_SYLL)



# Define the scope model (full model)
saturation_model_trill <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
                      POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN + 
                      PLUS + (1 | SPEAKER), 
                    data = trill, 
                    family = binomial,
                    na.action = "na.fail",
                    control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))

summary(saturation_model_trill, correlation=TRUE)

# Check for multicollinearity using VIF
library(car)
vif(saturation_model_trill)

summary(step_model)


library(MuMIn)
# 
# # Perform model selection
model_selection_trill <- dredge(saturation_model_trill)
# 
# View the top models
head(model_selection_trill)

# Get the best model
best_model_trill <- get.models(model_selection_trill, subset = 1)[[1]]
summary(best_model_trill)


# cat(create_table_w_random_effects(best_model_trill, row_names = rownames_trill, caption = "Mixed Effects Regression Model Predicting Match/Mismatch of Trills", label = "tab:trill_regression", dep_var_name = "Dep. Variable: Mismatch"))

cat(create_table_w_random_effects(best_model_trill, caption = "Mixed Effects Regression Model Predicting Match/Mismatch of Trills", label = "tab:trill_regression", dep_var_name = "Dep. Variable: Mismatch"))

# Function uses parameters package to get CI, this is the call
model_summary <- model_parameters(best_model_trill,ci = 0.95, exponentiate = FALSE, effects = "fixed")

# help(tab_model)
# ?tab_model
# tab_model(best_model_trill) # This one exponentiates the beta
tab_model(best_model_trill, transform = NULL) # so that it is not exponentiated, which is the norm for logistic regressions



# # Install and load the car package
# library(car)
# 
# # Fit a standard logistic regression model (without random effects) to check VIF
# vif_model <- glm(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL +
#                    POS_WORD + PREV_SOUND_CATEGORY + FOLL_SOUND_CATEGORY +
#                    SYL_TYPE + WORD_CLASS + STRESS + SEX + COUNTRY_OF_ORIGIN + 
#                    IMMIGRATION_CATEGORY, 
#                  data = trill_stepwise_model_df, 
#                  family = binomial)
# 
# # Check VIF
# vif(vif_model)

# library(GGally) # The ggpairs() function is part of the GGally package in R. This function is used to create a matrix of plots (a pair plot) to visualize pairwise relationships between variables
# #Quick correlation visual
# ggpairs(trill[, c("LOG_LEX_FREQ_DF_N", "MS_PER_SYLL", "POS_WORD", "SYL_TYPE", "STRESS", "SEX", "COUNTRY_OF_ORIGIN", "IMMIGRATION_CATEGORY", "PLUS")])


# # Compare models using ANOVA (likelihood ratio test) # not needed if i can get the automatic stepwise to work
# anova(full_model, reduced_model)
