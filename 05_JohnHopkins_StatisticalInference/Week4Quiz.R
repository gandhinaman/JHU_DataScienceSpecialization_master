## Statistical Inference Quiz 4

#########################################################################################
## Q1
subject <- c(1,2,3,4,5)
baseline <- c(140,138,150,148,135)
week2 <- c(132,135,151,146,130)
examinations <- data.frame(subject, baseline, week2)
examinations
test <- t.test(x = examinations$baseline, y = examinations$week2, alt = "two.sided", paired = TRUE)
pval <- test$p.value


#########################################################################################
## Q2
n <- 9
mu <- 1100
sd <- 30
quantile <- qt(1-0.05/2, n-1) # is 95% with 2.5% on both sides of the range
mu + c(-1, 1) * t * sd / sqrt(n)
confidenceInterval = mu + c(-1, 1) * quantile * sd / sqrt(n)
confidenceInterval


#########################################################################################
## Q3
n <- 4
x <- 3
test <- binom.test(x=x, n=n, alt="greater")
round(test$p.value,2)


#########################################################################################
## Q4
lambda <- 1 / 100 * 1787
# Probability of 10 or less people infected given expected lambda people infected.
ppois(10, lambda)

rate <- 1/100
errors <- 10
days <- 1787
test <-  poisson.test(errors, T = days, r = rate, alt="less")
round(test$p.value,2)


#########################################################################################
## Q5
n_y <- 9 # subjects treated
n_x <- 9 # subjects placebo
??_y <- 1.5# kg/m2 std.dev. treated 
??_x <- 1.8# kg/m2 std.dev. placebo 
??_y <- -3#  kg/m2 average difference treated
??_x <- 1#  kg/m2 average difference placebo

# calculate pooled standard deviation
??_p <- (((n_x - 1) * ??_x^2 + (n_y - 1) * ??_y^2)/(n_x + n_y - 2))
pval <- pt((??_y - ??_x) / (??_p * (1 / n_x + 1 / n_y)^.5), df=n_y + n_x -2)
pval


#########################################################################################
## Q7
power.t.test(n=100, delta=.01, sd=.04, alt="one.sided", type="one.sample",sig.level=.05)$power


#########################################################################################
## Q8
power.t.test(delta=.01, sd=.04, alt="one.sided", type="one.sample", sig.level=.05, power=.9)$n
