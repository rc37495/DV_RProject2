ndf %>% select(TOWN_CITY,DISTRICT,PRICE,OLD_NEW) %>% filter(DISTRICT == "LEEDS") %>% arrange(OLD_NEW) %>% ggplot(aes(x = TOWN_CITY, y = PRICE, colour = OLD_NEW)) + geom_bar(stat="identity") + labs(x = "Town/City",y = "Price",title="Leeds District") + theme(axis.text.x=element_text(angle=50,color="black"))

