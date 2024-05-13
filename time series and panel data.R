install.packages("AER")
library("AER")
data("UKNonDurables")
UKNonDurables
install.packages("xts")
library("xts")
plot(UKNonDurables)
class(tsp(UKNonDurables)) #tsp shows properties of time series starting time ending time frequency
time(UKNonDurables) #data has 2 properties time and non time ..this gives time properties - all the years
window()#subset
window(UKNonDurables, end = c(1956,4))
window(UKNonDurables, end = c(1957,3))
window(UKNonDurables,start = c(1955,3), end = c(1957,3))
#how to make a data time series 
library(xts)
str(ex_matrix)
#create the object data using 5 random numbers 
data <- rnorm(5)
set.seed(100)
data
#create dates as a data class object starting from 2016-01-01
dates <- seq(as.Date("2016-01-01"), length = 5, by = "days")
dates
#use xts() to create smith
smith <- xts(x= data, order.by = dates)
?xts
#create bday (1899-05-08) using a POSIXct date class object
bday <- as.POSIXct("1899-05-08")
?as.POSIXct
#Create hayek and add a new attribute called born 
hayek <- xts(x =data, order.by = dates, born = bday)
hayek
#at the core of both xts and zoo is a simple Rmatrix with a few additional  attributes.The most important of these attribute is the index. The index holds all info we need for xts to treat our data as a time series. 
#When  working with time, it will sometimes be necessary to seperate your time series into its core data and index atttribute for additional analysis and manipulation. 
#The core data is the matrix portion of xts. You can separate this from the xts object using coredata(). The index portion of the xts object is available using the index() function.
#Note that both of these functions are methods from the zoo class, which xts extends.
class(hayek)
# Extract the core data of hayek
hayek_core <- coredata(hayek)
hayek_core
# View the class of hayek_core
class(hayek_core)
# Extract the index of hayek
hayek_index <- index(hayek)
hayek_index
# View the class of hayek_index
class(hayek_index)
#panel data
#The base R Date class handles dates without times. 
#The default format is “YYYY/m/d” or “YYYY-m-d”
myDate <- as.Date("2017/11/6")
myDate
class(myDate)

#%d day of the month (number)
#%m Month(number)
#%b Month(abbreviated)
#%B Month(full name)
#%y Year(2 digit)
#%Y Year(4 digit)

as.Date("12/31/1999", format = "%m/%d/%Y")
as.Date("April 13, 1978", format = "%b %d, %Y")
as.Date("25JAN17", format = "%d%b%y")
myDate 
date1 <- myDate, format = "%B %d, %Y
format(myDate, "%B")
as.numeric(format(myDate, "%Y"))
weekdays(Sys.time())
quarters(Sys.time())
months(myDate)
quarters(myDate)
seq(from = as.Date("2017/6/1"), 
    to = as.Date("2017/7/31"), 
    by = "1 week")
seq(from = as.Date("2017/6/1"), 
    to = as.Date("2017/7/31"), 
    by = "4 days")
seq(from = as.Date("2017/6/1"), 
    to = as.Date("2018/7/31"), 
    by = "1 month")
#The base R POSIXt classes allow for dates and times with control for time zones. 
#2 POSIXt sub‐classes available in R: POSIXct and POSIXlt. 
#POSIXct class represents date‐time values as the signed number of seconds since midnight GMT (UTC – universal time, coordinated) 1970‐01‐01. 
#POSIXlt class represents date‐time values as a named list with elements for the second (sec), minute (min), hour (hour), day of the month (mday), month (mon), year (year), day of the week (wday), day of the year (yday), and daylight savings time flag (isdst), respectively.
#“YYYY-mm-dd hh:mm:ss” or “YYYY/mm/dd hh:mm:ss” with the hour, minute and second information being optional.
myDateTime <- "2017-06-11 22:10:35"
as.Date("2017-06-11 22:10:35")
class("myDateTime")
t1
t2
myDateTime
t1 <- as.POSIXct(myDateTime)
t2 <- as.POSIXlt(myDateTime)
myDateTime.POSIXlt
unclass(t1)
unclass(t2)
#POSIXlt is a 'list type' with components you can access as you do
#POSIXct is a 'compact type' that is essentially just a number
#You almost always want POSIXct for comparison and effective storage (eg in a data.frame, or to index a zoo or xts object with) and can use POSIXlt to access components.
#Be warned, though, that the components follow C library standards so e.g. the current years is 115 (as you always need to add 1900), weekdays start at zero etc pp.

#The lubridate package provides a variety of functions, which make it easier to work with dates and times in R.
#The lubridate package makes parsing of date-times easy and fast by providing functions such as ymd(), ymd_hms(), dmy(), dmy_hms(), mdy(), among others.

library(lubridate)
ymd(19991215)

ymd_hm(199912151533, tz = "Asia/Calcutta")
?ymd
Sys.timezone()
mdy("April 13, 1978")
#year(), month(), week(), mday(), wday(), yday(),hour(), minute() and second()
today <- Sys.time()
?yday
today
year(today)
month(today)
month(today, label = TRUE)
mday(today) # day number
wday(today)#, label = TRUE)
library(zoo)
as.yearmon(today)
format(as.yearmon(today), "%B %Y")
as.yearqtr(today)