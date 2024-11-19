library(tidyverse)
heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv",
                   na = c("-99", "-", "", "NA"))
t.test(heroes$Weight, mu = 100)
t.test(heroes$Height, mu = 185)

diet <- readr::read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/stcp-Rdataset-Diet.csv")

diet1 <- diet %>%
  filter(Diet == 1)

diet1
t.test(diet1$pre.weight, diet1$weight6weeks, paired = TRUE)

diet1_long <- diet1 %>%
  pivot_longer(cols = c(pre.weight, weight6weeks),
               names_to = "time",
               values_to = "weight")

diet1_long %>%
  pivot_wider(names_from = time,
              values_from = weight) %>%
  {t.test(.$pre.weight, .$weight6weeks, paired = TRUE)}

diet1_wide <- diet1_long %>%
  pivot_wider(names_from = time,
              values_from = weight)

t.test(diet1_wide$pre.weight, diet1_wide$weight6weeks, paired = TRUE)

diet1_long$weight
diet1_long$time
t.test(diet1_long$weight ~ diet1_long$time, paired = TRUE)

diet2 <- diet %>%
  filter(Diet == 2)
t.test(diet2$pre.weight, diet2$weight6weeks, paired = TRUE)

diet3 <- diet %>%
  filter(Diet == 3)
t.test(diet3$pre.weight, diet3$weight6weeks, paired = TRUE)

diet12 <- diet %>%
  filter(Diet %in% 1:2)

diet12 %>%
  count(Diet)

t.test(diet12$weight6weeks ~ diet12$Diet, paired = FALSE)
t.test(diet12$weight6weeks ~ diet12$Diet, paired = FALSE, var.equal = TRUE)

heroes_white_black <- heroes %>%
  filter(`Eye color` %in% c("white", "black"))
t.test(heroes_white_black$Weight ~ heroes_white_black$`Eye color`)

shapiro.test(rnorm(5000))
#ks.test
qqnorm(samp)
qqnorm(rlnorm(100))

qqnorm(diet1$weight6weeks)
qqnorm(rnorm(length(diet1$weight6weeks)))

hist(diet1$weight6weeks, breaks = 10)
hist(rnorm(length(diet1$weight6weeks)))

weight <- heroes %>%
  drop_na(Weight) %>%
  pull(Weight)

qqnorm(weight)
qqnorm(rnorm(length(weight)))

hist(weight)
hist(rnorm(length(weight)))

tt <- t.test(rnorm(30), rnorm(30), paired = FALSE, var.equal = TRUE)
str(tt)
tt$p.value
many_p <- replicate(10000, t.test(rnorm(30), rnorm(30), paired = FALSE, var.equal = TRUE)$p.value)
mean(many_p < .05)
hist(many_p)

many_p_log <- replicate(10000, t.test(rlnorm(30), rlnorm(30), paired = FALSE, var.equal = TRUE)$p.value)
mean(many_p_log < .05)
hist(many_p)

hist(rlnorm(30))

diet %>%
  group_by(Diet) %>%
  summarise(m = mean(weight6weeks),
            sd = sd(weight6weeks))

t.test(diet12$weight6weeks ~ diet12$Diet, paired = FALSE)

diet1
t.test(diet1$pre.weight, diet1$weight6weeks, paired = TRUE)
wilcox.test(diet1$pre.weight, diet1$weight6weeks, paired = TRUE)

t.test(diet12$weight6weeks ~ diet12$Diet)
wilcox.test(diet12$weight6weeks ~ diet12$Diet)

diet13 <- diet %>%
  filter(Diet %in% c(1, 3))

t.test(diet13$weight6weeks ~ diet13$Diet)
wilcox.test(diet13$weight6weeks ~ diet13$Diet)

diet3 <- diet %>%
  filter(Diet == 3)
t.test(diet3$pre.weight, diet3$weight6weeks, paired = TRUE)
wilcox.test(diet3$pre.weight, diet3$weight6weeks, paired = TRUE)

gender_publisher <- heroes %>%
  drop_na(Gender, Publisher) %>%
  filter(Publisher %in% c("Marvel Comics", "DC Comics")) %>%
  select(Gender, Publisher) 

gender_publisher %>%
  count(Gender, Publisher)

table(gender_publisher)

61/(61 + 153)
111/(111 + 252)

111/(111 + 61)
252/(252 + 153)

summary(table(gender_publisher))
chisq.test(table(gender_publisher))

fisher.test(table(gender_publisher))

mosaicplot(table(gender_publisher))


alignment_publisher <- heroes %>%
  drop_na(Alignment, Publisher) %>%
  filter(Publisher %in% c("Marvel Comics", "DC Comics")) %>%
  select(Alignment, Publisher) 

chisq.test(table(alignment_publisher))
mosaicplot(table(alignment_publisher), color = TRUE, shade = TRUE)

pub_good <- heroes %>%
  filter(Alignment %in% c("good", "bad")) %>%
  select(Alignment, Gender) %>%
  drop_na()

chisq.test(table(pub_good))
chisq.test(table(pub_good), correct = FALSE)
fisher.test(table(pub_good))
mosaicplot(table(pub_good), color = TRUE, shade = TRUE)

heroes %>%
  count(Race == "Human")

heroes <- heroes %>%
  mutate(is_human = Race == "Human")

heroes %>%
  drop_na(is_human) %>%
  group_by(is_human) %>%
  summarise(mean(Gender == "Female", na.rm = TRUE))

human_gender <- heroes %>%
  select(is_human, Gender) %>%
  drop_na()

table(human_gender)
chisq.test(table(human_gender))
fisher.test(table(human_gender))
mosaicplot(table(human_gender), color = TRUE, shade = TRUE)

