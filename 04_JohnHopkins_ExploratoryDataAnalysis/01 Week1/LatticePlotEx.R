library(lattice)

set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)

y <- x + f - f* x + rnorm(100, sd = 0.5)

f <- factor(f, labels = c("Group 1", "Group 2"))

xyplot(y ~ x | f, layout = c(2,1))
## Doesn't work as you cannot later add features to the xyplot
fit <- lm(y ~ x)
abline(fit)

## Custom panel function

xyplot(y ~ x | f, panel = function(x,y,...){
    panel.xyplot(x,y,...)
    panel.abline(lm(y~x), lty = 2, col = "red", lwd = 2)
    })

## linear model line
xyplot(y ~ x | f, panel = function(x,y,...){
    panel.xyplot(x, y)
    panel.abline(h = median(y), lty = 2, col = "red", lwd = 2)
})

## add regression line
xyplot(y ~ x | f, panel = function(x,y,...){
    panel.xyplot(x, y)
    panel.lmline(x,y, lty = 2, col = "red", lwd = 2)
})