library(igraph)
library(stringr)
library(ggplot2)
library(purrr)
library(GGally)
library(dplyr)

coffee_trade_2010 = read.csv("Data/Decorated/coffeeG10measures.csv")
coffeeG10 = read_graph("Data/iGraphs/coffeeG10.gml", format = "gml")

E(coffeeG10)[1]

adjM = as.matrix(get.adjacency(coffeeG10))
vM = adjM
dim(vM) = c(42849,1)


partner = rep(names(adjM[,1]),207)


df = data.frame(export = vM[,1], importer = rep(names(adjM[,1]),207), exporter = rep(names(adjM[,1]),each = 207))

make_diffs = function(mydata, var){
        vec = vector(mode = "numeric", length = nrow(mydata)^2)
        for(i in 1:nrow(mydata)){
                
                diffs = unlist(lapply(mydata[var], function(x) mydata[i,var] - x))
                a = 207*(i-1) + 1
                b = 207*i
                vec[a:b] = diffs
        }
        
        return(vec)
        
}

closeness_centrality_diffs = make_diffs(coffee_trade_2010, 'closeness_centrality')
df$closeness_centrality_diffs = closeness_centrality_diffs

indegree_centrality_diffs = make_diffs(coffee_trade_2010, 'indegree_centrality')
df$indegree_centrality_diffs = indegree_centrality_diffs

outdegree_centrality_diffs = make_diffs(coffee_trade_2010, 'outdegree_centrality')
df$outdegree_centrality_diffs= outdegree_centrality_diffs

betweenness_centrality_diffs = make_diffs(coffee_trade_2010, 'betweenness_centrality')
df$betweenness_centrality_diffs = betweenness_centrality_diffs


df$export = as.factor(df$export)

df$iso_a3 = str_replace(str_extract(df$exporter,":[A-Z]*"),":","")

df = df %>% filter(df$iso_a3 %in% World$iso_a3)

wdf = World@data
wdf$iso_a3 = as.character(wdf$iso_a3)
wdf = wdf[wdf$iso_a3 %in% df$iso_a3,]

gdp_diffs = make_diffs(wdf, "gdp_md_est")
df$gdp_diffs = gdp_diffs

pop_diffs = make_diffs(wdf, "pop_est")
df$pop_est = pop_diffs

mean_terms_diffs = make_diffs(wdf, "mean_terms")
df$mean_terms_diffs= df$mean_terms_diffs


df %>% select(export, closeness_centrality_diffs,
              indegree_centrality_diffs, outdegree_centrality_diffs,
              betweenness_centrality_diffs, gdp_diffs, mean_terms_diffs) %>% 
        ggpairs(mapping = aes(col = export, alpha = 0.3))


svm1 = ksvm(export ~ gdp_diffs + pop_est + outdegree_centrality_diffs + betweenness_centrality_diffs, data = df,
            kernel = "rbfdot")
table(predict(svm1))


