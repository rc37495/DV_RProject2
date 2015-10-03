require("jsonlite")
require("RCurl")
require("dplyr")
require("ggplot2")
require("tidyr")
require("scales")

# make transfer.date continuous
# ndf$TRANSFER.DATE <- as.Date(as.character(ndf$TRANSFER_DATE), format="%m/%d/%Y %H:%M")

# rename columns
ndf <- rename(ndf, Ownership_Type= DURATION)
ndf <- rename(ndf, Price= PRICE)
ndf <- rename(ndf, Property_Type= PROPERTY_TYPE)

# expand relevant data names
ndf$Ownership_Type <- as.character(ndf$Ownership_Type)
ndf$Ownership_Type[ndf$Ownership_Type == "F"] <- "Freehold Estate"
ndf$Ownership_Type[ndf$Ownership_Type == "L"] <- "Leasehold Estate"

ndf$Property_Type <- as.character(ndf$Property_Type)
ndf$Property_Type[ndf$Property_Type == "D"] <- "Detached"
ndf$Property_Type[ndf$Property_Type == "S"] <- "Semi-Detached"
ndf$Property_Type[ndf$Property_Type == "T"] <- "Terraced"
ndf$Property_Type[ndf$Property_Type == "F"] <- "Flats/Maisonettes"

# make graph
ndf %>% mutate(cost = cume_dist(Price)) %>% filter(cost <= .90 | cost >= .999) %>% ggplot(aes(x = Property_Type, y = Price, color = Ownership_Type)) + geom_jitter(position = "jitter") + ggtitle("Property Type vs Ownership Duration Type") + xlab("Property Type") + scale_y_continuous(labels = comma)
