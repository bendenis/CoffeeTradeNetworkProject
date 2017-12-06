library(tmap)
library(plyr)

data(World)



World@data = join(World@data, ____________, by = 'iso_a3')
World$clust = as.factor(World$clust)

world_map = tm_shape(World) + tm_borders() + tm_fill("GDP")
world_map
