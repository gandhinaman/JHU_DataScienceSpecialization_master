data("mtcars")
mtcars$cyl <- as.factor(mtcars$cyl)

## Q1
(fit1 <- lm(mpg ~ wt + cyl, data = mtcars))
summary(fit1)

## Q2
(fit2 <- lm(mpg ~ cyl, data = mtcars))
summary(fit2)

## Q3
(fit3 <- lm(mpg ~ wt*cyl, data = mtcars))
summary(fit3)
anova(fit1, fit3, test = "Chisq")

## Q4
summary(lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars))

## Q5
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)

fit5 <- lm(y~x)
hatvalues(model = fit5)

## Q6
dfbetas(model = fit5)

fit61 <- lm(y ~ x)
fit62 <- lm(y[-5] ~ x[-5])

plot(y~x,pch=18,col="dark red",cex=2)
abline(lm(y~x),col='red',lwd=2,lty=1.5)
points(y[-5] ~ x[-5], col=rgb(0,100,0,50,maxColorValue=255), pch=16, cex=3)
abline(lm(y[-5] ~ x[-5]),col="orange",lwd=2,lty=1.5)

DFBETA <- fit61$coef[2] - fit62$coef[2]
dfbeta(fit61)[10]

lm.influence(fit61)
summary(fit61)

DFBETAS <- DFBETA/(sqrt((summary(fit62)$sigma^2)*diag(summary(fit61)$cov.unscaled)[2]))
DFBETAS
dfbetas(fit61)[10]


