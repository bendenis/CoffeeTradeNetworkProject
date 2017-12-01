library(tmap)
library(plyr)

data(World)

ETH_trade_2010 = read.csv("Ethiopia/ETHG10measures.csv")
ETHG10 = read_graph("Ethiopia/ETHG10.gml", format = "gml")


ETH_trade_2010$iso_a3 = str_replace(str_extract(ETH_trade_2010$country,":[A-Z]*"),":","")

World@data = join(World@data, ETH_trade_2010, by = 'iso_a3')

world_map = tm_shape(World) + tm_borders() + tm_fill("betweenness_centrality")
world_map


lay3 = layout.kamada.kawai(ETHG10)
plot(ETHG10, vertex.color = betweenness(ETHG10), layout = lay3, 
     vertex.label.cex = 0.5, vertex.size = degree(ETHG10, mode = "out"), 
     edge.arrow.size = 0.2, edge.width = 0.2)
