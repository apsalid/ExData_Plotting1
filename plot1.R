library(dplyr)
library(lubridate)

## Downloaded the dataset locally, unzip and setwd
mydf <- read.table("./household_power_consumption.txt", sep = ";",  header=TRUE, stringsAsFactors=F)

## We will use dplyr
df <- tbl_df(mydf)

## Omiting incomplete lines 
df <- na.omit(df) 
## or 
## df <- filter(df, complete.cases(df))

## Subsetting to the dates
df <- mutate(df, Date = as.Date(Date,format="%d/%m/%Y"))
df <- filter(df, Date >= "2007-02-01" & Date <= "2007-02-02")

## The histogram here
hist(as.numeric(as.character(df[[3]])), main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()