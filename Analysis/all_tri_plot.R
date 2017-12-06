library(igraph)

g1 = graph.formula("X"-+"Y","Y"-+"Z")
g2 = graph.formula("X"+-"Y","Y"-+"Z")
g3 = graph.formula("X"++"Y","Y"-+"Z")
g4 = graph.formula("X"-+"Y","Y"+-"Z")
g5 = graph.formula("X"-+"Y","Y"++"Z")
g6 = graph.formula("X"++"Y","Y"++"Z")

g7 = graph.formula("X"-+"Y", "Y"-+"Z", "Z"-+"X")
g8 = graph.formula("X"-+"Y", "Y"-+"Z", "Z"+-"X")
g9 = graph.formula("X"-+"Y", "Y"-+"Z", "Z"++"X")
g10 = graph.formula("X"-+"Y", "Y"+-"Z", "Z"++"X")
g11 = graph.formula("X"-+"Y", "Y"++"Z", "Z"+-"X")
g12 = graph.formula("X"-+"Y", "Y"++"Z", "Z"++"X")
g13 = graph.formula("X"++"Y", "Y"++"Z", "Z"++"X")

par(mfrow = c(4,4), cex = 0.5)

lay = layout.circle(g1)
plot(g1,vertex.size = 40, vertex.color = degree(g1, mode = "out") + 1, layout = lay, main = "AAD", edge.curved = 0.1,
     vertex.size = 30, edge.arrow.size = 0.1, vertex.label.cex = 2)
plot(g2,vertex.size = 40, vertex.color = degree(g2, mode = "out") + 1, layout = lay, main = "BAD", edge.curved = 0.1,
     vertex.size = 30, edge.arrow.size = 0.1, vertex.label.cex = 2)
plot(g3,vertex.size = 40, vertex.color = degree(g3, mode = "out") + 1, layout = lay, main = "CAD", edge.curved = 0.1,
     vertex.size = 30, edge.arrow.size = 0.1, vertex.label.cex = 2)
plot(g4,vertex.size = 40, vertex.color = degree(g4, mode = "out") + 1, layout = lay, main = "ABD", edge.curved = 0.1,
     vertex.size = 30, edge.arrow.size = 0.1, vertex.label.cex = 2)
plot(g5,vertex.size = 40, vertex.color = degree(g5, mode = "out") + 1, layout = lay, main = "ACD", edge.curved = 0.1,
     vertex.size = 30, edge.arrow.size = 0.1, vertex.label.cex = 2)
plot(g6,vertex.size = 40, vertex.color = degree(g6, mode = "out") + 1, layout = lay, main = "CCD", edge.curved = 0.1,
     vertex.size = 30, edge.arrow.size = 0.1, vertex.label.cex = 2)


plot(g7,vertex.size = 40, vertex.color = degree(g7, mode = "out") + 1, layout = lay, main = "AAA", edge.curved = 0.1,
     vertex.size = 30, edge.arrow.size = 0.1, vertex.label.cex = 2)
plot(g8,vertex.size = 40, vertex.color = degree(g8, mode = "out") + 1, layout = lay, main = "AAB", edge.curved = 0.1,
     vertex.size = 30, edge.arrow.size = 0.1, vertex.label.cex = 2)
plot(g9,vertex.size = 40, vertex.color = degree(g9, mode = "out") + 1, layout = lay, main = "AAC", edge.curved = 0.1,
     vertex.size = 30, edge.arrow.size = 0.1, vertex.label.cex = 2)
plot(g10,vertex.size = 40, vertex.color = degree(g10, mode = "out") + 1, layout = lay, main = "ABC", edge.curved = 0.1,
     vertex.size = 30, edge.arrow.size = 0.1, vertex.label.cex = 2)
plot(g11,vertex.size = 40, vertex.color = degree(g11, mode = "out") + 1, layout = lay, main = "ACB", edge.curved = 0.1,
     vertex.size = 30, edge.arrow.size = 0.1, vertex.label.cex = 2)
plot(g12,vertex.size = 40, vertex.color = degree(g12, mode = "out") + 1, layout = lay, main = "ACC", edge.curved = 0.1,
     vertex.size = 30, edge.arrow.size = 0.1, vertex.label.cex = 2)
plot(g13,vertex.size = 40, vertex.color = degree(g13, mode = "out") + 1, layout = lay, main = "CCC", edge.curved = 0.1,
     vertex.size = 30, edge.arrow.size = 0.1, vertex.label.cex = 2)

plot(1:10, type = "n", frame.plot = F, xaxt='n', yaxt='n', xlab = "", ylab = "")
legend("bottomright", legend = c("0-outdegree","1-outdegree","2-outdegree"), 
       col = c(1,2,3), pch = c(20,20,20), pt.cex = 4)

