# load and use plyr library
library(plyr)
# load ggplot2 library for plotting
library(ggplot2)

# load data set
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get maryland data
marylandNEI <- NEI[NEI$fips=="24510",]

# calculate the total emission for each year
marylandTotalEmissionByYear <- ddply(marylandNEI, .(year, type), summarise, sum=sum(Emissions))

# init a png device, the default resolution is 480x480 
png(filename="plot2.png")

# plot historgram on global active power
plot(marylandTotalEmissionByYear$year, marylandTotalEmissionByYear$sum, xlab="Year", ylab="Total Emission (tons)", type= "l")

# close png device and save the file
dev.off()

