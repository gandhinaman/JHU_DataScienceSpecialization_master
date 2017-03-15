x <- list (aardvark = 1:5, caaple = 8:10)
x$a

x <- c(1,2,NaN,3,NA,5)
bad <- is.nan(x)
y <- x[!bad]

y
bad

x <- 4L
class(x)

x <- 4
class(x)


x <- c(4, TRUE)
class(x)

x <- c(4, "a", TRUE)
class(x)


x <- c(1,3, 5)
y <- c(3, 2, 10)
rbind(x, y)

x <- c(1,3, 5)
y <- c(3, 2, 10)
cbind(x, y)


x <- list(2, "a", "b", TRUE)
y <- x[[1]] 
class(y)

x <- list(2, "a", "b", TRUE)
y <- x[[2]] 
class(y)
y

x <- 1:4
y <- 2
z <- x + y
class(z)
z

x <- 1:4
y <- 2:3
z <- x + y
z
class(z)


x <- c(17, 14, 4, 5, 13, 12, 10) 
z <- x[x > 10] <- 4
z
x
x>10

getwd()
setwd("C:\\Users\\ng7815\\Desktop\\Coursera_DataScience\\02_JohnHopkins_RProgramming\\Quiz")

x <- read.csv(file = "hw1_data.csv")
colnames(x)

x[1:2,]

head(x,2)
tail(x,2)

x[47,]

x[154,]

bad = is.na(x$Ozone)
bad

sum(bad) + sum(!bad)

xm <- x[!bad,]
mean(xm$Ozone)


a <- subset(x, x$Ozone > 31 & x$Temp > 90)
a
mean(a$Solar.R)

b <- subset(x, x$Month == 6)
b
mean(b$Temp)

d <- subset(x, x$Month == 5)
d = d[!is.na(d$Ozone),]
d
max(d$O)


