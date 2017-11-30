library(tmap)
library(plyr)

data(World)

coffee_trade_2010$iso_a3 = str_replace(str_extract(coffee_trade_2010$country,":[A-Z]*"),":","")

World@data = join(World@data,coffee_trade_2010, by = 'iso_a3')
World$clust = as.factor(World$clust)

world_map = tm_shape(World) + tm_borders() + tm_fill("betweenness_centrality")
world_map
