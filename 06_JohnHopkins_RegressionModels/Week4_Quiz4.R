library(MASS)
data("shuttle")
str(shuttle)
shuttle$usebin <- as.numeric(shuttle$use == "auto") # create a binary variable
fit <- glm(usebin ~ factor(wind) - 1, family = "binomial", data = shuttle)
(Coef <- coef(summary(fit)))
(coef.odds <- exp(c(Coef[1, 1], Coef[2, 1])))
(odds.ratio <- coef.odds[1] / coef.odds[2]) # "head" is the reference

############################################################################################

fit2 <- glm(usebin ~ factor(wind) + factor(magn) - 1, family = "binomial", data = shuttle)
(Coef2 <- coef(summary(fit2)))
coef2.odds <- exp(c(Coef2[1, 1], Coef2[2, 1]))
(odds2.ratio <- coef2.odds[1] / coef2.odds[2]) # "head" is the reference

############################################################################################
## Q4
data(InsectSprays)
str(InsectSprays)
fit4 <- glm(count ~ factor(spray), family = "poisson", data = InsectSprays)
(Coef4 <- coef(summary(fit4))) # "A" is the reference
exp(Coef4[1, 1]) / exp(Coef4[1, 1] + Coef4[2, 1])

## ALTERNATIVE
fit <- glm(count ~ relevel(spray, "B"), data = InsectSprays, family = poisson)
exp(coef(fit))[2]


############################################################################################
## Q5
fit5 <- glm(count ~ factor(spray) + offset(log(rep(sum(count), length(count)))), 
            family = "poisson", data = InsectSprays)
fit5_10 <- glm(count ~ factor(spray) + 
                   offset(log(10) + log(rep(sum(count), length(count)))), 
               family = "poisson", data = InsectSprays)
coef(summary(fit5))
coef(summary(fit5_10))

############################################################################################
## Q6
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
knots <- 0
(splineTerms <- sapply(knots, function(knot) (x > knot) * (x - knot)))
(xMat <- cbind(1, x, splineTerms))
(fit6 <- lm(y ~ xMat - 1))
yhat <- predict(fit6)
plot(x, y, frame = FALSE, pch = 21, bg = "lightblue", cex = 2)
lines(x, yhat, col = "red", lwd = 2)
fit6$coef[2] + fit6$coef[3]

## ALTERNATIVE
z <- (x > 0) * x
fit <- lm(y ~ x + z)
sum(coef(fit)[2:3])
