# #### This is for all the code that was used and tried so that I dont try and test them again


#column.labels = c("lmer(preference_value ~ pragmatic_condition + animacy_subject + verb_type + Region + (1|participant_id) + (1|answer),data =VS_order_T1)"),
#float.env = "sidewaystable",

stargazer(best_model,
          type = "latex",
          report=("vcstp*"),
          header = FALSE,
          # label = "tab:regression_trill",
          title = "Mixed Effects Regression Model Predicting Match/Mismatch of Trills",
          model.numbers = FALSE,
          digits = 2,
          initial.zero = TRUE,
          intercept.bottom = FALSE,
          single.row = TRUE,
          # column.sep.width = "-20pt",
          font.size = "small",
          align = TRUE,
          covariate.labels = rownames_trill,
          dep.var.labels = dependent_variable_name_trill,
          # dep.var.caption = "",
          keep.stat = c("n", "rsq", "adj.rsq") #to decide what extras to keep in bottom
)

#stargazer

stargazer(best_model,
          title = "Regression Results",
          label = "tab:regression",
          covariate.labels = rownames_trill_stargazer_order,
          dep.var.labels = dependent_variable_name_trill,
          type = "latex",       # Generate LaTeX output
          out = latex_output  # Save as LaTeX file
)


# install.packages("sjPlot")
# dv.labels = c("Mismatch"),

dependent_variable_name_trill <- c("Mismatch")
rownames_trill <- c("Intercept", "Country of Origin: PR", "Log Lexical Frequency", "Milliseconds per Syllable","PLUS", "Position in Word: internal")
rownames_trill_stargazer_order <- c("Country of Origin: Puerto Rico", "Log Lexical Frequency of Host Word", "Milliseconds per Syllable","PLUS", "Position in Word: internal", "Intercept")

library(sjPlot)

# Specify the file path for the LaTeX table
latex_output <- "output/tables/statistical/logistic_regression_trill.tex"
tabmodel
# Create the table and save it as a LaTeX file
tab_model(best_model,
          # show.est = TRUE,
          show.est = TRUE,
          show.ci = FALSE,
          show.std = TRUE,
          show.se = TRUE,
          show.p = TRUE,
          digits.p = 2,
          show.stat = TRUE,
          show.df = FALSE,
          col.order = c("est", "se", "stat", "p"),
          dv.labels = dependent_variable_name_trill,
          pred.labels = rownames_trill,
          string.est = "Estimate",
          string.se = "SE",
          string.stat = "t-value",
          string.p = "p-value"
)

summary(best_model)
library(broom)
library(kableExtra)

# Convert model output to a tidy data frame
model_summary <- tidy(best_model)

# Add custom column names
colnames(model_summary) <- c("Predictor", "Estimate", "SE", "t-value", "p-value")
# 
# # Generate LaTeX table with kableExtra - UGLY
# model_summary %>%
#   kbl(booktabs = TRUE, format = "latex", caption = "Model Results") %>%
#   kable_styling(latex_options = c("hold_position", "scale_down"))

# library(lme4)
# library(stargazer)
# library(broom.mixed)
# 
# # Extract Random Effects
# random_effects <- as.data.frame(VarCorr(best_model))
# variance <- random_effects$vcov  # Extract variance components
# num_speakers <- length(unique(best_model@frame$SPEAKER))  # Example assuming SPEAKER is the grouping factor
# 
# # Extract fixed effects summary for the stargazer table
# fixed_effects <- tidy(best_model)
# 
# # Create custom bottom notes
# extra_stats <- paste0("Random Effects Variance: ", round(variance, 2),
#                       "; Number of Speakers: ", num_speakers)
# 
# # Generate stargazer table
# stargazer(best_model,
#           type = "latex",
#           report = "vcstp*",  # Controls displayed statistics
#           header = FALSE,
#           title = "Mixed Effects Regression Model Predicting Match/Mismatch of Trills",
#           model.numbers = FALSE,
#           digits = 2,
#           initial.zero = TRUE,
#           intercept.bottom = FALSE,
#           single.row = TRUE,
#           font.size = "small",
#           align = TRUE,
#           covariate.labels = rownames_trill,
#           dep.var.labels = dependent_variable_name_trill,
#           keep.stat = c("n", "rsq", "adj.rsq"),
#           add.lines = list(extra_stats)  # Add custom lines for random effects info
# )
# 
# library(modelsummary)
# 
# modelsummary(best_model, output = "latex")
# 
# # /usr/local/texlive/2012/bin/x86_64-darwin
# 
# 

##### THE BELOW IS CODE I USED IN LATEX WHEN TESTING TABLE FORMATS

