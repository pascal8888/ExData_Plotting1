with(df_tidy,plot(DateTime,Global_active_power, ylab = "Global Active Power (kilowatts)",type="l",xlab=""))
dev.copy(png, file="plot2.png")
dev.off()
