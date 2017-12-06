
all_triplets$X = as.character(all_triplets$X)
all_triplets$Y = as.character(all_triplets$Y)
all_triplets$Z = as.character(all_triplets$Z)

combinations1 = list(vector(length = nrow(all_triplets)))
for(i in 1:nrow(all_triplets)){
        
        section =  all_triplets[all_triplets$X == "Ethiopia:ETH" & 
                                        all_triplets$Y == all_triplets[i,"Y"] & 
                                        all_triplets$Z == all_triplets[i,"Z"],]
        combinations1[[i]] = str_c(as.character(as.integer(section$edge_type)), collapse = "")
}
table(unlist(combinations1))


combinations2 = list(vector(length = nrow(all_triplets)))
for(i in 1:nrow(all_triplets)){
        
        section =  all_triplets[all_triplets$X == "Ethiopia:ETH" & 
                                        all_triplets$Z == all_triplets[i,"Y"] & 
                                        all_triplets$Y == all_triplets[i,"Z"],]
        combinations2[[i]] = str_c(as.character(as.integer(section$edge_type)), collapse = "")
}
table(unlist(combinations2))


combinations3 = map2(combinations1, combinations2, ~ str_c(.x,.y, sep = ":"))
table(unlist(combinations3))

combinations4 = list(vector(length = nrow(all_triplets)))
for(i in 1:nrow(all_triplets)){
        section = all_triplets[all_triplets$X == all_triplets[i,"X"] & 
                                       all_triplets$Y == "Ethiopia:ETH" & 
                                       all_triplets$Z == all_triplets[i,"Z"],]
        combinations4[[i]] = str_c(as.character(as.integer(section$edge_type)), collapse = "")
}
table(unlist(combinations4))

combinations5 = list(vector(length = nrow(all_triplets)))
for(i in 1:nrow(all_triplets)){
        section = all_triplets[all_triplets$X == "Ethiopia:ETH" & 
                                       all_triplets$Y == all_triplets[i,"Z"] & 
                                       all_triplets$Z == all_triplets[i,"X"],]
        combinations5[[i]] = str_c(as.character(as.integer(section$edge_type)), collapse = "")
}
table(unlist(combinations5))

combinations6 = map2(combinations4, combinations5, ~ str_c(.x,.y, sep = ":"))
table(unlist(combinations6))

all_combinations = unlist(list(unlist(combinations3),unlist(combinations6)))


all_categories = unlist(mclapply(unlist(all_combinations), categorize_triplet))
