library(igraph)
library(stringr)
library(purrr)
library(GGally)
library(dplyr)

coffee_trade_2010 = read.csv("Data/Decorated/coffeeG10measures.csv")
coffeeG10 = read_graph("Data/iGraphs/coffeeG10.gml", format = "gml")



sim_ij = function(G, i, j){
        
        set1 = neighbors(G, v =  V(G)[i], mode = "all")
        set2 = neighbors(G, v =  V(G)[j], mode = "all")
        inter_set = intersect(set1, set2)
        sim = length(inter_set)/(length(set1)+length(set2))
        return(sim)
}

simV = vector(mode = "numeric", length = length(V(coffeeG10))^2)
for(i in 1:207){
        a = 207*(i-1) + 1
        b = 207*i
        sim_vals = unlist(lapply(1:207, function(j) sim_ij(coffeeG10, i, j)))
        simV[a:b] = sim_vals
}
dim(simV) = c(207,207)
heatmap(simV)



simM = similarity(coffeeG10, vids = V(coffeeG10), mode = "all", method = "jaccard")

hcl1 = hclust(as.dist(simM))
clusts = cutree(hcl1, k = 4)

lay3 = layout.davidson.harel(coffeeG10)
plot(coffeeG10, vertex.color = clusts, layout = lay3, 
     vertex.label.cex = 0.5, 
     edge.arrow.size = 0.2, edge.width = 0.2)
