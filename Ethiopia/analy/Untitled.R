library(igraph)
library(dplyr)

coffeeG05 = read_graph("Data/iGraphs/coffeeG15.gml", format = "gml")
coffeeG10 = read_graph("Data/iGraphs/coffeeG10.gml", format = "gml")




tri = triangles(coffeeG05)
tri_df = matrix(names(tri), byrow = TRUE)
dim(tri_df) = c(3,12694)
tri_df = data.frame(t(tri_df))
colnames(tri_df) = c("a","b","c")

DF = tri_df %>% filter(a == "Ethiopia:ETH")


for(i in 1:nrow(DF)){
        plot(induced_subgraph(coffeeG05, vids = as.character(unlist(DF[i,]))))
}




country = "Ethiopia:ETH"
graph = coffeeG05

n1 = names(unlist(ego(graph, order = 1, nodes = country, mode = "out")))
n2 = names(unlist(ego(graph, order = 1, nodes = country, mode = "in")))
set = n1[n1 %in% n2]

subG = induced_subgraph(coffeeG05, vids = set)
plot(subG, vertex.color = degree(subG, mode = "in"), layout = layout.kamada.kawai(subG), 
     vertex.label.cex = 0.5, vertex.size = degree(subG, mode = "in"), 
     edge.arrow.size = 0.2, edge.width = 0.2)

n1G = induced_subgraph(coffeeG05, vids = n1)
plot(n1G, vertex.color = degree(n1G, mode = "in"), layout = layout.kamada.kawai(n1G), 
     vertex.label.cex = 0.5, vertex.size = degree(n1G, mode = "out"), 
     edge.arrow.size = 0.2, edge.width = 0.2)

n2G = induced_subgraph(coffeeG05, vids = n2)
plot(n2G, vertex.color = degree(n2G, mode = "out"), layout = layout.kamada.kawai(n2G), 
     vertex.label.cex = 0.5, vertex.size = degree(n2G, mode = "in"), 
     edge.arrow.size = 0.2, edge.width = 0.2)



n12 = names(unlist(ego(graph, order = 2, nodes = country, mode = "in")))
n22 = names(unlist(ego(graph, order = 2, nodes = country, mode = "out")))
set2 = n12[n12 %in% n22]

subG2 = induced_subgraph(coffeeG05, vids = set2)
plot(subG2, vertex.color = degree(subG2, mode = "in"), layout = layout.kamada.kawai(subG2), 
     vertex.label.cex = 0.5, vertex.size = degree(subG2, mode = "in"), 
     edge.arrow.size = 0.2, edge.width = 0.2)

n12G = induced_subgraph(coffeeG05, vids = n12)
plot(n12G, vertex.color = degree(n12G, mode = "in"), layout = layout.kamada.kawai(n12G), 
     vertex.label.cex = 0.5, vertex.size = degree(n12G, mode = "out"), 
     edge.arrow.size = 0.2, edge.width = 0.2)

n22G = induced_subgraph(coffeeG05, vids = n22)
plot(n22G, vertex.color = degree(n22G, mode = "out"), layout = layout.kamada.kawai(n22G), 
     vertex.label.cex = 0.5, vertex.size = degree(n22G, mode = "in"), 
     edge.arrow.size = 0.2, edge.width = 0.2)