# 
# %%%%latex_table <- create_latex_table_with_random_effects(best_model) cat(latex_table)
# \begin{table}[!htbp] \centering    \caption{}    \label{}  \begin{tabular}{@{\extracolsep{5pt}} cccc}  \\[-1.8ex]\hline  \hline \\[-1.8ex]   & Estimate & Std. Error & p-value \\  \hline \\[-1.8ex]  (Intercept) & $$-$0.323$ & $0.495$ & $0.514$ \\  COUNTRY\_OF\_ORIGINpr & $$-$0.807$ & $0.507$ & $0.112$ \\  LOG\_LEX\_FREQ\_DF\_N\_SCALED & $0.248$ & $0.090$ & $0.006$ \\  MS\_PER\_SYLL\_SCALED & $$-$0.303$ & $0.089$ & $0.001$ \\  PLUS & $0.033$ & $0.007$ & $0.00000$ \\  POS\_WORDinternal & $$-$0.574$ & $0.182$ & $0.002$ \\  \hline \\[-1.8ex]  \end{tabular}  \end{table} 
# 
# %Stargazer
# 
# %\begin{table}[!htbp] \centering   \caption{Mixed Effects Regression Model Predicting Match/Mismatch of Trills}   \label{} \small \begin{tabular}{@{\extracolsep{5pt}}lD{.}{.}{-2} } \\[-1.8ex]\hline \hline \\[-1.8ex]  & \multicolumn{1}{c}{\textit{Dependent variable:}} \\ \cline{2-2} \\[-1.8ex] & \multicolumn{1}{c}{Mismatch} \\ \hline \\[-1.8ex]  Intercept & -0.32$ $(0.49) \\   & t = -0.65 \\   & p = 0.52 \\   Country of Origin: PR & -0.81$ $(0.51) \\   & t = -1.59 \\   & p = 0.12 \\   Log Lexical Frequency & 0.25$ $(0.09) \\   & t = 2.76 \\   & p = 0.01^{***} \\   Milliseconds per Syllable & -0.30$ $(0.09) \\   & t = -3.39 \\   & p = 0.001^{***} \\   PLUS & 0.03$ $(0.01) \\   & t = 4.81 \\   & p = 0.0000^{***} \\   Position in Word: internal & -0.57$ $(0.18) \\   & t = -3.15 \\   & p = 0.002^{***} \\  \hline \\[-1.8ex] Random Effects Variance: 1.07; Number of Speakers: 22 &  \\ Observations & \multicolumn{1}{c}{857} \\ 
# \hline \hline \\[-1.8ex] \textit{Note:}  & \multicolumn{1}{r}{$^{*}$p$<$0.1; $^{**}$p$<$0.05; $^{***}$p$<$0.01} \\ \end{tabular} \end{table} 
# 
# %create_table
# \begin{table}[!htbp] \centering   \caption{}   \label{} \begin{tabular}{@{\extracolsep{5pt}} ccccc} \\[-1.8ex]\hline \hline \\[-1.8ex]  & Estimate & Std. Error & z-stat & p-value \\ \hline \\[-1.8ex] (Intercept) & $0.473$ & $0.077$ & $6.156$ & $0$ \\ x1 & $1.243$ & $0.030$ & $41.336$ & $0$ \\ x2 & $$-$0.846$ & $0.048$ & $$-$17.777$ & $0$ \\ \hline \\[-1.8ex] \end{tabular} \end{table}
# 
# %%create_table_w_random_effects
# 
# % Add caption and label
# 
# \begin{table}[!htbp] \centering \caption{Sample Model Results}\label{tab:sample_results}\begin{tabular}{lrrrr}  \hline \hline  \addlinespace[0.3em] \multicolumn{1}{l}{} & \multicolumn{4}{c}{\textsc{Mismatch}} \\ \addlinespace[0.3em] \textsc{Predictors} & \textsc{Estimate} & \textsc{SE} & \textsc{z-stat} & \textsc{p-value} \\ \hline \\ Intercept & 0.47 & 0.08 & 6.16 & \textbf{<0.01} *** \\Variable 1 & 1.24 & 0.03 & 41.34 & \textbf{<0.01} *** \\Variable 2 & -0.85 & 0.05 & -17.78 & \textbf{<0.01} *** \\ \\ \textsc{\textbf{Random Effects}} \\  \addlinespace[0.3em]  Number of Groups & 50 \\ SD Groups & 0.49 \\\\ \hline \\ Observations & 10000 \\ R2 (marginal) & 0.33 \\ R2 (conditional) & 0.29 \\ AIC & 10944.16 \\ \\ \bottomrule \end{tabular} \end{table}
# %Model Summary
# 
# 
# %\begin{table}\centering
# %	\begin{tblr}[         %% tabularray outer open
# %		]                     %% tabularray outer close
# %		{                     %% tabularray inner open
# %			colspec={Q[]Q[]},column{1}={halign=l,},column{2}={halign=c,},hline{15}={1,2}{solid, 0.05em, black},}                     %% tabularray inner close
# %			\toprule& (1) \\ \midrule %% TinyTableHeader
# %			(Intercept)                        & \num{-0.323}  \\& (\num{0.495}) \\COUNTRY\_OF\_ORIGINpr            & \num{-0.807}  \\& (\num{0.507}) \\LOG\_LEX\_FREQ\_DF\_N\_SCALED & \num{0.248}   \\& (\num{0.090}) \\MS\_PER\_SYLL\_SCALED           & \num{-0.303}  \\& (\num{0.089}) \\PLUS                               & \num{0.033}   \\& (\num{0.007}) \\POS\_WORDinternal                 & \num{-0.574}  \\& (\num{0.182}) \\SD (Intercept SPEAKER)             & \num{1.034}   \\Num.Obs.                           & \num{857}     \\R2 Marg.                           & \num{0.277}   \\R2 Cond.                           & \num{0.454}   \\AIC                                & \num{907.4}   \\BIC                                & \num{940.6}   \\ICC                                & \num{0.2}     \\RMSE                               & \num{0.40}    \\\bottomrule\end{tblr}\end{table} 
# 
# %%% Stargazer
# %\input{/Users/leeannvidal/Desktop/Dissertation/R_Code/Data_Analysis/Master_Project/output/tables/statistical/logistic_regression_trill.tex}