def graph_to_df(G):

        a5 = np.array(G.nodes())
        a1 = np.array(list(nx.get_node_attributes(G,"closeness_centrality").values()))
        a2 = np.array(list(nx.get_node_attributes(G,"indegree_centrality").values()))
        a3 = np.array(list(nx.get_node_attributes(G,"outdegree_centrality").values()))
        a4 = np.array(list(nx.get_node_attributes(G,"betweenness_centrality").values()))
        
        df = pd.DataFrame(np.stack((a5,a1,a2,a3,a4), axis = -1), columns = ["country","closeness_centrality",
                                                                                     "indegree_centrality",
                                                                                     "outdegree_centrality",
                                                                                     "betweenness_centrality"])
        
        df = df.set_index('country')
        
        mtdf =  pd.DataFrame(nx.get_node_attributes(G,"mean_terms"), index = ["mean_terms"]).T
        tedf =  pd.DataFrame(nx.get_node_attributes(G,"total_exported"), index = ["total_exported"]).T
        tidf =  pd.DataFrame(nx.get_node_attributes(G,"total_imported"), index = ["total_imported"]).T
        
        mtdf = mtdf.reindex(df.index)
        tedf = tedf.reindex(df.index)
        tidf = tidf.reindex(df.index)
        
        df = df.join(mtdf).join(tedf).join(tidf)
        return(df)


graph_measures_dfs = [graph_to_df(gg) for gg in all_graphs]

      
df.to_csv("/Users/bendenisshaffer/Box Sync/UM Fall 2017/SI 608/CoffeeTradeNetworkProject/Data/Gmeasures.csv")
