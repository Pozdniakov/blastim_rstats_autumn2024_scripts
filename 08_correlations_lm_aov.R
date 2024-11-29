#install.packages("Stat2Data")
library(Stat2Data)
library(tidyverse)
data(Backpack)
?Backpack
skimr::skim(Backpack)

#создайте новые колонки backpack_kg и body_kg
  #в которых будет масса в кг а не в фунтах

back <- Backpack %>%
  mutate(backpack_kg = BackpackWeight * 0.453592,
         body_kg  = BodyWeight * 0.453592)

back %>%
  select(body_kg, backpack_kg) %>%
  cov()

back %>%
  select(body_kg, backpack_kg) %>%
  var()

back %>%
  select(BodyWeight, BackpackWeight) %>%
  cov()

back %>%
  select(body_kg, backpack_kg) %>%
  cor()

cor(back$BackpackWeight, back$backpack_kg)

cor.test(back$body_kg, back$backpack_kg)
?cor.test
cor.test(back$body_kg,
         back$backpack_kg,
         method = "spearman")
cor.test(back$body_kg,
         back$backpack_kg,
         method = "kendall")

back %>%
  ggplot() +
  geom_point(aes(x = body_kg,
                 y = backpack_kg), alpha = .3, size = 3)

cor.test(back$BackpackWeight, back$BodyWeight)

heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv",
                   na = c("-99", "-", "", "NA"))
cor.test(heroes$Height, heroes$Weight)
cor.test(heroes$Height, heroes$Weight, method = "spearman")
cor.test(heroes$Height, heroes$Weight, method = "kendall")
heroes %>%
  ggplot() +
  geom_point(aes(x = Height, y = Weight))

x <- rlnorm(30)
y <- rlnorm(30)
plot(log(x), log(y))

t.test(back$backpack_kg ~ back$BackProblems, var.equal = TRUE)
cor.test(back$backpack_kg, back$BackProblems)

back %>%
  select(body_kg, backpack_kg, Units, Year) %>%
  cor()

back %>%
  select(body_kg, backpack_kg, Units, Year) %>%
  psych::corr.test()

set.seed(42)
sham_results <- as.data.frame(matrix(rnorm(1000 * 20), ncol = 20)) 
sham_cors <- psych::corr.test(sham_results)
(20 ^ 2 - 20)/2 * 0.05
str(sham_cors)
sum(sham_cors$p < 0.05) - 20

back %>%
  select(body_kg, backpack_kg, Units, Year) %>%
  psych::corr.test(adjust = "bonferroni")

back %>%
  select(body_kg, backpack_kg, Units, Year) %>%
  psych::corr.test()

back %>%
  select(body_kg, backpack_kg, Units, Year) %>%
  psych::corr.test(adjust = "BH")

back %>%
  select(body_kg, backpack_kg, Units, Year) %>%
  psych::corr.test(adjust = "fdr")  

p_vec <- seq(0.0001, 0.06, length.out = 10)
p_vec
p.adjust(p_vec, method = "fdr")

mtcars
cor(mtcars)
psych::corr.test(mtcars)

install.packages("corrr")

corrr::correlate(mtcars) %>%
  corrr::shave() %>%
  corrr::fashion()

install.packages("corrplot")
library(corrplot)
mtcars_cors <- psych::corr.test(mtcars)
str(mtcars_cors)
corrplot(mtcars_cors$r,
         p.mat = mtcars_cors$p,
         method = "color",
         order = "hclust",
         col = rev(COL2('PRGn', 200)))
?corrplot

corrr::correlate(mtcars) %>%
  corrr::network_plot(min_cor = .7)

cor.test(back$body_kg, back$backpack_kg)
model <- lm(backpack_kg ~ body_kg, data = back)

back %>%
  ggplot() +
  geom_point(aes(x = body_kg,
                 y = backpack_kg), alpha = .3, size = 3) +
  geom_abline(intercept = model$coefficients[1],
              slope = model$coefficients[2])

str(model)
predict(model, newdata = data.frame(body_kg = 100))
100 * model$coefficients[2] + model$coefficients[1]

predict(model, newdata = data.frame(body_kg = 1000))
predict(model, newdata = data.frame(body_kg = 0))

model
summary(model)
options(scipen = 999)
mean(back$backpack_kg - model$fitted.values)
RSS <- sum((model$residuals)^2)
TSS <- sum((back$backpack_kg - mean(back$backpack_kg))^2 )
TSS
1 - RSS/TSS
cor.test(back$body_kg, back$backpack_kg)
class(model)
plot(model)

model_mult <- lm(backpack_kg ~ body_kg + Units, data = back)
summary(model_mult)

model_mult2 <- lm(backpack_kg ~ body_kg + Units + Year, data = back)
summary(model_mult2)
install.packages("car")
car::vif(model_mult2)

diet <- readr::read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/stcp-Rdataset-Diet.csv")

diet <- diet %>%
  mutate(weight.loss = weight6weeks - pre.weight,
         Dietf = factor(Diet, labels = LETTERS[1:3])) %>%
  drop_na()

aov_model <- aov(weight.loss ~ Dietf, diet)
#Дисперсионный анализ = ANalysis Of VAriance (ANOVA)
#H0: mu1 = mu2 =....= mun
#H1: at least one pair of mu_i != mu_j
summary(aov_model)
pairwise.t.test(diet$weight.loss, diet$Dietf,
                p.adjust.method = "none", pool.sd = FALSE)

TukeyHSD(aov_model)

summary(lm(weight.loss ~ Dietf, diet))
summary(aov(weight.loss ~ Dietf, diet))

summary(lm(weight.loss ~ gender, diet))
t.test(weight.loss ~ gender, diet, var.equal = TRUE)

hist(residuals(aov_model))
qqnorm(residuals(aov_model))
qqnorm(rnorm(length(residuals(aov_model))))

diet %>%
  group_by(Dietf) %>%
  summarise(sd(weight.loss))

?levene.test
car::leveneTest(diet$weight.loss, diet$Dietf)

