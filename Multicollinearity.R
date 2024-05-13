# Multicollinearity
#install.packages("GGally")
library(ggplot2)
library(GGally) 
library(corrplot)

#Reading the data
dat_1 <- read.csv("https://online.stat.psu.edu/stat462/sites/onlinecourses.science.psu.edu.stat462/files/data/bloodpress/index.txt", sep = "\t")
dat_1 <- read.table("https://online.stat.psu.edu/stat462/sites/onlinecourses.science.psu.edu.stat462/files/data/bloodpress/index.txt")
dat_1 <- read.table("https://online.stat.psu.edu/stat462/sites/onlinecourses.science.psu.edu.stat462/files/data/bloodpress/index.txt", header = TRUE)
summary(dat_1) #what do we know?
names(dat_1)

#Basics
BP.lm <- lm(BP ~ Weight + Stress, dat_1)
BP.lm 
summary(BP.lm)
BP.aov <- aov(BP ~ Weight + Stress, dat_1)
BP.aov
?aov
summary(BP.aov)
BP.lm
names(BP.lm) 
summary(BP.lm) #to get ANOVA results

#BP_hat = 1.71 + 1.195*Weight + 0.019 * Stress
dat_1
#intervals of predicted values
new.dat <- data.frame(Weight = 90, Stress = 50)
new.dat <- data.frame(Weight = c(90,71), Stress = c(50,51))
new.dat
predict(BP.lm, newdata = new.dat)
predict(BP.lm, newdata = new.dat, interval = 'confidence')
predict.lm(BP.lm, newdata = new.dat, interval = 'confidence', level = 0.95)
predict.lm(BP.lm, newdata = new.dat, interval = 'confidence', level = 0.99)
predict(BP.lm, newdata = new.dat, interval = 'prediction')

#intervals of coefficients
confint(BP.lm)
confint(BP.lm, level = 0.99)

#MULTICOLLINEARITY
#interested in determining if a relationship exists between blood pressure and age, weight, body surface area, pulse rate and/or stress level.
#The matrix plot of BP, Age, Weight, and BSA:
names(dat_1)
pairs(dat_1[,2:5], pch = 16) 
pairs(dat_1[,2:5], pch = 1, lower.panel = NULL)

#matrix plot of BP, Dur, Pulse, and Stress:
pairs(dat_1[,c(2,6:8)], pch = 1, lower.panel = NULL) #note the lower.panel change
help(pairs)
?pch

pairs(dat_1, pch = 1, lower.panel = NULL)

#allow us to investigate the various marginal relationships between the response BP (Y) and the predictors (Xi). 
#Blood pressure appears to be related fairly strongly to Weight and BSA, and hardly related at all to Stress level.
#The matrix plots also allow us to investigate whether or not relationships exist among the predictors (Xi). #multicollinearity 
#For example, Weight and BSA appear to be strongly related, while Stress and BSA appear to be hardly related at all.
dev.off()
#plot a correlation matrix
cor_mat <- cor(dat_1)
cor_mat #this is enough
corrplot(cor_mat, type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45)
corrplot(cor_mat, method = "number", type = "lower",order = "hclust", 
         tl.col = "black", tl.srt = 45)

#what if i want both?
Scatter_Matrix <- ggpairs(dat_1,columns = c(2:5), 
                          title = "Scatter Plot Matrix for BP Dataset", 
                          axisLabels = "show") 
#ggsave("Scatter plot matrix.png", Scatter_Matrix, width = 7, 
      # height = 7, units = "in") 
Scatter_Matrix

# Blood pressure appears to be related fairly strongly to Weight (r = 0.950) and BSA (r = 0.866), and hardly related at all to Stress level (r = 0.164). 
# Weight and BSA appear to be strongly related (r = 0.875), while Stress and BSA appear to be hardly related at all (r = 0.018). 
# The high correlation among some of the predictors suggests that data-based multicollinearity exists.
# impact of multicollinearity on regression analysis. 

