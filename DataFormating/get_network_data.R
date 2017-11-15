## read codes for all of the countries in the database

library(jsonlite)
all_countries = fromJSON(url("https://comtrade.un.org/data/cache/reporterAreas.json"))
country_id = all_countries$results[,1][-1]  # use as r and p

##


## Function to make API calls
## Default parameters set for exports of raw coffee.
get_Comtrade  = function(url = "http://comtrade.un.org/api/get?", maxrec = 500, type = "C", freq = "A", px = "HS"
                         ,ps = "2015%2C2010%2C2005",r ,p = "all" ,rg = "2", cc = "090111%2C090112", fmt = "csv"){
        require(jsonlite)
        require(stringr)
        
        str = str_c(url, "max=", maxrec, "&" #maximum no. of records returned
                       ,"type=",type,"&" #type of trade (c=commodities)
                       ,"freq=",freq,"&" #frequency
                       ,"px=",px,"&" #classification
                       ,"ps=",ps,"&" #time period
                       ,"r=",r,"&" #reporting area
                       ,"p=",p,"&" #partner country
                       ,"rg=",rg,"&" #trade flow
                       ,"cc=",cc,"&" #classification code
                       ,"fmt=",fmt        #Format
                       ,sep = ""
        )
        
        dt = read.csv(str,header = TRUE)
        if(str_detect(dt[,1],"Request JSON or XML format")){ # this case/error occures when API doesn't return data
                return(NA)
        }else{
                return(dt)
        }
}


#### Coffee ####

## download the data for each country into a list of separate data frames.
## discard empty data frames (API returned no results)
data = lapply(1:length(country_id), function(i) get_Comtrade(r = country_id[i]))
dt = data[!is.na(data)]

## combine all separate datasets into one
DT = rbind(dt[[1]],dt[[2]])

for(i in 3:length(dt)){
        
        DT = rbind(DT,dt[[i]])
        
}

## write the combined dataset to a csv file:
write.csv(DT, file = "/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/Project/Data/coffee_trade.csv")

## select columns of interest and filter rows where exporter or importer was 'world':
DTT = DT %>% select(Reporter,Partner,Trade.Value..US..,Netweight..kg.,Reporter.ISO, Partner.ISO, Commodity, Year) %>% filter(Partner != "World", Reporter != "World")

## write the clean dataset to a csv file:
write.csv(DTT, file = "/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/Project/Data/clean_coffee_trade.csv")


#### Natural Gas ####
## download the data in the same way as above, but changing the commodity to natural gas
gas_data = lapply(1:length(country_id), function(i) get_Comtrade(r = country_id[i], cc = "271111%2C271121"))
dt = gas_data[!is.na(gas_data)]
DT = rbind(dt[[1]],dt[[2]])

for(i in 3:length(dt)){
        
        DT = rbind(DT,dt[[i]])
        
}


write.csv(DT, file = "/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/Project/Data/gas_trade.csv")

DTT = DT %>% select(Reporter,Partner,Trade.Value..US..,Netweight..kg.,Reporter.ISO, Partner.ISO, Commodity, Year) %>% filter(Partner != "World", Reporter != "World")

write.csv(DTT, file = "/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/Project/Data/clean_gas_trade.csv")


