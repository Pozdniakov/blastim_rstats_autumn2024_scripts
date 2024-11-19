dnorm(0)
dnorm(1)
dnorm(-1)
dnorm(3)
dnorm(-3)
vec <- seq(-4, 4, .1)
vec
dnorm(vec)
plot(vec, dnorm(vec))

dnorm(100, mean = 100, sd = 15)
iq <- 50:150
plot(iq, dnorm(iq, mean = 100, sd = 15))

pnorm(0)
pnorm(-1)
pnorm(1)
pnorm(3)

pnorm(100, mean = 100, sd = 15)
pnorm(130, mean = 100, sd = 15)
1 - pnorm(130, mean = 100, sd = 15)
pnorm(110, mean = 100, sd = 15)
# prob <- seq(0, 1, 0.01)
# plot(prob, qnorm(prob, qnorm(prob, mean = 100, sd = 15)))

set.seed(42)
samp <- rnorm(100, mean = 100, sd = 15)
samp
hist(samp, breaks = 10)
samp
m <- mean(samp)
n <- length(samp)
sqrt(sum((samp - m) ^ 2)/(n-1))
sd(samp)

#CI95%

sample_means <- replicate(1000000, mean(rnorm(100, mean = 100, sd = 15)))
hist(sample_means, breaks = 100)
mean(sample_means)
sd(sample_means)

hist(rlnorm(10000), breaks = 100)
sample_log_means <- replicate(1000000, mean(rlnorm(30)))
hist(sample_log_means, breaks = 100)

qnorm(.975)
m - sd(samp)/sqrt(n) * qnorm(.975)
m + sd(samp)/sqrt(n) * qnorm(.975)

1 - (1 - 0.95)/2

samp
#1 формулирование гипотез
#Н0: mu = 100
#H1: mu != 100
#2 считаем статистику
z_emp <- (m - 100)/(15/sqrt(n))
z_emp
#3 считаем p-value
options(scipen = 999)
(1 - pnorm(z_emp)) * 2
#4 делаем выводы

set.seed(42)
samp <- rnorm(100, mean = 100, sd = 15)
samp
t.test(samp, mu = 100)

#1 формулирование гипотез
#Н0: mu = 100
#H1: mu != 100
#2 считаем статистику
t_emp <- (m - 100)/(sd(samp)/sqrt(n))
t_emp
#3 считаем p-value
options(scipen = 999)
#(1 - pt(t_emp, df = length(samp) - 1)) * 2
pt(t_emp, df = length(samp) - 1) * 2
#4 делаем выводы
