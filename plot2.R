## plot2.R
# 
# Exploratory Data Analysis (Coursera)
#     Course Project 1
# 
# Generate Plot 2

if(!"data.table" %in% installed.packages()) {
        install.packages("data.table")
}

library(data.table)

# Load datafile
D <- read.csv("household_power_consumption.txt", na.strings = "?", sep = ";")

# convert to data.table. Add POSIXct representation of Date and Time
D <- data.table(D)
D[, "Realdate":={ dt = paste(Date, Time); as.POSIXct(strptime(dt, "%d/%m/%Y %H:%M:%S")) }]

# Filter down to just the specified Dates Feb 1-2, 2007
setkey(D, Date)
D <- D[Date %in% c("1/2/2007", "2/2/2007")]

# Create plot 2
png("plot2.png")
plot(D$Realdate, D$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")
dev.off()
