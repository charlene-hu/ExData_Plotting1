wd <- readline(prompt="Please enter working directory:")
setwd(wd)
writeLines("setting directory...")
directory <- getwd()

#install sqlpdf when it is not already installed
"xtable" %in% rownames(installed.packages('sqlpdf'))

writeLines("installing library...")
library(sqldf)
library(datasets)

writeLines("reading and processing data file...")
df <- read.csv.sql(paste0(directory, '/household_power_consumption.txt'), sql= 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"', header = TRUE, sep = ";")
df[df == '?'] <- NA
df$DateTime = strptime(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")

writeLines("ploting...")
png(paste0(directory, '/plot3.png'))
par(mfrow=c(1,1))
with(df, plot(DateTime, Sub_metering_1, type='l', xlab='',ylab='Energy sub metering'))
with(df, lines(DateTime, Sub_metering_2, col='red'))
with(df, lines(DateTime, Sub_metering_3, col='blue'))
legend("topright", col = c("black","blue", "red"),
       lwd=2, lty=c(1,1,1), cex = .6,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
closeAllConnections() 
writeLines("plot3.png created in working directory.")