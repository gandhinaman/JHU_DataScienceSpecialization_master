## Q1/2
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)

fit <- lm(y ~ x)
summary(fit)
summary(fit)$sigma


##Q3
mtcars <- mtcars
x <- mtcars$wt; y<- mtcars$mpg

fit <- lm(y ~ x)
summary(fit)

newdata = data.frame(x=mean(x))
predict(fit, newdata, interval = "confidence")

#confint(fit, x ,level=0.95)

## Q5
newdata = data.frame(x=3)
predict(fit, newdata, interval = "predict")

## Q6/7
fit <- lm(y ~ I(x/2))
summary(fit)
confint(fit, I(x/2) ,level=0.95)

## Q8
fit1 <- lm(y ~ x)
summary(fit1)

fit2 <- lm(y ~ I(x+2))
summary(fit2)

summary(fit2)$coeff[1] == summary(fit1)$coeff[1] - 2*summary(fit1)$coeff[2]

## Q9
fit1 <- lm(y ~ x)
summary(fit1)

fit2 <- lm(y ~ 1)
summary(fit2)

sum(fit1$residuals^2) / sum(fit2$residuals^2)


