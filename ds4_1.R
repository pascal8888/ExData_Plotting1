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
df_tidy <- mutate(df,DateTime = paste(df$Date,df$Time))
df_tidy$DateTime <- strptime(df_tidy$DateTime,"%d/%m/%Y %H:%M:%S")
df_tidy <- df_tidy[,3:10]
## rm(list=ls())
