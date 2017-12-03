df = read.csv("Data/Cleaned/clean_coffee_trade.csv")
df = df[,-1]
GG = graph_from_data_frame(df, directed = T)

df05 = df %>% filter(Year == 2005)
df05 = df05 %>% group_by(Reporter, Partner) %>% summarise(Trade_Value_USD = sum(Trade_Value__US__), 
                                                          Netweight_KG = sum(Netweight__kg_), 
                                                          Commodity = "Coffee")

coffeeG05 = graph_from_data_frame(df05, directed = T)

tri = triangles(coffeeG05)
tri_df = matrix(names(tri), byrow = TRUE)
dim(tri_df) = c(3,nrow(tri_df)/3)
tri_df = data.frame(t(tri_df))
colnames(tri_df) = c("a","b","c")

DF = tri_df %>% filter(a == "Ethiopia:ETH")
Gtri1 = induced_subgraph(coffeeG05, vids = as.character(unlist(DF[1,])))
plot(Gtri1, edge.width = log(edge_attr(Gtri1)$Trade_Value_USD),
     edge.color = 7, edge.arrow.width = log(edge_attr(Gtri1)$Trade_Value_USD)/2,
     arrow.color = "black")

