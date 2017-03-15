d1 = date()
d1

class(d1)

d2 = Sys.Date()
d2

class(d2)

format(d2, "%A - %b/%d/%y")

x = c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z = as.Date(x, "%d%b%y")
z

z[1] - z[2]

as.numeric(z[1] - z[2])

julian(d2)

library(lubridate)

ymd("20161218")
mdy("12.18.2016")
dmy("18/12/2016")

ymd_hms("20161218 10 15 13")

ymd_hms("20161218 10 15 13", tz = "EST")

?Sys.timezone

?POSIXlt
