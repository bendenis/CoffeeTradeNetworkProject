Ethiopia_out = E(coffeeG05)[from("Ethiopia")]
Ethiopia_in = E(coffeeG05)[to("Ethiopia")]
sub_names = c(str_replace(attributes(Ethiopia_out)$vnames, "Ethiopia\\|", ""),
              str_replace(attributes(Ethiopia_in)$vnames, "\\|Ethiopia$", ""),
              "Ethiopia")
ETH_sub = induced_subgraph(coffeeG05, vids = sub_names)

lay3 = layout.kamada.kawai(ETH_sub)
plot(ETH_sub, vertex.color = degree(ETH_sub, mode = "in"), layout = lay3, 
     vertex.label.cex = 0.5, vertex.size = degree(ETH_sub, mode = "out"), 
     edge.arrow.size = 0.2, edge.width = 0.2)


tri = triangles(ETH_sub)
tri_df = matrix(names(tri), byrow = TRUE)
dim(tri_df) = c(3,1210)
tri_df = data.frame(t(tri_df))
colnames(tri_df) = c("a","b","c")

tri_df %>% filter(a == "Ethiopia", b == "Belgium")

cli = cliques(ETH_sub, max = 3, min = 3)





country = "Ethiopia"
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


str_replace(attributes(E(coffeeG05)[from(set[1])])$vnames, str_c(set[1],"\\|"), "")




