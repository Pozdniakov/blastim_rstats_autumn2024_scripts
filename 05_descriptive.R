library(tidyverse)
heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv",
                   na = c("-99", "-", "", "NA"))

weight <- heroes %>%
  drop_na(Weight) %>%
  pull(Weight)


# Меры центральной тенденции ----------------------------------------------

mean(weight)
sum(weight)/length(weight)

sort(weight)[ceiling(length(weight)/2)]
median(weight)

mean(c(weight, 900000))
median(c(weight, 900000))
median(c(1, 5, 6, 9, 20))
median(c(1, 5, 6, 9, 20, 100))

heroes %>%
  count(`Eye color`, sort = TRUE)

sort(table(heroes$`Eye color`))
?mean

mean(weight, trim = .1)
mean(weight, trim = .5)

# Меры рассеяния ----------------------------------------------------------

diff(range(weight))

mean((weight - mean(weight)) ^ 2)
var(weight)

sqrt(sum((weight - mean(weight)) ^ 2)/(length(weight) - 1))
sd(weight)

sd(c(weight, 900000))

z_score <- function(x) (x - mean(x, na.rm = TRUE))/sd(x, na.rm = TRUE)
z_score(heroes$Height)
z_score(heroes$Weight)
scale(weight)

mad(weight)
mad(c(weight, 900000))
IQR(weight)
IQR(c(weight, 900000))

median(abs(weight - median(weight))) * 1.4826

install.packages("psych")
psych::skew(weight)
psych::kurtosi(weight)

summary(weight)
summary(heroes)
psych::describe(weight)

heroes %>%
  group_by(Gender) %>%
  summarise(psych::describe(Weight))

install.packages("skimr")
skimr::skim(heroes)

heroes %>%
  group_by(Gender) %>%
  skimr::skim(c(Height, Weight))

xxx <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/d.csv")
xxx
min(xxx$x)
summary(xxx)
skimr::skim(xxx)
psych::describe(xxx)
plot(xxx)
cor(xxx)


# Визуализация данных в базовом R -----------------------------------------------------

plot(heroes$Height, heroes$Weight)
plot(heroes$Weight)
#plot(seq_along(heroes$Weight), heroes$Weight)
iris
plot(iris %>% select(!Species))

hist(weight, breaks = 30)

boxplot(heroes$Weight ~ heroes$Gender)


# ggplot2 -----------------------------------------------------------------

empty_gg <- ggplot()

#scatterplot

ggplot() +
  geom_point(data = heroes %>% drop_na(Gender), aes(x = Height,
                                y = Weight,
                                size = Weight,
                                shape = Gender),
             size = 8
             ) +
  scale_shape_manual(values = c("Male" = "🐘",
                                "Female" = "🐅")) 

#barplot
heroes$Gender
heroes %>%
  count(Gender)

ggplot() +
  geom_bar(data = heroes, 
           aes(x = "", fill = Alignment), 
           position = "fill") +
  coord_polar(theta = "y") +
  scale_fill_brewer(palette = "Set1")

ggplot() +
  geom_col(data = heroes %>% count(Gender), aes(x = Gender, y = n))

#histogram

ggplot() +
  geom_density(data = heroes,
                 aes(x = Weight, fill = Gender),
                 position = "identity",
                 alpha = 0.5)

ggplot() +
  geom_histogram(data = heroes,
               aes(x = Weight),
               alpha = 0.5)

ggplot(data = heroes, aes(x = Gender, y = Weight)) +
  # geom_point(data = heroes,
  #            aes(x = Gender,
  #                y = Weight),
  #            alpha = .5,
  #            position = position_jitter(width = .1)) +
  geom_violin(aes(fill = Gender)) +
  geom_boxplot(outlier.shape = NA, width = .1) +
  scale_y_log10() +
  labs(x = "Пол супергероев", y = "Масса супергероев",
       title = "Violin plot массы супергероев", 
       subtitle = "Масса зависит от пола",
       caption = "Blastim, осень 2024") +
  hrbrthemes::theme_ipsum()


