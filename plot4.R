# Read-in the value from the source text file
household_power_consumption <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
# Convert the string Date into an actual Date type in R
household_power_consumption[,1] <- as.Date(household_power_consumption[,1],format="%d/%m/%Y")
# Filter out 2007/02/01 to 2007/02/02 consumption as required by the project
household_power_consumption_feb0102 <- subset(household_power_consumption, Date == "2007-02-01" | Date == "2007-02-02")
# Add a new field DateTime and convert Date and Time type in R
household_power_consumption_feb0102 <- transform(household_power_consumption_feb0102, DateTime = strptime(paste(Date,Time), format="%Y-%m-%d %H:%M:%S"))
# Save to PNG file the graph to be generated
png("plot4.png")
# Change the parameters for displaying the graph to two graphs per column
par(mfcol = c(2, 2))

# Generate the four (4) graphs
with( household_power_consumption_feb0102, {

  plot(DateTime, Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab = "")
  
  plot(DateTime, Sub_metering_1 + Sub_metering_2 + Sub_metering_3, type="n", ylab = "Energy sub metering", xlab = "", ylim = c(0,max(Sub_metering_1)))
  lines(DateTime, Sub_metering_1, type="l", col="black")
  lines(DateTime, Sub_metering_2, type="l", col="red")
  lines(DateTime, Sub_metering_3, type="l", col="blue")
  legend("topright", pch = "-", col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lwd = 3, bty = "n")
  
  with(household_power_consumption_feb0102, plot(DateTime, Voltage, type="l"))
  
  with(household_power_consumption_feb0102, plot(DateTime, Global_reactive_power, type="l"))
  
})
# Turn off the output to file to return back to screen
dev.off()
# Restore back to 1 graph at a time display
par(mfcol=c(1,1))
