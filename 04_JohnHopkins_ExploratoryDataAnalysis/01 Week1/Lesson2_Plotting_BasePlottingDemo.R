## Exploratory Data Analysis
## Week 1 - Lesson 2: Plotting -- Base plotting demonstration

x <- rnorm(100)
hist(x)
y <- rnorm(100)
plot(x,y)
z <- rnorm(100)
plot(x,z)
par(mar = c(2,2,2,2))
plot(x,z)
par(mar = c(4,4,2,2))
plot(x,z)

plot(x,y, pch = 20)
plot(x,y, pch = 19)
plot(x,y, pch = 2)
plot(x,y, pch = 3)
plot(x,y, pch = 4)
example("points")

x <- rnorm(100)
y <- rnorm(100)
plot(x,y, pch=20)
title("Scatterplot X vs. Y")
text(-2, -2, "Label")
legend("topleft", legend = "Data", pch=20)

fit <- lm(y ~ x)
abline(fit)

abline(fit, lwd = 3)
abline(fit, lwd = 1, col = "blue")

plot(x,y, xlab = "Weight", ylab = "Height", main = "Scatterplot", pch = 20)
legend("topright", legend = "Data", pch = 20)
fit <- lm(y ~ x)
abline(fit, lwd = 3, col = "red")

z <- rpois(100,2)
par(mfrow  = c(2,1))
plot(x, y, pch = 20)
plot(x,z,pch=4)
par("mar")


