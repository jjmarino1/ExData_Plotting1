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


#Show each sub_metring level by day of the week
melted_data <- melt(select(filtered_table,CombinedDate, Sub_metering_1, Sub_metering_2, Sub_metering_3), id.vars = "CombinedDate")

#Extract the date from CombinedDate to create a new variable representing each day
melted_data$Day <- as.Date(melted_data$CombinedDate)

#Create DayInterval representing each day
melted_data$DayInterval <- as.factor(melted_data$Day)

melted_data$value <- as.numeric(melted_data$value)

#Plot the lines with continuous lines for each day
sub_meter <- ggplot(melted_data, aes(x = CombinedDate, y = value, colour = variable, group = variable)) +
    geom_line() +
    scale_x_datetime(date_labels = "%a", breaks = "1 day") +
    theme(legend.position = c(.9,.9), legend.title = element_blank()) + 
    ylab("Energy sub metering") +
    xlab("")

png("plot3.png")

sub_meter

dev.off()