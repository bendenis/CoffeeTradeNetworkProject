library(igraph)
library(dplyr)
library(ggplot2)
library(tidyr)
library(GGally)
library(stringr)

coffeeG05 = read_graph("coffeeG05.gml", format = "gml")


df = data.frame(cl = centr_clo(coffeeG05)$res,
                bt = centr_betw(coffeeG05)$res, 
                dg = degree(coffeeG05),
                country = names(V(coffeeG05)))

df %>% filter(cl > 0.05, cl < 0.12) %>% select(cl,bt,dg) %>% ggpairs()

df %>% filter(cl <= 0.05) %>% select(cl,bt,dg) %>% ggpairs()

lay = layout.davidson.harel(coffeeG05)
plot(coffeeG05, vertex.color = degree(coffeeG05, mode = "out"), layout = lay, 
     vertex.label.cex = 0.5, vertex.size = 5, 
     edge.arrow.size = 0.2, edge.width = 0.2)

lay2 = layout.graphopt(coffeeG05)
plot(coffeeG05, vertex.color = degree(coffeeG05, mode = "out"), layout = lay2, 
     vertex.label.cex = 0.5, vertex.size = 5, 
     edge.arrow.size = 0.2, edge.width = 0.2)


lay3 = layout.gem(coffeeG05)
plot(coffeeG05, vertex.color = degree(coffeeG05, mode = "out"), layout = lay3, 
     vertex.label.cex = 0.5, vertex.size = 5, 
     edge.arrow.size = 0.2, edge.width = 0.2)

lay4 = layout.kamada.kawai(coffeeG05)
plot(coffeeG05, vertex.color = degree(coffeeG05, mode = "in"), layout = lay4, 
     vertex.label.cex = 0.5, vertex.size = 5, 
     edge.arrow.size = 0.2, edge.width = 0.2)


