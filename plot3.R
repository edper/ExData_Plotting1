# Read-in the value from the source text file
household_power_consumption <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
# Convert the string Date into an actual Date type in R
household_power_consumption[,1] <- as.Date(household_power_consumption[,1],format="%d/%m/%Y")
# Filter out 2007/02/01 to 2007/02/02 consumption as required by the project
household_power_consumption_feb0102 <- subset(household_power_consumption, Date == "2007-02-01" | Date == "2007-02-02")
# Add a new field DateTime and convert Date and Time type in R
household_power_consumption_feb0102 <- transform(household_power_consumption_feb0102, DateTime = strptime(paste(Date,Time), format="%Y-%m-%d %H:%M:%S"))
# Save to PNG file the graph to be generated
png("plot3.png")
# Prepare the graph without lines
with(household_power_consumption_feb0102, plot(DateTime, Sub_metering_1 + Sub_metering_2 + Sub_metering_3, type="n", ylab = "Energy sub metering", xlab = "", ylim = c(0,max(Sub_metering_1))))
# Generate the line graph for each Sub_metering values
with(household_power_consumption_feb0102, lines(DateTime, Sub_metering_1, type="l", col="black"))
with(household_power_consumption_feb0102, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(household_power_consumption_feb0102, lines(DateTime, Sub_metering_3, type="l", col="blue"))
# Create the legend for the graph
legend("topright", pch = "-", col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lwd = 3)
# Turn off the output to file to return back to screen
dev.off()