#contrived data set (uncorrpreds.txt), in which the predictors are perfectly uncorrelated:
dat_2 <- read.table("https://online.stat.psu.edu/stat462/sites/onlinecourses.science.psu.edu.stat462/files/data/uncorrpreds/index.txt",  fileEncoding = "UTF-16", header = TRUE) #check.names = F)
dat_2
names(dat_2)
#can use fread to check encoding
#TASK: make a scatterplot matrix of dat_2
pairs(dat_2[,c(3,1,2)], pch = 16, lower.panel = NULL)
#As you can see there is no apparent relationship at all between the predictors x1 and x2. That is, the correlation between x1 and x2 is zero.
cor(dat_2)

#Uncorrelated predictors
#Regress y on x1, the y on x2

reg1.lm <- lm(y ~ x1, dat_2)
summary(reg1.lm)
reg2.lm <- lm(y ~ x2, dat_2)
summary(reg2.lm)
reg3.lm <- lm(y ~ x1 + x2, dat_2)
summary(reg3.lm)
reg4.lm <- lm(y ~ x2 + x1, dat_2)
summary(reg4.lm)

aov1.model <- aov(y ~ x1, dat_2)
summary(aov1.model)
aov2.model <- aov(y ~ x2, dat_2)
summary(aov2.model)
aov3.model <- aov(y ~ x1 + x2, dat_2)
summary(aov3.model)
aov4.model <- aov(y ~ x2 + x1, dat_2)
summary(aov4.model)

#Highly correlates predictors
#y = BP and the predictors x2 = Weight and x3 = BSA:
names(dat_1)
pairs(dat_1[,c(2,5,4)], pch = 1, lower.panel = NULL)  
cor(dat_1)
names(dat_1)
reg1.lm <- lm(BP ~ Weight, dat_1)
summary(reg1.lm)
reg2.lm <- lm(BP ~ BSA, dat_1)
summary(reg2.lm)
reg3.lm <- lm(BP ~ Weight + BSA, dat_1)
summary(reg3.lm)
reg4.lm <- lm(BP ~ BSA + Weight, dat_1)
summary(reg4.lm)

aov1.model <- aov(BP ~ Weight, dat_1)
summary(aov1.model)
aov2.model <- aov(BP ~ BSA, dat_1)
summary(aov2.model)
aov3.model <- aov(BP ~ Weight + BSA, dat_1)
summary(aov3.model)
aov4.model <- aov(BP ~ BSA + Weight, dat_1)
summary(aov4.model)

#effect 1: coefficients depend on each other
#depending on which predictors we include in the model, we obtain wildly different estimates of the slope parameter for x3 = BSA
#The high correlation among the two predictors is what causes the large discrepancy. 
# When interpreting b3 = 34.4 in the model that excludes x2 = Weight, keep in mind that when we increase x3 = BSA then x2 = Weight also increases and both factors are associated with increased blood pressure.
# However, when interpreting b3 = 5.83 in the model that includes x2 = Weight, we keep x2 = Weight fixed, so the resulting increase in blood pressure is much smaller.

#effect2 : precision dec as mopre variables added
#look at SE, inc, hence wider CIs, therefore less precise


#Effect3 : marginal effects of variables included depends on variables already presemt
#both adding and reversing order
#look at coefficients

#Effect4 : hypothesis tests for βk = 0 may yield different conclusions depending on which predictor variables are in the model
#look at the p values in the different models.

library(car)
reg6.lm <- lm(BP ~ Age + Weight +BSA + Dur + Pulse + Stress, dat_1)
summary(reg6.lm)
aov6.model <- aov(BP ~ Age + Weight +BSA + Dur + Pulse + Stress, dat_1)
summary(aov6.model)
vif(reg6.lm)
#three of the variance inflation factors —8.42, 5.33, and 4.41 —are fairly large.




