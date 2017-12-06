library(sand)
library(ergm)
library(network)
library(mixer)

data(lazega)

A = get.adjacency(lazega)
Vdf = get.data.frame(lazega, what = "vertices")
net = as.network(as.matrix(A), directed=FALSE)


set.vertex.attribute(net, "Office", Vdf$Office) 
set.vertex.attribute(net, "Practice",Vdf$Practice) 
set.vertex.attribute(net, "Gender", Vdf$Gender)
set.vertex.attribute(net, "Seniority", Vdf$Seniority)

summary.statistics(net ~ edges + kstar(2) + kstar(3) + triangle)

lazega_ergm_formula = formula(net ~ edges + gwesp(log(3), fixed=TRUE)
                              + nodemain("Seniority") + nodemain("Practice")
                              + match("Practice") + match("Gender") + match("Office"))

set.seed(42)
lazega_ergm_fit = ergm(lazega_ergm_formula)
summary(lazega_ergm_fit)
anova(lazega_ergm_fit)


gof_lazega_ergm = gof(lazega_ergm_fit)
par(mfrow = c(2,2))
plot(gof_lazega_ergm)



