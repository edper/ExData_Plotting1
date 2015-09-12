# Read-in the value from the source text file
household_power_consumption <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
# Convert the string Date into an actual Date type in R
household_power_consumption[,1] <- as.Date(household_power_consumption[,1],format="%d/%m/%Y")
# Filter out 2007/02/01 to 2007/02/02 consumption as required by the project
household_power_consumption_feb0102 <- subset(household_power_consumption, Date == "2007-02-01" | Date == "2007-02-02")
# Save to PNG file the histogram to be generated
png("plot1.png")
# Generate the histogram using the subset data earlier
hist(as.numeric(household_power_consumption_feb0102$Global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Powers (kilowatts)")
# Turn off the output to file to return back to screen
dev.off()
