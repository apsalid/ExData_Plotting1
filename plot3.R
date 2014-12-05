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

## The plot is here
with(df, {
plot(Sub_metering_1~dateandtimenewcolumn, type="l", ylab="Energy sub metering", xlab="")
lines(Sub_metering_2~dateandtimenewcolumn,col='Red')
lines(Sub_metering_3~dateandtimenewcolumn,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()


