##  Get the source data set and extract in working directory (only downloads and unzips if it does not already exist)
if (!file.exists("source_datasetDS4_1.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","source_datasetDS4_1.zip", mode="wb", "auto", TRUE)
}
if (!file.exists("household_power_consumption.txt")) {
    unzip("source_datasetDS4_1.zip")
}
library(sqldf)
## use read.csv.sql to use SQL select syntax to pull the date range subset from the data.
df <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007') ", sep=";", header=T)
## Convert Date and Time variables from character class to Date and Time Classes
library(dplyr)
## first combine Date & Time variables into a new column
df_tidy <- mutate(df,DateTime = paste(df$Date,df$Time))
## now set the new column to class POSIXxx
df_tidy$DateTime <- strptime(df_tidy$DateTime,"%d/%m/%Y %H:%M:%S")
## drop the original Date and Time columns
df_tidy <- df_tidy[,3:10]
## rm(list=ls())
## clean up unneeded variables from the environment
rm(df)
