library(dplyr)
dim(mtcars)
str(mtcars)

names(mtcars)

## select function from the dplyr package helps to select all the columns between mpg and hp
head(select(mtcars, mpg:hp))

## similarly minus sign removes the columns from the selection
head(select(mtcars, -(mpg:hp)))

## had we not had dplyr package, how would we have done it?
i <- match("mpg", names(mtcars))
j <- match("hp", names(mtcars))
head(mtcars[-(i:j)])

## filter function will subset rows
mtcars.fil <- filter(mtcars, mpg > 20) ## can give complex conditions using & |
mtcars.fil

## arrange function will sort rows based on condition
mtcars.arng <- arrange(mtcars, cyl)
mtcars.arng

head(mtcars.arng)
tail(mtcars.arng)

## arrange desc order
mtcars.arng <- arrange(mtcars, desc(cyl))
head(mtcars.arng)
tail(mtcars.arng)


## rename function will rename the columns to be a bit more intituitve
mtcars_rename <- rename(mtcars, horsepower = hp)
head(mtcars_rename)

## mutate function will add rows or columns depending on the condition specified
mtcars_mut <- mutate(mtcars, mpg_mean = mpg - mean(mpg, na.rm=TRUE))
head(select(mtcars_mut, mpg, mpg_mean))

## second example mutate function
mtcars_mut2 <- mutate(mtcars, tempmpg = factor(1* (mpg>20), labels = c("mpg_low","mpg_high")))
highlow <- group_by(mtcars_mut2, tempmpg)

head(highlow)

summarize(highlow, disp = mean(disp), hp = max(hp))


