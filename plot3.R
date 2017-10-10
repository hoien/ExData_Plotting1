
# Loading data

df5 <- read.table("household_power_consumption.txt", na.strings = "?", nrows = 5, sep = ";", header = TRUE)
df5colclass <- sapply(df5, class)

query_string <- "select * from file where Date in ('1/2/2007', '2/2/2007')"
power_consumption <- sqldf::read.csv2.sql(file = "household_power_consumption.txt", sql = query_string, colClasses = df5colclass, na.strings = "?")

query_string <- "select * from file where Date in ('1/2/2007', '2/2/2007')"
power_consumption <- read.csv2.sql(file = "household_power_consumption.txt", sql = query_string, colClasses = df5colclass, na.strings = "?")

# Convert to data variable

power_consumption <- dplyr::mutate(power_consumption, datetime = paste(Date, Time, sep = ":"))

power_consumption[["datetime"]] <- strptime(power_consumption$datetime,format='%d/%m/%Y:%H:%M:%S')

# plotting

#Range of plot

xrange <- power_consumption$datetime
yrange <- power_consumption$Sub_metering_1

png("plot3.png", width = 480, height = 480)


# set up the plot 
plot(xrange, yrange, type="n", ylab = "Energy sub metering", xlab = "" )

# include the lines
lines(power_consumption$datetime, power_consumption$Sub_metering_1)
lines(power_consumption$datetime, power_consumption$Sub_metering_2, col  = "red")
lines(power_consumption$datetime, power_consumption$Sub_metering_3, col = "blue")
legend("topright", pch = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()