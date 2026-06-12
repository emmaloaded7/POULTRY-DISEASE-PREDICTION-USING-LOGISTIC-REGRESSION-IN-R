# Imports the dataset from a CSV file
dataset <- read.csv(file.choose())

# Displays the number of rows (observations) and columns (variables) in the dataset.
dim(dataset)

# Lists all variable names available in the dataset.
names(dataset)

# Displays the first six observations to inspect the structure of the data.
head(dataset)

# Provides descriptive statistics including minimum, maximum, mean, median and quartiles.
summary(dataset)

# Converts Disease into a categorical variable so logistic regression can 
#recognize it as a binary outcome
dataset$Disease <- as.factor(dataset$Disease)

# Confirms that Disease has been converted to a factor variable
summary(dataset)

#Displays the frequency distribution of disease cases (Yes/No).
table(dataset$Disease)

# Compares age distribution between diseased and non-diseased birds.
boxplot(Age_Weeks ~ Disease,
        data = dataset,
        main = "Age by Disease Status",
        xlab = "Disease",
        ylab = "Age (Weeks)")

# Examines whether body weight differs according to disease status.
boxplot(Weight_kg ~ Disease,
        data = dataset,
        main = "Weight by Disease Status",
        xlab = "Disease",
        ylab = "Weight(kg)")

# Investigates the relationship between feed intake and disease occurrence.
boxplot(Feed_Intake_g ~ Disease,
        data = dataset,
        main = "Feed Intake by Disease Status",
        xlab = "Disease",
        ylab = "Feed Intake(g)")

# Examines whether body temperature differs between healthy and diseased birds.
boxplot(Temperature_C ~ Disease,
        data = dataset,
        main = "Temperature by Disease Status",
        xlab = "Disease",
        ylab = "Tenperature(c)")

# Visualizes the relationship between age and weight.
plot(dataset$Age_Weeks, dataset$Weight_kg, main = "Age_weeks vs Weight_kg",
     xlab = "Age(Weeks)", ylab = "Weight")

# Adds a fitted linear regression line to visualize the trend
abline(lm(Weight_kg ~ Age_Weeks,
          data = dataset),
       col = "blue",
       lwd = 3)

# Measures the strength and direction of the linear relationship between age and weight.
cor(dataset$Age_Weeks,
    dataset$Weight_kg)
# 0.97 Extremely strong relationship

# Ensures reproducibility of the random sampling process.
set.seed(123)

# Randomly selects 80% of observations for training.
train_index <- sample(1:nrow(dataset), 0.8*nrow(dataset))

# Creates the training dataset
train <- dataset[train_index, ]

# Creates the testing dataset.
test <- dataset[-train_index, ]

# Fits a logistic regression model predicting disease status using temperature alone.
model1 <- glm(Disease ~ Temperature_C, data = train, family= binomial())

# Model1 summary
summary(model1)
# For every 1°C increase in temperature, the log-odds of disease increase by 4.4243 units.

round(exp(coef(model1)), digits = 2)
# For every 1°C increase in temperature, the odds of disease are multiplied by approximately 83.46.
# p-value < 0.05, Therefore: Temperature is a statistically significant predictor of disease occurrence.

round(exp(confint(model1)), digits = 2)

# Predict disease with temperature adjusting for Age and Feed Intake
model2 <- glm(Disease ~ Temperature_C + Age_Weeks + Feed_Intake_g, data = train, family= binomial())

summary(model2)
# For every 1°C increase in temperature, the log-odds of disease increase by 4.924 units
# adjusting for age and feed intake.
# When age increase by a week, the log-odds of disease descrease by 0.255 units
# Keeping Temperature and Feed Intake constant.
# For every increase in feed Intake, the log-odds of disease decrease by 0.161 units.
# p-value < 0.05, temperature is a significant predictor of disease.
# p value Age is > 0.05, Age is not scientific significant
# p value Feed Intake is > 0.05, Significant predictor of disease

round(exp(coef(model2)), digits = 2)
# Holding age and feed intake constant, a 1°C increase in temperature multiplies 
# the odds of disease by approximately 137.58 times.
# One-week increase in age is associated with a 23% decrease in the odds of disease, 
# but this effect is not statistically significant.
# Holding temperature and age constant, each additional gram of feed intake reduces 
# the odds of disease by approximately 15%.

round(exp(confint(model2)), digits = 2)

# Predict disease with temperature adjusting for Weight
model3 <- glm(Disease ~ Temperature_C + Weight_kg, data = train, family= binomial())

