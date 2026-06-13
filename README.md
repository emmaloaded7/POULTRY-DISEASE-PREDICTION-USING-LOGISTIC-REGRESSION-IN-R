# POULTRY DISEASE PREDICTION USING LOGISTIC REGRESSION IN R

## PROJECT OVERVIEW

This project develops and evaluates a logistic regression model for predicting disease occurrence in poultry birds
using physiological and production-related characteristics. The analysis was conducted in R and follows a complete 
predictive modeling workflow including exploratory data analysis, model development, model diagnostics, model selection,
performance evaluation, and prediction on new observations.

The primary objective is to identify factors associated with disease occurrence and build an interpretable predictive model 
that can assist in early disease detection.

====================================================================

## RESEARCH OBJECTIVES

Explore the relationship between bird characteristics and disease occurrence.
Identify significant predictors of disease.
Develop logistic regression models with different predictor combinations.
Compare competing models using Akaike Information Criterion (AIC).
Assess multicollinearity among predictors.
Evaluate predictive performance using a hold-out test dataset.
Predict disease probability for new birds.

====================================================================

## DATASET DESCRIPTION

The dataset contains poultry observations with the following variables:

Disease : Disease status (Yes/No)
Temperature_C : Body temperature (°C)
Age_Weeks : Bird age in weeks
Feed_Intake_g : Feed intake in grams
Weight_kg : Body weight in kilograms

Disease status serves as the binary response variable.

====================================================================

## METHODOLOGY

## DATA IMPORT AND EXPLORATION

The dataset was imported from a CSV file and subjected to preliminary inspection using:

Dataset dimensions
Variable names
Summary statistics
Frequency distributions

This step ensured data quality and understanding of variable structure.

====================================================================

## DATA PREPARATION

Disease status was converted into a factor variable:

dataset$Disease <- as.factor(dataset$Disease)

This allows logistic regression to recognize the response as a binary categorical outcome.

====================================================================

## EXPLORATORY DATA ANALYSIS

Boxplots were generated to compare predictor distributions between diseased and non-diseased birds.

Variables examined:

Age
Weight
Feed Intake
Temperature

A scatterplot was also created to investigate the relationship between Age and Weight.

Correlation analysis revealed:

cor(Age_Weeks, Weight_kg) = 0.97

This indicates an extremely strong positive relationship between Age and Weight.

====================================================================

## DATA PARTITIONING

The dataset was split into:

Training Set (80%)
Testing Set (20%)

A random seed was used to ensure reproducibility.

====================================================================

## LOGISTIC REGRESSION MODELS

Five candidate models were developed.

MODEL 1

Disease ~ Temperature_C

Purpose:
Assess the predictive ability of temperature alone.

MODEL 2

Disease ~ Temperature_C + Age_Weeks + Feed_Intake_g

Purpose:
Evaluate whether age and feed intake improve prediction beyond temperature.

MODEL 3

Disease ~ Temperature_C + Weight_kg

Purpose:
Assess the contribution of weight when combined with temperature.

MODEL 4

Disease ~ Temperature_C + Weight_kg + Feed_Intake_g

Purpose:
Investigate the combined effects of production and physiological indicators.

MODEL 5

Disease ~ Temperature_C + Age_Weeks + Weight_kg + Feed_Intake_g

Purpose:
Evaluate the full model containing all available predictors.

====================================================================

MODEL INTERPRETATION

Logistic regression coefficients were transformed into Odds Ratios using:

exp(coef(model))

This improves interpretability by expressing predictor effects in terms of changes in disease odds.

Confidence intervals for Odds Ratios were computed using:

exp(confint(model))

====================================================================

## MULTICOLLINEARITY ASSESSMENT

Variance Inflation Factors (VIF) were calculated using:

library(car)
vif(model5)

Results:

Temperature_C : 1.25
Age_Weeks : 110.32
Feed_Intake_g : 1.64
Weight_kg : 108.53

## INTERPRETATION

Temperature and Feed Intake showed acceptable VIF values.

However, Age and Weight exhibited extremely high VIF values (>100), indicating severe multicollinearity.

This finding was expected because Age and Weight had a correlation coefficient of 0.97.

Severe multicollinearity can:

Inflate standard errors
Destabilize coefficient estimates
Reduce interpretability

Therefore, caution is required when interpreting Model 5.

====================================================================

## MODEL SELECTION

Candidate models were compared using Akaike Information Criterion (AIC).

Model 1 : 111.64
Model 2 : 53.93
Model 3 : 109.74
Model 4 : 50.44
Model 5 : 27.85

Model 5 achieved the lowest AIC.

However, severe multicollinearity was detected.

Consequently, Model 4 was selected as the final model because it provides a more stable and interpretable solution 
while maintaining strong predictive performance.

====================================================================

## FINAL MODEL

Disease ~ Temperature_C + Weight_kg + Feed_Intake_g

Advantages:

Low AIC
No severe multicollinearity
Biologically interpretable
Strong predictive capability

====================================================================

## MODEL EVALUATION

Predicted probabilities were generated for the testing dataset.

Predictions were converted into disease classifications using a 0.5 threshold.

A confusion matrix was generated to compare predictions with observed disease status.

Classification accuracy was calculated.

## RESULT

Accuracy = 87.5%

INTERPRETATION

The final model correctly classified approximately 88% of birds in the testing dataset,
indicating excellent predictive performance.

====================================================================

## PREDICTING DISEASE IN NEW BIRDS

Example:

Temperature_C = 41
Weight_kg = 3.6
Feed_Intake_g = 146

Disease probability can be estimated using the fitted logistic regression model and subsequently 
converted into a disease classification.

====================================================================

## KEY FINDINGS

Temperature is the strongest predictor of disease occurrence.
Feed Intake contributes useful predictive information.
Weight improves prediction when combined with Temperature and Feed Intake.
Age and Weight are highly correlated.
Severe multicollinearity was detected in the full model.
Model 4 provided the best balance between predictive performance and interpretability.
The final model achieved approximately 87.5% classification accuracy.

====================================================================

## CONCLUSION

This study demonstrates that logistic regression can effectively predict disease occurrence in poultry birds using 
readily measurable production and physiological indicators.

Although the full model achieved the lowest AIC, severe multicollinearity between Age and Weight reduced model 
interpretability. After diagnostic assessment, Model4 was selected as the final model because it maintained 
strong predictive performance while avoiding severe multicollinearity.

The resulting model achieved approximately 87.5% accuracy and can serve as a practical tool for supporting early disease 
detection and management decisions in poultry production systems.

====================================================================

## SOFTWARE

R
Base R Statistics
car Package (VIF Analysis)

====================================================================

## AUTHOR

Ometoro Emmanuel

Research Project
Machine Learning and Statistical Modeling Using R
