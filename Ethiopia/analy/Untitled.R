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





country = "Viet Nam"
graph = coffeeG05

n1 = str_replace(attributes(E(graph)[from(country)])$vnames, str_c(country,"\\|"), "")
n2 = str_replace(attributes(E(graph)[to(country)])$vnames, str_c("\\|",country,"$"), "")
set = c(n1[n1 %in% n2],country)
subG = induced_subgraph(coffeeG05, vids = set)


plot(subG, vertex.color = degree(subG, mode = "in"), layout = layout.kamada.kawai(subG), 
     vertex.label.cex = 0.5, vertex.size = degree(subG, mode = "in"), 
     edge.arrow.size = 0.2, edge.width = 0.2)



