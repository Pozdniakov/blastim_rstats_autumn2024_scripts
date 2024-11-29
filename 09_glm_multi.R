
install.packages("ez")
library(ez)

diet <- readr::read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/stcp-Rdataset-Diet.csv")

diet <- diet %>%
  mutate(weight.loss = pre.weight -weight6weeks,
         Dietf = factor(Diet, labels = LETTERS[1:3])) %>%
  drop_na()

#Repeated-measures anova

diet_long <- diet %>%
  pivot_longer(cols = c(pre.weight, weight6weeks),
               names_to = "time",
               values_to = "weight")

ezANOVA(data = diet_long,
        dv = weight,
        wid = Person,
        within = time)

#Factorial anova
# 3x2 ANOVA

ezANOVA(
  data = diet,
  dv = weight.loss,
  wid = Person,
  between = .(Dietf, gender)
)

pd <- position_dodge()

diet %>%
  mutate(gender = ifelse(gender == 1, "Male", "Female")) %>%
  group_by(Dietf, gender) %>%
  summarise(m = mean(weight.loss),
            se = sd(weight.loss)/sqrt(n())) %>%
  ungroup() %>%
  ggplot(aes(x = Dietf, y = m)) +
  geom_col(aes(fill = gender), position = position_dodge(width=0.9))


ezANOVA(
  data = diet_long,
  dv = weight,
  wid = Person,
  within = time,
  between = .(Dietf, gender)
)

# GiLM --------------------------------------------------------------------

heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv",
                   na = c("-99", "-", "", "NA"))

heroes_good <- heroes %>%
  mutate(good = Alignment == "good") %>%
  drop_na(Weight, Gender, Alignment)

heroes_good_glm <- glm(good ~ Weight + Gender, heroes, family = binomial())
summary(heroes_good_glm)

heroes_good_glm_noweight <- glm(good ~ Gender, heroes, family = binomial())
summary(heroes_good_glm_noweight)


# LMER --------------------------------------------------------------------

#install.packages("lme4")
library(lme4)
data("sleepstudy")
?sleepstudy
sleepstudy %>%
  ggplot(aes(x = Days, y = Reaction)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = 0:9) +
  facet_wrap(~Subject)

sleep_lme0 <- lmer(Reaction ~ Days + (1 | Subject), sleepstudy)
sleep_lme1 <- lmer(Reaction ~ Days + (Days|Subject), sleepstudy)

sleepstudy$predicted_by_sleep_lme0 <- predict(sleep_lme0)
sleepstudy$predicted_by_sleep_lme1 <- predict(sleep_lme1)

sleepstudy %>%
  pivot_longer(cols = c(Reaction, starts_with("predicted_")),
               names_to = "model",
               values_to = "Reaction") %>%
  ggplot(aes(x = Days, y = Reaction, colour = model)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = 0:9) +
  facet_wrap(~Subject)

anova(sleep_lme0, sleep_lme1)


# Многомерные методы ------------------------------------------------------

install.packages("palmerpenguins")
library(palmerpenguins)
penguins <- penguins %>%
  drop_na()
penguins %>%
  select(bill_length_mm:body_mass_g) %>%
  plot(col = penguins$species)

penguins_3means <- penguins %>%
  select(bill_length_mm:body_mass_g) %>%
  mutate(across(bill_length_mm:body_mass_g, function(x) (x - mean(x))/sd(x) )) %>%
  kmeans(3)
str(penguins_3means)
penguins$cluster <- penguins_3means$cluster
table(penguins$species, penguins$cluster)
penguins_selected_cols <- penguins %>%
  select(bill_length_mm:body_mass_g)

plot(2:12, map(2:12, function(x) kmeans(penguins_selected_cols, centers = x)) %>%
  map_dbl(function(x) 1 - x$tot.withinss/x$totss))

hclust_mtcars <- mtcars %>%
  dist() %>%
  hclust()

plot(hclust_mtcars)

penguins_prcomp <- penguins %>%
  select(bill_length_mm:body_mass_g) %>%
  prcomp(center = TRUE, scale. = TRUE)

summary(penguins_prcomp)
plot(penguins_prcomp)
plot(penguins_prcomp$x[, 1:2], col = penguins$species)

install.packages("factoextra")
library(factoextra)

fviz_pca_ind(penguins_prcomp,
             habillage = penguins$species,
             addEllipses = TRUE,
             repel = TRUE)

fviz_pca_var(penguins_prcomp)

fviz_pca_biplot(penguins_prcomp,
                habillage = penguins$species,
                addEllipses = TRUE,
                repel = TRUE)
