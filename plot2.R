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

writeLines("ploting in standard output device...")
par(mfrow=c(1,1))
with(df, plot(DateTime, Global_active_power, type='l', xlab='',ylab='Global Active Power (kilowatts)'))

writeLines("create png file in working directory...")
dev.copy(png, paste0(directory, '/plot2.png'))
dev.off()
closeAllConnections() 