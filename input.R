flights <- read.csv("~/Documents/985:211 Statisitcs/12-ggplot2:dplyr-Flights between Australia and China-650/flights.csv")
View(flights)                                                                                                     

flights <- as.data.frame(flights)

library(dplyr)

length(flights)
count(flights)
dim(flights)

flights$`Month,In_Out,Australian_City,International_City,Airline,Route,Port_Country,Port_Region,Service_Country,Service_Region,Stops,All_Flights,Max_Seats,Year,Month_num`<- NULL
dim(flights)
str(flights)

flights_into_australia <- flights %>% filter(In_Out == "I")
View(flights_into_australia)

flights_into_australia_from_china <- flights_into_australia %>% filter(Port_Country == "China")
View(flights_into_australia_from_china)

dim(flights_into_australia_from_china)
str(flights_into_australia_from_china)

table(flights_into_australia_from_china$Australian_City)
prop.table(table(flights_into_australia_from_china$Australian_City))
round(prop.table(table(flights_into_australia_from_china$Australian_City)),2)

table(flights_into_australia_from_china$International_City)
prop.table(table(flights_into_australia_from_china$International_City))
round(prop.table(table(flights_into_australia_from_china$International_City)),2)

plotdata <- data.frame(flights_into_australia_from_china$Year, flights_into_australia_from_china$Australian_City, flights_into_australia_from_china$International_City, flights_into_australia_from_china$Service_Country, flights_into_australia_from_china$All_Flights)
colnames(plotdata) <- c("year","city_AUS","city_CHN", "Service_Country","flight_number")
View(plotdata)
plotdata <- plotdata %>% filter(year < "2018")
View(plotdata)


str(plotdata)
plotdata$year <- as.character(plotdata$year)
str(plotdata)

library(ggplot2)

ggplot(data=plotdata, aes(x=year, y=city_CHN, fill=city_AUS)) +
   geom_bar(stat = "identity", position = position_dodge()) +
   theme_linedraw() +
   scale_fill_brewer(palette = "Reds") +
   ggtitle("Flights between Australia and China") + xlab("Year") + ylab("City in China") + 
   labs(fill = "City in Australia")

ggplot(data = plotdata, aes(x=year, y=flight_number))+
   geom_bar(stat = "identity", fill="dark red")+
   theme_linedraw()+
   ggtitle("Total Flights number between Australia and China") + xlab("Year") + ylab("Total Flights Number") 

ggplot(plotdata, aes(x=year, y=Service_Country, fill=city_AUS)) + 
   +  geom_bar(position = "stack", stat = "identity")

