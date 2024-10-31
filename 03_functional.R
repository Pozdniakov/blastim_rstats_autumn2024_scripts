
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

mean(1:100)
list(median, c, list, mean)
factors[1]

A <- matrix(1:12, 3)
A
rowSums(A)
rowMeans(A)
colSums(A)
colMeans(A)

as.matrix(heroes)

apply(A, 2, mean)
A[2, 2] <- NA
A
apply(A, 2, mean, na.rm = TRUE)

B <- matrix(
  c("Welcome", "to", "the",
    "matrix", "Neo", "!"),
  nrow = 2, byrow = TRUE
)
B
ch_vec <- c("Welcome", "to", "the",
  "matrix", "Neo", "!")
sum_nchar <- function(x) sum(nchar(x))
sum_nchar(ch_vec)
sum_nchar(letters)
apply(B, 1, sum_nchar)
apply(B, 1, function(text) sum(nchar(text)))
#apply(B, 1, \(text) sum(nchar(text)) )

some_list <- list(some = 1:10, list = letters)
length(some_list)
lapply(some_list, length)
sapply(some_list, length)

install.packages("purrr")
library(purrr)
map(some_list, length)
map_int(some_list, length)
map(some_list, 3)

install.packages("tictoc")
library(tictoc)
tic()
mean(map_dbl(1:10000000, log))
toc()
tic()
mean(sapply(1:10000000, log))
toc()
tic()
mean(log(1:10000000))
toc()

factors <- function(x) which(x %% seq_len(x) == 0)
is_prime <- function(x) length(factors(x)) == 2
is_prime(102)
is_prime(100:110)
is_prime_vectorized <- Vectorize(is_prime)
is_prime_vectorized(100:110)
sapply(100:110, is_prime)
map_lgl(100:110, is_prime)
cumsum(1:10)

mean(rlnorm(100))
hist(replicate(1000, mean(rlnorm(100))))

heroes
install.packages("data.table")
library(data.table)

heroes_dt <- fread("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv",
      na.strings = c("-99", "-", "", "NA"))
class(heroes_dt)
attributes(heroes_dt)
heroes_dt
str(heroes_dt)

heroes_dt[Alignment == "good",
          .(height_mean = mean(Height, na.rm = TRUE)),
          by = Gender][order(-height_mean),]

install.packages("tidyverse")
library(tidyverse)

heroes_tbl <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv",
         na = c("-99", "-", "", "NA"))
class(heroes_tbl)
heroes_tbl
heroes_tbl %>%
  filter(Alignment == "good") %>%
  group_by(Gender) %>%
  summarise(height_mean = mean(Height, na.rm = TRUE)) %>%
  arrange(desc(height_mean))

sum(log(sqrt(abs(sin(1:22)))))
1:22 %>% 
  sin() %>% 
  abs() %>% 
  sqrt() %>% 
  log(x = 2, base = .) %>% 
  sum()

2 %>%
c("Корень из", ., "равен", sqrt(.))

B <- matrix(10:39, nrow = 5)
apply(B, 1, mean)

10:39 %>%
  matrix(nrow = 5) %>%
  apply(1, mean)

map_int(some_list, length)
some_list %>%
  map_int(length)

1:22 |>
  sin() |> 
  abs() |> 
  sqrt() |> 
  log(x = 2, base = _) |> 
  sum()

heroes[,1:2]
as_tibble(heroes)

heroes_tbl %>%
  select(1, 5, 10)
heroes_tbl %>%
  select(name, Race, Publisher, `Eye color`)

heroes_selected_columns <- heroes_tbl %>%
  select(name, Race, Publisher, `Eye color`)

heroes_selected_columns

heroes_tbl %>%
  select(name:Publisher)

heroes_tbl %>%
  select(name:`Eye color`, Publisher:Weight)

heroes_tbl %>%
  select(!...1)

heroes_tbl %>%
  select(!(Gender:Height))

heroes_tbl %>%
  select(name:last_col())
#last_col()

heroes_tbl %>%
  select(name, Publisher, everything())

heroes_tbl %>%
  select(ends_with("color"))

heroes_tbl %>%
  select(starts_with("H") & ends_with("color"))

heroes_tbl %>%
  select(contains("eigh"))

heroes_tbl %>%
  select(where(is.numeric))

heroes_tbl %>%
  select(where(is.character))

heroes_tbl %>%
  select(where(function(x) !any(is.na(x)) ))

heroes_tbl %>%
  select(where(function(x) mean(is.na(x)) < .1 ))

heroes_tbl %>%
  select(id = ...1)

heroes_tbl %>%
  rename(id = ...1)

heroes_tbl %>%
  rename_with(make.names)

heroes_tbl %>%
  rename_with(toupper)
#names(heroes_tbl) <-  make.names(names(heroes_tbl))

heroes_tbl %>%
  relocate(Universe = Publisher, where(is.numeric), .after = name)

heroes_tbl %>%
  select(name)

class(heroes)
heroes[, 1, drop = FALSE]

heroes_tbl %>%
  select(name) %>%
  pull()
heroes_tbl %>%
  pull(name)
heroes_tbl %>%
  pull(Weight, name)
