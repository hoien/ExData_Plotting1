

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

power_consumption <- dplyr::mutate(power_consumption, datetime = paste(Date, Time, sep = ":"))

png("plot1.png", width = 480, height = 480)
hist(power_consumption$Global_active_power, 
     main = "Global Active Power", col = "red", 
     xlab = "Global Active Power (kilowatts)", yaxp = c(0, 1200, 6))
dev.off()