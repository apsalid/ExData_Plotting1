library(dplyr)
library(lubridate)

## This is for the axis labels to be in English 
## because in my system is in greek
Sys.setlocale("LC_TIME", "English")

## Downloaded the dataset locally, unzip and setwd
mydf <- read.table("./household_power_consumption.txt", sep = ";",  header=TRUE, stringsAsFactors=F, na.strings="?")

## We will use dplyr
df <- tbl_df(mydf)

## Subsetting to the dates
df <- mutate(df, Date = as.Date(Date,format="%d/%m/%Y"))
df <- filter(df, Date >= "2007-02-01" & Date <= "2007-02-02")
## Changing format of dates
df <- mutate(df, dateandtimenewcolumn = paste(as.Date(Date), Time) )
df <- mutate(df, dateandtimenewcolumn = as.POSIXct(dateandtimenewcolumn) ) 

## The plot here
plot(df[[3]]~df[[10]], type="l",ylab="Global Active Power (kilowatts)", xlab="")

## Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

