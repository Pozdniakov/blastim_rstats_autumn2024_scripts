
# Условные конструкции ----------------------------------------------------


number <- c(-2:2, Inf, NA, NaN)

if (number > 0) {
  "Positive number" 
} else if (number < 0) {
  "Negative number"
} else {
  "zero"
}

ifelse(number > 0, "Positive number", "Negative number or zero")
number > 0

ifelse(number > 0, 
       "Positive number", 
       ifelse(number < 0,
              "Negative number",
              "zero"))

#install.packages("dplyr")
dplyr::case_when(
  is.na(number) ~ NA_character_,
  number > 0    ~ "Positive number", #if
  number < 0    ~ "Negative number", #else if
  .default = "zero" #else
)

heroes <- read.csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv",
                   na.strings = c("-99", "-", "", "NA"))

heroes$weight_group <- ifelse(heroes$Weight > 200, "overweight", "normal weight")

heroes$weight_group <- dplyr::case_when(
  is.na(heroes$Weight) ~ NA_character_, #if
  heroes$Weight > 200 ~ "overweight", #else if
  heroes$Weight > 120 ~ "somewhat overweight", #else if
  heroes$Weight < 50 ~ "underweight", #else if
  .default = "typical weight" #else
)

#  Создание функций -------------------------------------------------------

2 ^ 3
m <- 10
pow <- function(x, 
                p = 2, 
                whatever = paste(x, "в степени", p, "равен", power)) {
  power <- x ^ p
  whatever
}
pow(2)
pow(10, 4)
options(scipen = 999)
10^10
pow(10)

mass <- 100
height <- 1.9

imt <- function(m, h) m/h ^ 2
imt(120, 1.5)

which(12 %% seq_len(12) == 0)
# 1:length(integer())
# seq_len(length(integer()))
# seq_along(integer())

factors <- function(x) which(x %% seq_len(x) == 0)
factors(200)


# Семейство функций apply() -----------------------------------------------


