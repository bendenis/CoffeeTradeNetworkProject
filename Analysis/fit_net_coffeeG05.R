library(tmap)
library(plyr)

data(World)
coffeeG05 = read_graph("Data/iGraphs/coffeeG05.gml", format = "gml")


names = vertex.attributes(coffeeG05)$name
iso_a3 = str_replace(str_extract(names,":[A-Z]*"),":","")
df = data.frame(name = names, iso_a3)

coffeeG05 = set_vertex_attr(coffeeG05, name = "Continent", value = df$continent)
coffeeG05 = set_vertex_attr(coffeeG05, name = "Subregion", value = df$subregion)
coffeeG05 = set_vertex_attr(coffeeG05, name = "Population", value = df$pop_est)
coffeeG05 = set_vertex_attr(coffeeG05, name = "GDP", value = df$gdp_cap_est)

vertex_attr(coffeeG05)



Vdf = get.data.frame(coffeeG05, what = "vertices")
coffeeG05sub = induced_subgraph(coffeeG05, vids = Vdf$name[complete.cases(Vdf)])
A = get.adjacency(coffeeG05sub)
Vdf = get.data.frame(coffeeG05sub, what = "vertices")
net = as.network(as.matrix(A), directed=FALSE)

set.vertex.attribute(net, "GDP", Vdf$GDP)
set.vertex.attribute(net, "Subregion",Vdf$Subregion) 
set.vertex.attribute(net, "Population", Vdf$Population)
set.vertex.attribute(net, "Continent", Vdf$Continent)

summary.statistics(net ~ edges + kstar(2) + kstar(3) + triangle)

coffeeG05_ergm_formula = formula(net ~ edges + gwesp(log(3), fixed=TRUE)
                              + nodemain("GDP") + nodemain("Population")
                              + match("Continent") + match("Subregion"))

set.seed(42)
coffeeG05_ergm_fit = ergm(coffeeG05_ergm_formula)
summary(coffeeG05_ergm_fit)
anova(coffeeG05_ergm_fit)

gof_coffeeG05_ergm = gof(coffeeG05_ergm_fit)
par(mfrow = c(2,2))
plot(gof_coffeeG05_ergm)


