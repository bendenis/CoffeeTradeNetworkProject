library(igraph)
library(stringr)
library(purrr)
library(GGally)
library(dplyr)

coffee_trade_2010 = read.csv("Data/Decorated/coffeeG10measures.csv")
coffeeG10 = read_graph("Data/iGraphs/coffeeG10.gml", format = "gml")



simM = similarity(coffeeG10, vids = V(coffeeG10), mode = "all", method = "dice")

hcl1 = hclust(as.dist(simM))
clusts = cutree(hcl1, k = 4)



set_vertex_attr(coffeeG10, "cluster", index = V(coffeeG10), clusts)

lay3 = layout.davidson.harel(coffeeG10)
plot(coffeeG10, vertex.color = clusts, layout = lay3, 
     vertex.label.cex = 0.5,
     edge.arrow.size = 0.2, edge.width = 0.2)



coffee_trade_2010$clust = clusts
coffee_trade_2010 %>% filter(clust == 2) %>% summary()





