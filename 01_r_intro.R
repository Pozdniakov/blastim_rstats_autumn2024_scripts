2 + 2
3 * 4
7 / 2
7 %/% 2
7 %% 2
7 ^ 2
(2 + 2) * 2
16 ^ .5
sqrt(16)
SQRT(16)
log(8)
?log
log(x = 8, base = 2)
?sqrt
log(8, 2)
log(8, sqrt(4))
`+`(5, 8)

pi
sin(pi)
2 ^ 1000
options(scipen = 999)
sin(pi)
a = sqrt(4) #we don't do it here! (but it works)
a <- sqrt(16)
b <- 3
2 + 2
e <- a ^ b - b / a
log(b, a)
rm(e)
#rm(list = ls())
a == b
a != b
#5!=125 #joke about mathematicians and programmers

a > b
a < b
a >= b
a >= a
a <= b
b <= b

typeof(3.4)
typeof(3)
typeof(3L)
is.integer(3L)
as.integer(3)
3
typeof(4+3i)
s <- "hi everyone"
s2 <- 'hey, "hey"'
s2
4 + 4
typeof(s2)

paste("i", "love", "R")
paste("i", "love", "R", sep = "_<3_🍕")
paste("i", "love", "R", sep = "")
paste0("i", "love", "R")

comparison <- a >= a
comparison
t1 <- TRUE
f1 <- FALSE

!t1
!f1
!!t1

t1 & t1 #TRUE
t1 & f1 #FALSE
f1 & t1 #FALSE
f1 & f1 #FALSE

f1 | f1 #FALSE
t1 | f1 #TRUE
f1 | t1 #TRUE
t1 | t1 #TRUE
#xor(t1, t1)
age <- 31
age >= 18 & age < 30

c(4, 8, 15, 16, 23, 42)
c("hey", "hey", "ha")
paste("hey", "hey", "ha")
c(TRUE, FALSE)
c(3, 4)
1:10
5:-5
10:10:100

seq(10, 100, by = 10)
seq(1, 13, length.out = 7)
seq_len(12)
seq_along(c(4, 8, 15, 16, 23, 42))
length(c(4, 8, 15, 16, 23, 42))
rep(1, 5)
rep(1:4, 3)
rep(1:4, c(4, 8, 15, 2))
rep(1:4, 3)
rep(1:4, each = 3)
rep(c("Hey", "how"), 40)
sum(1:100)
mean(1:100)

1:20:1
1:20
20:1
c(1:20, 19:1)
rep(1:9, 1:9)

roots <- sqrt(1:10)
roots
c(FALSE, 2)
c(2L, 3.4)
c(TRUE, 3, "hi")

2 + TRUE
2 + FALSE

as.numeric(c(TRUE, FALSE, FALSE))
as.integer(c(TRUE, FALSE, FALSE))
as.character(c(TRUE, FALSE, FALSE))
as.character(as.integer(c(TRUE, FALSE, FALSE)))

as.numeric(c("1", "2", "three"))

n <- 1:4
m <- 4:1
n
m
n + m
n - m
n * m
n / m
n ^ m
n - m ^ m / n + m
sin(1:10)
sqrt(1:10) * sqrt(1:10)
log(1:10, base = 10:1)
1/0
-1/0
m <- c(10, 100)
n
m
n + m
n * 10
k <- c(10, 100, 1000)
n * k
k * n

1:20 * rep(0:1, 10)
1:20 * 0:1
(1:10) ^ 2
2 ^ (1:10)
sum(1 / 2 ^ (0:20))
sum((2 ^ (0:20)) ^ -1)
sum(seq(1, 28, by = 3) / 3 ^ (0:9) > 0.5)
?sum

n <- c(0, 1, 1, 2, 3, 5, 8, 13, 21, 34)
n[1]
n[10]
n[length(n)]
head(n)
head(n, 2)
tail(n)
tail(n, 1)
n[3] <- 20
n
n[3:7]
n
#`[`(n, 3:7)
n[length(n):1]
n
rev(n)
n[4:6] <- 0
n
#n[3:5, 8:9]
n[c(3:5, 8:9)]
n[-1]
n[-6]
n[-3:-6]
n[-1]
n
n[c(TRUE, FALSE, TRUE, FALSE, TRUE,
    FALSE, TRUE, FALSE, TRUE, FALSE)]
n[c(TRUE, FALSE)]

named_vector <- c(first = 1L, second = 2L, third = 3L)
named_vector
named_vector[c("third", "second")]
names(named_vector)
letters
LETTERS
letters[1:3]
names(named_vector) <- letters[1:3]
named_vector
typeof(named_vector)
typeof(names(named_vector))

n
mean(n)
n[n > mean(n)]

y=c(T,F,T,F,T,F,T,F,T,F,T,F,T,F,T,F,T,F,T,F)
i=2:20
i[y] 

(2:20)[c(TRUE,FALSE)]
(1:20)[c(FALSE, TRUE)]
1:10 * 2
c(1:20)*c(0,1)

test10 = 1:20
test10[rep(c(FALSE, TRUE), 10)]
test10[c(FALSE, TRUE)]

test10[test10 %% 2 == 0]
test10[!(test10 %% 2) != 0]
as.logical(-5:5)

seq(2, 20, 2)
test10[seq(2, 20, 2)]
c(1, 2, 7:9)
seq(0, 1, .01)
c(1:10, seq(2, 20, 2))

2:20[c(TRUE,FALSE)]
1[1]
(2:20)[c(TRUE, FALSE)]
2 + 0:9*2
1:10 * 2
c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20)

1:10 * 2
seq(2, 20, by = 2)
