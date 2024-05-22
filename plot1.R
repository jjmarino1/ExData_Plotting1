#Download and Load the file
subfolder <- "Exploratory Data Analysis - Project 1"

#download and unzip csv file
if (!(file.exists(subfolder))){
    dir.create(subfolder)
    print('Directory Created')
}

URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"


if (!(file.exists(file.path(getwd(),subfolder,"project1.csv")))){
    print('File Downloaded')
    
}

download.file(URL,"ExploratoryProject1.zip",mode = "wb")

unzip("ExploratoryProject1.zip", exdir = "Exploratory Data Analysis - Project 1")

raw_table <- read.table("C:/Users/jjmar/OneDrive/Documents/R---Data-Science-Class/Temporary_For_version_control/HelloWorld/Exploratory Data Analysis - Project 1/household_power_consumption.txt", sep = ";", header = TRUE)

#Transform date/time columns to data type dates
filtered_table <- raw_table %>% mutate(CombinedDate = paste(Date, Time, sep = " ")) %>% mutate(raw_table, Date = as.Date(Date,"%d/%m/%Y"), CombinedDate = strptime(CombinedDate, format = "%d/%m/%Y %H:%M:%S")) %>% filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

filtered_table$Day <- as.Date(filtered_table$CombinedDate)

filtered_table$DayInterval <- as.factor(filtered_table$Day)

filtered_table$CombinedDate <- as.POSIXct(filtered_table$CombinedDate)





##Create graph for measuring Power by frequency
png("plot1.png")

hist(as.numeric(filtered_table$Global_active_power), main = "Global Active Power", ylab = "Frequency", xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()



