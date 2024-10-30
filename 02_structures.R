eyes <- c("green", "blue", "blue", "brown", "green", "blue")
sum(eyes == "blue")
#sum(as.numeric(eyes == "blue"))
sum(eyes == "blue")/length(eyes == "blue")
paste0(mean(eyes == "blue") * 100, "%")

all(eyes == "blue")
any(eyes == "blue")
any(!eyes == "blue")

which(eyes == "blue")
eyes[eyes == "blue"]
eyes[eyes == "blue"| eyes == "green"]
eyes[eyes == c("green", "blue")]

eyes %in% c("green", "blue")

respondents <- c("Moscow", "Voronezh", "Kazan", "Novosibirsk",
                 "Moscow", "Novosibirsk", "Moscow", "Balashikha",
                 "Odintzovo", "Khabarovsk")
millions <- c("Moscow", "St. Petersburg", "Kazan", "Novosibirsk",
              "Voronezh", "Ufa", "Omsk")
respondents[respondents %in% millions]


# NA ----------------------------------------------------------------------

missed <- NA
missed == "NA"
missed == ""
missed == 0
missed == NA
NA == NA
Mary <- NA
John <- NA
Mary == John
40 == NA

n <- c(0, 1, 1, 2, 3, 5, 8, 13, 21, 34)
n[5] <- NA
n
mean(n)
n == NA
mean(n[!is.na(n)])
#посчитайте среднее вектора n без использования is.na()

m <- n
m[is.na(m)] <- 0
m
mean(m)
mean(n[!is.na(n)])
n[-5]
n
?na.exclude
c(na.exclude(n))
?mean
mean(n, na.rm = TRUE)
typeof(NA)
NA
NA_character_
NA_integer_
NA_real_
NA_complex_

as.character(n)
is.logical(n[5])
typeof(n)
typeof(n[4])
typeof(n[5])
n[5]

NA
NaN
1/0
-1/0
0/0
mean(c(NA, NA, NA), na.rm = TRUE)
is.nan(NaN)
is.na(NaN)
is.nan(NA)
is.na(NA)
NA ^ 0
NA & FALSE

A <- matrix(1:20, nrow = 5, ncol = 4)
A
A[3, 2]
A[2:4, 2:3]
A[c(TRUE, FALSE, TRUE, FALSE, TRUE),
  c(TRUE, FALSE, TRUE, FALSE)]
A[, 1:2]
A[2:3, ]
A[,] <- 100
A
A <- 100
A


A <- matrix(1:20, nrow = 5, ncol = 4)
A[2:4, 2:3] <- 100
A
attributes(A)
attributes(A) <- NULL
A
B <- matrix(c("Welcome", "to", "the",
         "matrix", "Neo", "!"),
       nrow = 2)
attributes(B)
B[1:4]
A
attr(A, "dim") <- c(10, 2)
A
attr(A, "dim") <- c(5, 2, 2)
A
A[2, 2, 1]
A <- matrix(1:20, nrow = 5, ncol = 4)
A[-3, -2]
rep(1:9, 9) * rep(1:9, each = 9)
matrix(rep(1:9, 9) * rep(1:9, each = 9), nrow = 9)

outer(1:9, 1:9, `*`)
1:9 %o% 1:9

simple_list <- list(42, "Hey", TRUE)
simple_list
c(42, "Hey", TRUE)
complex_list <- list(1:10, letters, simple_list, A, mean, `[`)
complex_list
str(complex_list)

named_list <- list(
  name = "Sardina",
  age = 37,
  student = TRUE
)
named_list
named_list$name
named_list$age
named_list[1]
class(named_list$name)
class(named_list[1])
named_list[1]
named_list[[1]]
named_list["age"]
named_list[["age"]]
named_list$age

list1 <- list(numbers = 1:5, letters = letters, logic = TRUE)
list2 <- list(pupa = list1, lupa = list1)
list2
list2[1]
list2[[1]][2]
list2$pupa$letters
list2[[1]][[2]][3]

list_of_people <- list(
  name = c("Sardina", "Gulgena", "Slava", "Andrej", "Xavier", "Pupa"),
  age = c(37, 100, 22, 4, 115, 43),
  student = c(TRUE, FALSE, TRUE, TRUE, FALSE, TRUE)
)
str(list_of_people)

df <- data.frame(
  name = c("Sardina", "Gulgena", "Slava", "Andrej", "Xavier", "Pupa"),
  age = c(37, 100, 22, 4, 115, 43),
  student = c(TRUE, FALSE, TRUE, TRUE, FALSE, TRUE)
)
str(df)
df
df[1,1]
df[2:5, 1:2]
df[, 2]
df$age
df[df$age > mean(df$age),]
df[df$student, c("age", "name")]
df[df$name == "Slava",]
df[df$name %in% c("Slava", "Andrej"),]
df[,c("name", "age")]
df[1:2]

df$lovesR <- TRUE
df
df$lovesR <- NULL
df
rbind(df, df)
mtcars
?mtcars
mtcars$hp > 100
mtcars[mtcars$hp > 100,]
nrow(mtcars[mtcars$hp > 100,])
ncol(mtcars[mtcars$hp > 100,])
dim(mtcars[mtcars$hp > 100,])
sum(mtcars$hp > 100)
mean(mtcars$hp > 100)
mtcars$wt_kg <- round(0.453592 * 1000 * mtcars$wt)
rownames(installed.packages(priority = "base"))
?mean
?median

install.packages("beepr")
library(beepr)
beep(6)
?beep
mean(1:1000000000)
beep()
beepr::beep()
?beep
install.packages("BiocManager")
BiocManager::install("flowCore")
BiocManager::install("treeio")

library(treeio)
install.packages("remotes")
remotes::install_github("brooke-watson/BRRR", force = TRUE)

if(!require(devtools)) {install.packages("devtools")}
devtools::install_github("brooke-watson/BRRR")

BRRR::skrrrahh(23)

install.packages("rdracor")
library(rdracor)
emilia <- get_net_cooccur_igraph(play = "lessing-emilia-galotti", corpus = "ger")
plot(emilia)
class(emilia)

install.packages("glue")
read.csv("/Users/ivan/Desktop/heroes_information.csv")
read.csv("heroes_information.csv")
getwd()
heroes <- read.csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv")
?read.csv
heroes <- read.table("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv",
           header = TRUE, sep = ",", quote = "\"", dec = ".", 
           na.strings = c("-", "-99", "NA", ""))

