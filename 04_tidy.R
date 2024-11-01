library(tidyverse)
heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv",
                       na = c("-99", "-", "", "NA"))

heroes %>%
  select(name, Publisher, Gender)

heroes %>%
  relocate(sort(names(.)))


# Работа со строками ------------------------------------------------------

heroes %>%
  slice(c(1, 100, 200))

heroes %>%
  filter(Publisher == "DC Comics")

heroes %>%
  filter(Weight > 100 & Weight < 120)

heroes %>%
  filter(Weight > 100, Weight < 120)

heroes %>%
  filter(Weight > 100) %>%
  filter(Weight < 120) %>%
  slice(30:39)

heroes %>%
  slice_max(Weight, n = 3)

heroes %>%
  slice_min(Weight, n = 3) %>%
  pull(name)

heroes %>%
  slice_sample(n = 3)
heroes %>%
  slice_sample(prop = .01)
heroes %>%
  slice_sample(prop = 1)

heroes %>%
  drop_na()
heroes %>%
  drop_na(Height, Weight)

heroes %>%
  filter(Gender == "Female") %>%
  filter(Race == "Human") %>%
  slice(1:5)

# Сортировка строк --------------------------------------------------------

heroes %>%
  arrange(desc(Weight))

heroes %>%
  arrange(Race, Weight, Publisher)


# Создание колонок --------------------------------------------------------
options(scipen = 999)
#heroes$imt <- heroes$Weight/(heroes$Height/100)^2

heroes %>%
  mutate(imt = Weight/(Height/100)^2, .after = name)

heroes %>%
  transmute(name, Gender, imt = Weight/(Height/100)^2) #mutate() + select()

#heroes$what_about_hair <- ifelse(heroes$`Hair color` == "No Hair", "Bold", "Hairy")

heroes %>%
  mutate(hair = ifelse(`Hair color` == "No Hair", "Bold", "Hairy")) %>%
  select(name, `Hair color`, hair)

heroes %>%
  transmute(name, `Hair color`, hair = ifelse(`Hair color` == "No Hair", "Bold", "Hairy"))


# Агрегация --------------------------------------------------------------

heroes %>%
  summarise(weight_mean = mean(Weight, na.rm = TRUE),
            weight_max = max(Weight, na.rm = TRUE),
            weight_first = first(Weight),
            weight_last = last(Weight),
            weight_tenth = nth(Weight, 10))

heroes %>%
  summarise(weight_mean = mean(Weight, na.rm = TRUE),
            weight_max = max(Weight, na.rm = TRUE),
            weight_first = Weight[1],
            weight_last = Weight[length(Weight)],
            weight_tenth = Weight[10])

heroes %>%
  reframe(range(Weight, na.rm = TRUE))

heroes %>%
  group_by(Gender, Alignment) %>%
  summarise(weight_mean = mean(Weight, na.rm = TRUE),
            weight_max = max(Weight, na.rm = TRUE),
            weight_first = first(Weight),
            weight_last = last(Weight),
            weight_tenth = nth(Weight, 10))

heroes %>%
  group_by(Gender) %>%
  summarise(n = n())

heroes %>%
  count(Gender, Alignment, sort = TRUE)

heroes %>%
  count(Race, sort = TRUE)

heroes %>%
  group_by(Race) %>%
  filter(n() > 10)

heroes %>%
  group_by(Race) %>%
  filter(n() == 1)

heroes %>%
  group_by(Gender) %>%
  mutate(mean_weight_by_gender = mean(Weight, na.rm = TRUE), .after = Gender) %>%
  ungroup() %>%
  mutate(weight_diff = Weight - mean_weight_by_gender, .after = mean_weight_by_gender)

heroes %>%
  summarise(mean(Weight, na.rm = TRUE), .by = Gender)


# Заключение: основные функции dplyr ----------------------------------

#select() отбор колонок
#filter() отбор строк по условию
#mutate() создание новых колонок
#group_by() + summarise() аггрегация по группам

# Соединение датафреймов --------------------------------------------------

band_members
band_instruments

bind_cols(band_members, band_instruments)
bind_rows(band_members, band_instruments)
list_bands <- list(members = band_members, instruments = band_instruments)
bind_rows(list_bands, .id = "from_tibble")
#merge()

left_join(band_members, band_instruments)
band_members %>%
  left_join(band_instruments)