summary(model3)
# p-value < 0.05, temperature is a significant predictor of disease.
# p value Weight is > 0.05, Weight is not scientific significant

round(exp(coef(model3)), digits = 2)
# Holding weight constant, a 1°C increase in temperature multiplies 
# the odds of disease by approximately 91.93 times.
# Holding temperature constant, a 1 kg increase in weight multiplies 
# the odds of disease by 0.51.

round(exp(confint(model3)), digits = 2)

# Predict disease with temperature adjusting for Weight and Feed Intake
model4 <- glm(Disease ~ Temperature_C + Weight_kg + Feed_Intake_g, data = train, family= binomial())

summary(model4)
# For every 1°C increase in temperature, the log-odds of disease increase by 5.043 units
# adjusting for Weight and feed intake.
# When Weight increase by 1kg, the log-odds of disease descrease by 1.221 units
# Keeping Temperature and Feed Intake constant.
# For every increase in feed Intake, the log-odds of disease decrease by 0.166 units.
# p-value < 0.05, temperature is a significant predictor of disease.
# p value Weight is < 0.05, Weight is a significant predictor of disease
# p value Feed Intake is < 0.05, Significant predictor of disease

round(exp(coef(model4)), digits = 2)
# Holding weight and feed intake constant, a 1°C increase in temperature multiplies 
# the odds of disease by approximately 154.97 times.
# Holding temperature and feed intake constant, a 1 kg increase in weight decrease 
# the odds of disease by 70%.
# Holding temperature and weight constant, each additional gram of feed intake decrease
# the odds of disease by 85%.
round(exp(confint(model4)), digits = 2)

# Predict disease with temperature adjusting for Age and Feed Intake and Weight_kg
model5 <- glm(Disease ~ Temperature_C + Age_Weeks + Feed_Intake_g + Weight_kg, data = train, family= binomial())

summary(model5)
# For every 1°C increase in temperature, the log-odds of disease increase by 5.079 units
# adjusting for Age, Weight and feed intake.
# When Age increase by 1 week, the log odds of disease increase by 10.69 units
# For every increase in feed Intake, the log-odds of disease decrease by 0.207 units.
# When Weight increase by 1kg, the log-odds of disease descrease by 25.58 units
# Keeping Temperature, Weight and Feed Intake constant.

# p-value < 0.05, temperature is a significant predictor of disease.
# p-value of age < 0.05, Age is a significant predictor of disease.
# p-value Weight is < 0.05, Weight is a significant predictor of disease
# p-value Feed Intake is < 0.05, Significant predictor of disease

library(car)

# Calculates Variance Inflation Factors (VIF) to assess
# multicollinearity among predictor variables in the model.
vif(model5)
# Severe multicollinearity exists between Age_Weeks and Weight_kg.
# This may lead to unstable coefficient estimates and unreliable
# interpretation of individual predictor effects.

round(exp(coef(model5)), digits = 2)
# Holding weight and feed intake constant, a 1°C increase in temperature multiplies 
# the odds of disease by approximately 160.77 times.
# Holding temperature and feed intake constant, a 1 kg increase in weight decrease 
# the odds of disease by < 5%.
# Holding temperature and weight constant, each additional gram of feed intake decrease
# the odds of disease by 9%.

# Compares model fit using Akaike Information Criterion.
AIC(model1, model2, model3, model4, model5)
# Although Model5 has the lowest AIC, severe multicollinearity
# was detected between Age_Weeks and Weight_kg (VIF > 100).
# Therefore, Model4 was selected as the final model because it
# provides a more stable and interpretable solution.

# Generates predicted probabilities of disease for the test dataset.
test_prob <- predict(model4,
                     newdata = test,
                     type = "response")

# Converts probabilities into predicted classes using a 0.5 threshold.
test_pred <- ifelse(test_prob > 0.5,
                    "Yes",
                    "No")
# Produces a confusion matrix comparing predictions with actual outcomes.
table(Predicted = test_pred,
      Actual = test$Disease)

# Calculates classification accuracy.
mean(test_pred == test$Disease)

# Create a new bird with known characteristics
newbird <- data.frame(Temperature_C=41, Weight_kg=3.6, Feed_Intake_g=146)

# Estimate probability of disease using the fitted model
prob <- predict(model4,
                newdata = newbird,
                type = "response")
# Display predicted probability
print(prob)

# Classify bird as diseased or non-diseased
ifelse(prob > 0.5, "Yes", "No")

