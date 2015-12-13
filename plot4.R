## plot4.R
# 
# Exploratory Data Analysis (Coursera)
#     Course Project 1
# 
# Generate Plot 4

if(!"data.table" %in% installed.packages()) {
        install.packages("data.table")
}

library(data.table)

# Load datafile
D <- read.csv("household_power_consumption.txt", na.strings = "?", sep = ";")

# convert to data.table. Add POSIXct representation of Date and Time
D <- data.table(D)
D[, "datetime":={ dt = paste(Date, Time); as.POSIXct(strptime(dt, "%d/%m/%Y %H:%M:%S")) }]

# Filter down to just the specified Dates Feb 1-2, 2007
setkey(D, Date)
D <- D[Date %in% c("1/2/2007", "2/2/2007")]

# Create plot 4
png("plot4.png")
par(mfcol=c(2,2))

with(D, {
        # 1st subplot
        plot(datetime, Global_active_power, type="l", xlab="",
                ylab="Global Active Power")

        # 2nd subplot
        plot(datetime, Sub_metering_1, type="l", xlab="", 
             ylab="Energy sub metering")
        lines(datetime, Sub_metering_2, col="red")
        lines(datetime, Sub_metering_3, col="blue")
        legend("topright", lty="solid", col=c("black","red","blue"), bty="n",
                legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

        # 3rd subpplot
        plot(datetime, Voltage, type="l")

        # 4th subplot
        plot(datetime, Global_reactive_power, type="l")
})
dev.off()