names(band_members)
names(band_instruments)
intersect(names(band_members), names(band_instruments))

band_members %>%
  left_join(band_instruments, by = "name")

band_members %>%
  left_join(band_instruments2, by = join_by(name == artist)) 

band_members %>%
  right_join(band_instruments)
band_instruments %>%
  left_join(band_members)

band_members %>%
  full_join(band_instruments)
band_members %>%
  inner_join(band_instruments)

band_members %>%
  semi_join(band_instruments)
band_members %>%
  filter(name %in% band_instruments$name)
band_members %>%
  anti_join(band_instruments)
band_members %>%
  filter(!name %in% band_instruments$name)

band_instruments %>%
  anti_join(band_members)

powers <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/super_hero_powers.csv")
powers

# пайпы внутри пайпов -----------------------------------------------------

heroes %>%
  mutate(upper_names = name %>% toupper())

# широкие и длинные данные ------------------------------------------------


new_diet <- tibble(
  student = c("Маша", "Рома", "Антонина"),
  before_r_course = c(70, 80, 86),
  after_r_course = c(63, 74, 71)
)
new_diet
new_diet %>%
  pivot_longer(before_r_course:after_r_course,
               names_to = "time",
               values_to = "weight") %>%
  pivot_wider(names_from = "time",
              values_from = "weight")

powers %>%
  pivot_longer(cols = `Agility`:last_col(),
               names_to = "superpower",
               values_to = "has")

names(powers)


# across() ----------------------------------------------------------------

heroes %>%
  drop_na(Height, Weight) %>%
  group_by(Gender) %>%
  summarise(mean_height = mean(Height),
            mean_weight = mean(Weight))

heroes %>%
  drop_na(Height, Weight) %>%
  group_by(Gender, Alignment) %>%
  summarise(across(where(is.numeric), mean))
  
heroes %>%
  #drop_na(Height, Weight) %>%
  group_by(Gender) %>%
  summarise(across(where(is.numeric), function(x) mean(x, na.rm = TRUE)))

heroes %>%
  filter(Height > 170) %>%
  #drop_na(Height, Weight) %>%
  group_by(Gender) %>%
  summarise(across(where(is.numeric), mean, na.rm = TRUE))

heroes %>%
  #drop_na(Height, Weight) %>%
  group_by(Gender, Height > 170) %>%
  summarise(across(where(is.numeric), mean, na.rm = TRUE))

heroes %>%
  group_by(Gender) %>%
  summarise(across(where(is.character),
                   function(x) mean(nchar(x), na.rm = TRUE)),
            across(where(is.numeric), mean, na.rm = TRUE))

heroes %>%
  drop_na(Weight, Height) %>%
  group_by(Gender) %>%
  summarise(across(c(Height, Weight),
                   list(minimum = min,
                        average = mean,
                        maximum = max)))

heroes %>%
  mutate(across(where(is.character), as.factor))

iris %>%
  mutate(across(where(is.numeric), function(x) (x - mean(x))/sd(x) ))

iris %>%
  mutate(across(where(is.numeric), function(x) round(x / max(x) * 100) ))


# nesting -----------------------------------------------------------------

is.vector(list(1, 2))
is.atomic(list(1, 2))

nested_heroes <- heroes %>%
  nest(!Gender)

heroes %>%
  group_by(Gender) %>%
  nest() %>%
  mutate(dim = map(data, dim)) %>%
  unnest(dim)

heroes %>%
  group_by(Gender) %>%
  nest() %>%
  mutate(dim = map(data, dim)) %>%
  unnest_wider(dim, names_sep = "_")

films <- tribble(
  ~film, ~genres,
  "Назад в будущее", "comedy, sci-fi, advanture",
  "Властелин колец: Братство кольца", "fantasy, advanture",
  "Пыль", "art-house, drama, sci-fi"
)
str_split(films$genres, pattern = ", ")

films %>%
  mutate(genres = str_split(genres, pattern = ", ")) %>%
  unnest() %>%
  mutate(value = TRUE) %>%
  pivot_wider(names_from = genres, values_from = value, values_fill = FALSE)

films %>%
  separate_rows(genres, sep = ", ") %>%
  mutate(value = TRUE) %>%
  pivot_wider(names_from = genres, values_from = value, values_fill = FALSE)

